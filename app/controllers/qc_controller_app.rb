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
  board_uninitialized = true

  def initialize_board
    puts "...initializing board..."
  end

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

  def set_channel_b_delay(serial_port, control_interface)
    command = "#{P2_DELAY} #{control_interface.read(:channel_b_delay)}e-9"
    send_serial_command(serial_port, control_interface, command)
    get_channel_b_delay(serial_port, control_interface)
    puts command.inspect
  end

  def get_channel_b_delay(serial_port, control_interface)
    command = "#{P2_DELAY}?"
    send_serial_command(serial_port, control_interface, command)
  end

  def set_channel_c_delay(serial_port, control_interface)
    command = "#{P3_DELAY} #{control_interface.read(:channel_c_delay)}e-9"
    send_serial_command(serial_port, control_interface, command)
    get_channel_c_delay(serial_port, control_interface)
    puts command.inspect
  end

  def get_channel_c_delay(serial_port, control_interface)
    command = "#{P3_DELAY}?"
    send_serial_command(serial_port, control_interface, command)
  end

  def set_channel_d_delay(serial_port, control_interface)
    command = "#{P4_DELAY} #{control_interface.read(:channel_d_delay)}e-9"
    send_serial_command(serial_port, control_interface, command)
    get_channel_d_delay(serial_port, control_interface)
    puts command.inspect
  end

  def get_channel_d_delay(serial_port, control_interface)
    command = "#{P4_DELAY}?"
    send_serial_command(serial_port, control_interface, command)
  end

  def changed(control_interface, params)
    change_list = {}
    params.keys.map do |param|
      parameter = PARAM_CONTROL[param]
      form_value = params[param]
      if !control_interface.same?(parameter, form_value)
        control_interface.update(parameter, form_value)
        change_list[parameter] = control_interface.read(parameter)
      end
    end
    change_list
  end

  def rebuild_control_interface(serial_port, control_interface)
    if serial_port.sp.nil? || serial_port.closed?
      control_interface.update(:board_uninitialized, true)
      control_interface.update(:serial_port_status, MSG_NOT_CONNECTED)
      control_interface.update(:serial_port_status_label, LABEL_DANGER)
      control_interface.update(:reconnect_button_show, HTML_SHOW)
      control_interface.update(:send_command_access, DISABLED)
      control_interface.update(:main_interface_access, DISABLED)
    else
      if control_interface.read(:board_uninitialized)
        initialize_board
        control_interface.update(:board_uninitialized, false)
      end
      control_interface.update(:serial_port_status, MSG_CONNECTED)
      control_interface.update(:serial_port_status_label, LABEL_SUCCESS)
      control_interface.update(:reconnect_button_show, HTML_HIDE)
      control_interface.update(:send_command_access, ENABLED)
      control_interface.update(:main_interface_access, ENABLED)
    end
    {
      :main_switch => control_interface.main_switch_status,
      :main_switch_status => control_interface.main_switch_status,
      :current_view => control_interface.read(:current_view),
      :serial_response => control_interface.read(:response_history).first || "",
      :command_history => control_interface.read(:command_history),
      :command_history_count => control_interface.read(:command_history).count,
      :response_history => control_interface.read(:response_history),
      :serial_port_status => control_interface.read(:serial_port_status),
      :serial_port_status_label => control_interface.read(:serial_port_status_label),
      :reconnect_button_show => control_interface.read(:reconnect_button_show),
      :send_command_access => control_interface.read(:send_command_access),
      :main_interface_access => control_interface.read(:main_interface_access),
      :delay_step_size_list => control_interface.read(:delay_step_size_list),
      :last_delay_tab => control_interface.read(:last_delay_tab),
      :channel_a_delay => control_interface.read(:channel_a_delay),
      :channel_a_delay_unit => control_interface.read(:channel_a_delay_unit),
      :channel_a_delay_step_size => control_interface.read(:channel_a_delay_step_size),
      :channel_a_delay_min => control_interface.read(:channel_a_delay_min),
      :channel_a_delay_max => control_interface.read(:channel_a_delay_max),
      :channel_a_width => control_interface.read(:channel_a_width),
      :channel_a_width_unit => control_interface.read(:channel_a_width_unit),
      :channel_a_width_step_size => control_interface.read(:channel_a_width_step_size),
      :channel_a_width_min => control_interface.read(:channel_a_width_min),
      :channel_a_width_max => control_interface.read(:channel_a_width_max),
      :channel_a_name_custom => control_interface.read(:channel_a_name_custom),
      :channel_b_delay => control_interface.read(:channel_b_delay),
      :channel_b_delay_unit => control_interface.read(:channel_b_delay_unit),
      :channel_b_delay_step_size => control_interface.read(:channel_b_delay_step_size),
      :channel_b_delay_min => control_interface.read(:channel_b_delay_min),
      :channel_b_delay_max => control_interface.read(:channel_b_delay_max),
      :channel_b_name_custom => control_interface.read(:channel_b_name_custom),
      :channel_c_delay => control_interface.read(:channel_c_delay),
      :channel_c_delay_unit => control_interface.read(:channel_c_delay_unit),
      :channel_c_delay_step_size => control_interface.read(:channel_c_delay_step_size),
      :channel_c_delay_min => control_interface.read(:channel_c_delay_min),
      :channel_c_delay_max => control_interface.read(:channel_c_delay_max),
      :channel_c_name_custom => control_interface.read(:channel_c_name_custom),
      :channel_d_delay => control_interface.read(:channel_d_delay),
      :channel_d_delay_unit => control_interface.read(:channel_d_delay_unit),
      :channel_d_delay_step_size => control_interface.read(:channel_d_delay_step_size),
      :channel_d_delay_min => control_interface.read(:channel_d_delay_min),
      :channel_d_delay_max => control_interface.read(:channel_d_delay_max),
      :channel_d_name_custom => control_interface.read(:channel_d_name_custom)
    }
    
    # puts "!!!!!!! Value of reconnect button: #{output[:reconnect_button_show]}"
    # puts "!!!!!!! Value of send command: #{output[:send_command_access]}"
  end

  get "/" do
    # change_list = changed(control_interface, params)
    # puts "List of changed parameters: #{change_list}"

    @interface = rebuild_control_interface(serial_port, control_interface)

    erb:index, :locals => {
                          # :response_time => control_interface.read(:response_time),
                          # :main_switch => control_interface.main_switch_status,
                          # :main_switch_status => control_interface.main_switch_status
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

  get "/seewidth" do
    control_interface.update(:current_view, "width")
    redirect "/"
  end

  get "/seedelay" do
    control_interface.update(:current_view, "delay")
    redirect "/"
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