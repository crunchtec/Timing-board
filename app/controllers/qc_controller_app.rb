require 'sinatra'
require 'sinatra/reloader'

require_relative '../models/serial_port'
require 'benchmark'
require_relative '../models/control_interface'
require_relative '../models/definitions'


  set :root, File.expand_path("..", __dir__)
  set :method_override, true
  # set :bind, '0.0.0.0'

  include Definitions

  control_interface = ControlInterface.new
  serial_port = SerialPort.new
  serial_port.connect


  def serial_control(serial_port, change_list, control_interface)
    change_list.keys.each do |change_item|
      self.send(INTERFACE_SERIAL_CONTROL[change_item],serial_port, control_interface) unless INTERFACE_SERIAL_CONTROL[change_item].nil?
    end
  end

  def set_channel_a_delay(serial_port, control_interface)
    command = "#{P1_DELAY} #{control_interface.read(:channel_a_delay)}e-9"
    send_serial_command(serial_port, control_interface, command)
    get_channel_a_delay(serial_port, control_interface)
    puts command.inspect
  end

  def get_channel_a_delay(serial_port, control_interface)
    command = "#{P1_DELAY}?"
    send_serial_command(serial_port, control_interface, command)
  end

  def changed(control_interface, params)
    change_list = {}
    params.keys.map do |param|
      parameter = PARAM_CONTROL[param]
      form_value = params[param]
      # puts control_interface
      # puts "Control Interface Channel A name custom: #{control_interface.channel_a_name_custom}"
      # puts "Control Interface Channel A name custom: #{control_interface.channel_a_delay}"
      # puts "Control Interface Channel A name custom: #{control_interface.main_switch_status}"
      if !control_interface.same?(parameter, form_value)
        control_interface.update(parameter, form_value)
        change_list[parameter] = control_interface.read(parameter)
      end
    end
    change_list
  end

  def rebuild_control_interface(serial_port, control_interface)
    if serial_port.sp.nil? || serial_port.closed?
      control_interface.update(:serial_port_status, MSG_NOT_CONNECTED)
      control_interface.update(:serial_port_status_label, LABEL_DANGER)
      control_interface.update(:reconnect_button_show, HTML_SHOW)
      control_interface.update(:send_command_access, DISABLED)
      control_interface.update(:main_interface_access, DISABLED)
    else
      control_interface.update(:serial_port_status, MSG_CONNECTED)
      control_interface.update(:serial_port_status_label, LABEL_SUCCESS)
      control_interface.update(:reconnect_button_show, HTML_HIDE)
      control_interface.update(:send_command_access, ENABLED)
      control_interface.update(:main_interface_access, ENABLED)
    end
    {
      :serial_response => control_interface.read(:response_history).first || "",
      :command_history_count => control_interface.read(:command_history).count,
      :serial_port_status => control_interface.read(:serial_port_status),
      :serial_port_status_label => control_interface.read(:serial_port_status_label),
      :reconnect_button_show => control_interface.read(:reconnect_button_show),
      :send_command_access => control_interface.read(:send_command_access),
      :main_interface_access => control_interface.read(:main_interface_access),
      :channel_a_delay => control_interface.read(:channel_a_delay),
      :channel_a_delay_unit => control_interface.read(:channel_a_delay_unit),
      :step_size_list => control_interface.read(:step_size_list),
      :step_size => control_interface.read(:step_size),
      :channel_a_delay_min => control_interface.read(:channel_a_delay_min),
      :channel_a_delay_max => control_interface.read(:channel_a_delay_max),
      :command_history => control_interface.read(:command_history),
      :response_history => control_interface.read(:response_history),
      :channel_a_name_custom => control_interface.read(:channel_a_name_custom)
    }
    
    # puts "!!!!!!! Value of reconnect button: #{output[:reconnect_button_show]}"
    # puts "!!!!!!! Value of send command: #{output[:send_command_access]}"
  end

  get "/" do
    # change_list = changed(control_interface, params)
    # puts "List of changed parameters: #{change_list}"

    @interface = rebuild_control_interface(serial_port, control_interface)

    erb:index, :locals => {
                          :response_time => control_interface.read(:response_time),
                          :main_switch => control_interface.main_switch_status,
                          :main_switch_status => control_interface.main_switch_status
                          }
  end

  post "/" do
    change_list = changed(control_interface, params)
    puts "List of changed parameters: #{change_list}"
    serial_control(serial_port, change_list, control_interface)
    redirect "/"
  end

  post "/send" do
    change_list = changed(control_interface, params)
    serial_response = send_serial_command(serial_port, control_interface, params["command"])
    # control_interface.update(:last_response_from_qc_board, serial_response)
    # control_interface.add_to_command_history(params["command"])
    redirect '/'
  end

  post "/mainswitch" do
    change_list = changed(control_interface, params)
    command = main_switch_command(control_interface.main_switch_status)
    serial_response = send_serial_command(serial_port, control_interface, command)
    redirect '/'
  end

  post "/deletehistory" do
    control_interface.empty_command_history
    redirect '/'
  end

  post "/retryserialport" do
    serial_port.connect
    redirect '/'
  end

  # private

  def send_serial_command(serial_port, control_interface, command)
    serial_response = serial_port.write(command)
    # control_interface.update(:last_response_from_qc_board, serial_response)
    control_interface.add_to_command_history(command, serial_response)
    return serial_response
  end

  def main_switch_command(switch_status)
    return MAIN_OUTPUT_ON if switch_status.eql?("checked")
    return MAIN_OUTPUT_OFF if switch_status.eql?("unchecked")
  end