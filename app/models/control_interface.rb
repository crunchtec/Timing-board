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
    @configuration_table[:board_uninitialized] = "true"
    @configuration_table[:current_view] = DEFAULT_VIEW
    @configuration_table[:main_switch] = "false"
    @configuration_table[:main_switch_status] = "unchecked"
    @configuration_table[:last_delay_tab] = "ch_a"

    @configuration_table[:channel_a_name_custom] = "Channel A"
    @configuration_table[:channel_a_name_official] = "Channel A"
    @configuration_table[:channel_a_width] = DEFAULT_PN_WIDTH
    @configuration_table[:channel_a_width_unit] = DEFAULT_PN_WIDTH_UNIT
    @configuration_table[:channel_a_width_min] = DEFAULT_PN_WIDTH_MIN
    @configuration_table[:channel_a_width_max] = DEFAULT_PN_WIDTH_MAX
    @configuration_table[:channel_a_delay] = DEFAULT_PN_DELAY
    @configuration_table[:channel_a_delay_unit] = DEFAULT_PN_DELAY_UNIT
    @configuration_table[:channel_a_delay_min] = DEFAULT_PN_DELAY_MIN
    @configuration_table[:channel_a_delay_max] = DEFAULT_PN_DELAY_MAX
    @configuration_table[:channel_a_polarity] = DEFAULT_PN_POLARITY
    @configuration_table[:channel_a_step_size] = DEFAULT_DELAY_STEP_SIZE

    @configuration_table[:channel_b_name_custom] = "Channel B"
    @configuration_table[:channel_b_name_official] = "Channel B"
    @configuration_table[:channel_b_width] = DEFAULT_PN_WIDTH
    @configuration_table[:channel_b_width_unit] = DEFAULT_PN_WIDTH_UNIT
    @configuration_table[:channel_b_width_min] = DEFAULT_PN_WIDTH_MIN
    @configuration_table[:channel_b_width_max] = DEFAULT_PN_WIDTH_MAX
    @configuration_table[:channel_b_delay] = DEFAULT_PN_DELAY
    @configuration_table[:channel_b_delay_unit] = DEFAULT_PN_DELAY_UNIT
    @configuration_table[:channel_b_delay_min] = DEFAULT_PN_DELAY_MIN
    @configuration_table[:channel_b_delay_max] = DEFAULT_PN_DELAY_MAX
    @configuration_table[:channel_b_polarity] = DEFAULT_PN_POLARITY
    @configuration_table[:channel_b_step_size] = DEFAULT_DELAY_STEP_SIZE

    @configuration_table[:channel_c_name_custom] = "Channel C"
    @configuration_table[:channel_c_name_official] = "Channel C"
    @configuration_table[:channel_c_width] = DEFAULT_PN_WIDTH
    @configuration_table[:channel_c_width_unit] = DEFAULT_PN_WIDTH_UNIT
    @configuration_table[:channel_c_width_min] = DEFAULT_PN_WIDTH_MIN
    @configuration_table[:channel_c_width_max] = DEFAULT_PN_WIDTH_MAX
    @configuration_table[:channel_c_delay] = DEFAULT_PN_DELAY
    @configuration_table[:channel_c_delay_unit] = DEFAULT_PN_DELAY_UNIT
    @configuration_table[:channel_c_delay_min] = DEFAULT_PN_DELAY_MIN
    @configuration_table[:channel_c_delay_max] = DEFAULT_PN_DELAY_MAX
    @configuration_table[:channel_c_polarity] = DEFAULT_PN_POLARITY
    @configuration_table[:channel_c_step_size] = DEFAULT_DELAY_STEP_SIZE

    @configuration_table[:channel_d_name_custom] = "Channel D"
    @configuration_table[:channel_d_name_official] = "Channel D"
    @configuration_table[:channel_d_width] = DEFAULT_PN_WIDTH
    @configuration_table[:channel_d_width_unit] = DEFAULT_PN_WIDTH_UNIT
    @configuration_table[:channel_d_width_min] = DEFAULT_PN_WIDTH_MIN
    @configuration_table[:channel_d_width_max] = DEFAULT_PN_WIDTH_MAX
    @configuration_table[:channel_d_delay] = DEFAULT_PN_DELAY
    @configuration_table[:channel_d_delay_unit] = DEFAULT_PN_DELAY_UNIT
    @configuration_table[:channel_d_delay_min] = DEFAULT_PN_DELAY_MIN
    @configuration_table[:channel_d_delay_max] = DEFAULT_PN_DELAY_MAX
    @configuration_table[:channel_d_polarity] = DEFAULT_PN_POLARITY
    @configuration_table[:channel_d_step_size] = DEFAULT_DELAY_STEP_SIZE

    @configuration_table[:delay_step_size_list] = ["1", "10", "100", "1000"]
    @configuration_table[:width_step_size_list] = ["0.01", "0.1", "1", "10"]
    @configuration_table[:command_history] = []
    @configuration_table[:response_history] = []
    @configuration_table[:response_time] = ""
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
    @configuration_table[:command_history].pop if @configuration_table[:command_history].count.eql?(COMMAND_HISTORY_MAX)
    @configuration_table[:command_history].unshift(command)
    add_to_response_history(serial_response)
  end

  def add_to_response_history(serial_response)
    @configuration_table[:response_history].pop if @configuration_table[:response_history].count.eql?(COMMAND_HISTORY_MAX)
    @configuration_table[:response_history].unshift(serial_response)
  end

  def empty_command_history
    @configuration_table[:command_history].clear
    @configuration_table[:response_history].clear
  end

end