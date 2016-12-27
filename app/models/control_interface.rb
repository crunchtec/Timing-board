require_relative 'definitions'

class ControlInterface
  include Definitions

  attr_reader :configuration_table

  def initialize
    set_default
  end

  def set_default_channel_a
    #might use later on...
  end

  def set_default
    @configuration_table = {}
    @configuration_table[:main_switch] = "false"
    @configuration_table[:main_switch_status] = "unchecked"
    @configuration_table[:channel_a_name_custom] = "Channel A"
    @configuration_table[:channel_a_name_official] = "Channel A"
    @configuration_table[:channel_a_width] = "2"
    @configuration_table[:channel_a_width_unit] = "us"
    @configuration_table[:channel_a_width_min] = "1"
    @configuration_table[:channel_a_width_max] = "100"
    @configuration_table[:channel_a_delay] = "100"
    @configuration_table[:channel_a_delay_unit] = "ns"
    @configuration_table[:channel_a_delay_min] = "0"
    @configuration_table[:channel_a_delay_max] = "100000"
    @configuration_table[:channel_a_polarity] = "NORM"
    @configuration_table[:step_size] = "10"
    @configuration_table[:step_size_list] = ["1", "10", "100", "1000"]
    @configuration_table[:command_history] = []
    @configuration_table[:response_history] = []
    @configuration_table[:response_time] = ""
    @configuration_table[:last_response_from_qc_board] = ""
    @configuration_table[:serial_port_status_label] = LABEL_DANGER
    @configuration_table[:serial_port_status] = MSG_NOT_CONNECTED
    @configuration_table[:reconnect_button_show] = HTML_SHOW
    @configuration_table[:send_command_access] = DISABLED
    @configuration_table[:main_interface_access] = DISABLED 
    configuration_table
  end

  def all
    configuration_table
  end

  def channel_a_name_custom
    configuration_table[:channel_a_name_custom]
  end

  def channel_a_delay
    configuration_table[:channel_a_delay]
  end

  def main_switch
    configuration_table[:main_switch]
  end

  def main_switch_status
    configuration_table[:main_switch_status]
  end

  def update(parameter, value)
    @configuration_table[parameter] = value
  end

  def same?(parameter, value)
    configuration_table[parameter] == value
  end

  def read(parameter)
    configuration_table[parameter]
  end

  def add_to_command_history(command, serial_response)
    command = "< EMPTY >" if command.empty?
    @configuration_table[:command_history].unshift(command)
    add_to_response_history(serial_response)
  end

  def add_to_response_history(serial_response)
    @configuration_table[:response_history].unshift(serial_response)
  end

  def empty_command_history
    @configuration_table[:command_history].clear
  end

end