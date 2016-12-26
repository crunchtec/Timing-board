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

  #Serial Command Definitions:
  MAIN_OUTPUT_ON = ":INST:STATE ON"
  MAIN_OUTPUT_OFF = ":INST:STATE OFF"
end