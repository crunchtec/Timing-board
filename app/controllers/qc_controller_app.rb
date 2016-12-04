require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative '../models/serial_port'
require 'benchmark'
require_relative '../models/control_interface'
# require 'pry'


# class QcControllerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true
  set :bind, '0.0.0.0'

  PARAM_CONTROL = {"main_switch_status" => :main_switch_status,
                  "main_switch" => :main_switch,
                  "channel_a_delay" => :channel_a_delay,
                  "channel_a_name_custom" => :channel_a_name_custom}

  serial_port = SerialPort.new
  control_interface = ControlInterface.new



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

  get "/" do
    # switch_status = params["main_switch"]
    change_list = changed(control_interface, params)
    puts "List of changed parameters: #{change_list}"


    #Temporary stopgap if no board is connected
    # response_time = "Not available"
    # serial_response = "QC is not connected..."
    
    erb:index, :locals => {
                          :serial_response => control_interface.read(:last_response_from_qc_board), 
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

# end