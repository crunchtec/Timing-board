module Definitions

  PARAM_CONTROL = {"main_switch_status" => :main_switch_status,
                  "main_switch" => :main_switch,
                  "channel_a_delay" => :channel_a_delay,
                  "channel_a_name_custom" => :channel_a_name_custom,
                  "step_size" => :step_size}
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

  INTERFACE_SERIAL_CONTROL = {:channel_a_delay => "set_channel_a_delay"
                              }

  #Default value definitions
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
  DEFAULT_PN_WIDTH = "2"  #us
  DEFAULT_PN_WIDTH_UNIT = "us"
  DEFAULT_PN_WIDTH_MIN = "1"  #us
  DEFAULT_PN_WIDTH_MAX = "100"  #us
  DEFAULT_PN_POLARITY = "NORM"
  DEFAULT_DELAY_STEP_SIZE = "10"  #ns

  #Serial Command Definitions:
  MAIN_OUTPUT_ON = ":INST:STATE ON"
  MAIN_OUTPUT_OFF = ":INST:STATE OFF"
  P1_DELAY = ":PULSE:DELAY" #time OR ?
end