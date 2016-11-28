require 'sinatra'
require 'sinatra/reloader'
require_relative '../lib/serial_port'
require 'benchmark'
require_relative '../lib/control_interface'
require 'pry'


PARAM_CONTROL = {"main_switch_status" => :main_switch_status,
                 "main_switch" => :main_switch,
                 "channel_a_delay" => :channel_a_delay,
                 "channel_a_name_custom" => :channel_a_name_custom}

# serial_port = SerialPort.new

control_interface = ControlInterface.new

set :bind, '0.0.0.0'


def main_switch(status)
  if status == "on"
    "checked"
  elsif status == nil
    "unchecked"
  end
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

get "/" do
  # switch_status = params["main_switch"]
  change_list = changed(control_interface, params)
  # response_time = Benchmark.measure { serial_port.write(params["command"]) }
  # serial_response = serial_port.write(params["command"])
  response_time = "Not available"
  serial_response = "QC is not connected..."
  erb:index, :locals => {:serial_response => serial_response, 
                         :response_time => response_time,
                         :main_switch => control_interface.main_switch_status,
                         :main_switch_status => main_switch(control_interface.main_switch_status),
                         :channel_a_name_custom => control_interface.channel_a_name_custom,
                         :channel_a_delay => control_interface.channel_a_delay}
end
