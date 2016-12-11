require 'sinatra'
require 'sinatra/reloader'

require_relative '../models/serial_port'
require 'benchmark'
require_relative '../models/control_interface'
require_relative '../models/definitions'


# class QcControllerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true
  # set :bind, '0.0.0.0'

  include Definitions
  # PARAM_CONTROL = {"main_switch_status" => :main_switch_status,
  #                 "main_switch" => :main_switch,
  #                 "channel_a_delay" => :channel_a_delay,
  #                 "channel_a_name_custom" => :channel_a_name_custom}
  # MSG_NOT_CONNECTED = "Not Connected"
  # HTML_HIDE = "hidden"
  # HTML_SHOW = ""
  # LABEL_WRONG = "warning"

  control_interface = ControlInterface.new
  serial_port = SerialPort.new
  serial_port.connect


  def changed(control_interface, params)
    change_list = {}
    params.keys.map do |param|
      parameter = PARAM_CONTROL[param]
      form_value = params[param]
      puts control_interface
      puts "Control Interface Channel A name custom: #{control_interface.channel_a_name_custom}"
      puts "Control Interface Channel A name custom: #{control_interface.channel_a_delay}"
      puts "Control Interface Channel A name custom: #{control_interface.main_switch_status}"
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
      :serial_response => control_interface.read(:last_response_from_qc_board),
      :command_history_count => control_interface.read(:command_history).count,
      :serial_port_status => control_interface.read(:serial_port_status),
      :serial_port_status_label => control_interface.read(:serial_port_status_label),
      :reconnect_button_show => control_interface.read(:reconnect_button_show),
      :send_command_access => control_interface.read(:send_command_access),
      :main_interface_access => control_interface.read(:main_interface_access)
    }
    
    # puts "!!!!!!! Value of reconnect button: #{output[:reconnect_button_show]}"
    # puts "!!!!!!! Value of send command: #{output[:send_command_access]}"
  end

  get "/" do
    # switch_status = params["main_switch"]
    change_list = changed(control_interface, params)
    puts "List of changed parameters: #{change_list}"


    #Temporary stopgap if no board is connected
    # response_time = "Not available"
    # serial_response = "QC is not connected..."
    @interface = rebuild_control_interface(serial_port, control_interface)

    erb:index, :locals => {
                          :response_time => control_interface.read(:response_time),
                          :main_switch => control_interface.main_switch_status,
                          :main_switch_status => control_interface.main_switch_status,
                          :channel_a_name_custom => control_interface.channel_a_name_custom,
                          :channel_a_delay => control_interface.channel_a_delay,
                          :command_history => control_interface.read(:command_history)
                          }
  end

  post "/send" do
    serial_response = serial_port.write(params["command"])
    # control_interface.update(:response_time, Benchmark.measure {
    #             control_interface.update(:serial_response, serial_port.write(params["command"]))
    #             })
    control_interface.update(:last_response_from_qc_board, serial_response)
    # response_time = "Response time: #{response_time} second(s)"
    # serial_response = serial_port.write(params["command"])
    # serial_response = "Last reponse from QC board: #{serial_response}"
    control_interface.add_to_command_history(params["command"])
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

# end