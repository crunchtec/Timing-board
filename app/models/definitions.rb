module Definitions

  PARAM_CONTROL = {"main_switch_status" => :main_switch_status,
                  "main_switch" => :main_switch,
                  "last_delay_tab" => :last_delay_tab,
                  "channel_a_name_custom" => :channel_a_name_custom,
                  "channel_a_delay" => :channel_a_delay,
                  "channel_a_delay_step_size" => :channel_a_delay_step_size,
                  "channel_a_width" => :channel_a_width,
                  "channel_a_width_step_size" => :channel_a_width_step_size,
                  "channel_b_name_custom" => :channel_b_name_custom,
                  "channel_b_delay" => :channel_b_delay,
                  "channel_b_delay_step_size" => :channel_b_delay_step_size,
                  "channel_b_width" => :channel_b_width,
                  "channel_b_width_step_size" => :channel_b_width_step_size,
                  "channel_c_delay" => :channel_c_delay,
                  "channel_c_name_custom" => :channel_c_name_custom,
                  "channel_c_delay_step_size" => :channel_c_delay_step_size,
                  "channel_d_delay" => :channel_d_delay,
                  "channel_d_name_custom" => :channel_d_name_custom,
                  "channel_d_delay_step_size" => :channel_d_delay_step_size
                  }
  MSG_NOT_CONNECTED = "Not Connected"
  MSG_CONNECTED = "Connected"
  HTML_HIDE = "hidden"
  HTML_SHOW = ""
  LABEL_SUCCESS = "success"
  LABEL_WARNING = "warning"
  LABEL_DANGER = "danger"
  ENABLED = ""
  DISABLED = "disabled"
  CONVERT_TO_NANOSECOND = 0.000000001
  COMMAND_HISTORY_MAX = 100

  INTERFACE_SERIAL_CONTROL = {:channel_a_delay => "set_channel_a_delay",
                              :channel_b_delay => "set_channel_b_delay",
                              :channel_c_delay => "set_channel_c_delay",
                              :channel_d_delay => "set_channel_d_delay",
                              :channel_a_width => "set_channel_a_width"
                              }

  #Default value definitions
  DEFAULT_VIEW = "delay"
  DEFAULT_REP_RATE = "1000" #us
  DEFAULT_OSCILLATOR_SOURCE_P0_MODE = "INT"
  DEFAULT_OSCILLATOR_SOURCE_P0_RATE = "80"  #MHz
  DEFAULT_OSCILLATOR_SOURCE_P0_LEVEL = "0.5"  #V
  DEFAULT_OSCILLATOR_SOURCE_P0_OPTION = "FORCE"
  DEFAULT_OSCILLATOR_SOURCE_PN_MODE = "NORM"
  DEFAULT_PN_DELAY = "100" #ns
  DEFAULT_PN_DELAY_UNIT = "ns"
  DEFAULT_PN_DELAY_MIN = "0" #ns
  DEFAULT_PN_DELAY_MAX = "100000" #ns
  DEFAULT_PN_WIDTH = "2.00"  #us
  DEFAULT_PN_WIDTH_UNIT = "us"
  DEFAULT_PN_WIDTH_MIN = "1.00"  #us
  DEFAULT_PN_WIDTH_MAX = "100.00"  #us
  DEFAULT_PN_POLARITY = "NORM"
  DEFAULT_DELAY_STEP_SIZE = "10"  #ns
  DEFAULT_WIDTH_STEP_SIZE = "0.1"  #us

  #Serial Command Definitions:
  MAIN_OUTPUT_ON = ":INST:STATE ON"
  MAIN_OUTPUT_OFF = ":INST:STATE OFF"
  P1_DELAY = ":PULSE1:DELAY" #time OR ?
  P2_DELAY = ":PULSE2:DELAY" #time OR ?
  P3_DELAY = ":PULSE3:DELAY" #time OR ?
  P4_DELAY = ":PULSE4:DELAY" #time OR ?
  P1_WIDTH = ":PULSE1:WIDTH" #time OR ?
  P1_MODE = ":PULSE1:POL" #config OR ?
  P2_MODE = ":PULSE2:POL" #config OR ?
  P3_MODE = ":PULSE3:POL" #config OR ?
  P4_MODE = ":PULSE4:POL" #config OR ?
end