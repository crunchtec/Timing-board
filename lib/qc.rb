
class Qc
  attr_reader :specification,
              :terminator,
              :keyword_selection,
              :command_selection,
              :channel_conversion


  def initialize
    @specification = {}
    @specification = {"Select one" => "", ":PULSe[1/2/n]" => {"Select one" => "", ":STATe" => ["Select one", "OFF", "ON"], ":MODe" => ["Select one", "NORMal", "SINGle", "BURSt", "DCYCle"]}}
    @terminator = " <cr> <lf>"
    @keyword_selection = ""
    @command_selection = ""
    @parameter_selection = ""
    @channel_conversion = {"A" => "1", "B" => "1", "C" => "1", "D" => "1", "E" => "1", "F" => "1", "G" => "1", "H" => "1"}
  end

  def get_channel_list
    channel_conversion.keys
  end

  def get_keyword_list
    specification.keys
  end

  def get_command_list(keyword)
    specification[keyword].keys
  end

  def get_parameter_list(keyword, command)
    specification[keyword][command]
  end

  def all_caps(input)
    input.upcase
  end

  def include_channel(keyword, channel)
    keyword.gsub("[1/2/n]", channel_conversion[channel])
  end

  def send_instruction(keyword, channel, command, parameter)
    instruction = all_caps(include_channel(keyword, channel) + command + " " + parameter) + terminator
    # send_through_rs_232(instruction)
  end

  # def send_through_rs_232(instruction)
  # end

end