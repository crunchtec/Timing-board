require 'minitest/autorun'
require_relative '../lib/qc'

class QcTest < Minitest::Test

  def test_initialize_qc_class_instance
    assert test_qc = Qc.new
  end

  def test_get_keyword_list_returns_all_keywords
    test_qc = Qc.new
    assert_equal ["Select one", ":PULSe[1/2/n]"], test_qc.get_keyword_list
  end

  def test_get_command_list_returns_all_available_commands_for_keyword
    test_qc = Qc.new
    test_selected_keyword = ":PULSe[1/2/n]"
    assert_equal ["Select one", ":STATe", ":MODe"], test_qc.get_command_list(test_selected_keyword)
  end

  def test_get_parameter_list_returns_all_available_parameters_for_command_1
    test_qc = Qc.new
    test_selected_keyword = ":PULSe[1/2/n]"
    test_selected_command = ":STATe"
    assert_equal ["Select one", "OFF", "ON"], test_qc.get_parameter_list(test_selected_keyword, test_selected_command)
  end

  def test_get_parameter_list_returns_all_available_parameters_for_command_2
    test_qc = Qc.new
    test_selected_keyword = ":PULSe[1/2/n]"
    test_selected_command = ":MODe"
    assert_equal ["Select one", "NORMal", "SINGle", "BURSt", "DCYCle"], test_qc.get_parameter_list(test_selected_keyword, test_selected_command)
  end

  def test_send_instruction
    test_qc = Qc.new
    test_selected_keyword = ":PULSe[1/2/n]"
    test_selected_channel = "A"
    test_selected_command = ":MODe"
    test_selected_parameter = "OFF"
    assert_equal ":PULSE1:MODE OFF <cr> <lf>", test_qc.send_instruction(test_selected_keyword, test_selected_channel, test_selected_command, test_selected_parameter)    
  end

  def test_get_channels_return_list_of_all_channels
    test_qc = Qc.new
    assert_equal ["A", "B", "C", "D", "E", "F", "G", "H"], test_qc.get_channel_list
  end

  def test_all_caps_converts_single_letter
    test_qc = Qc.new
    test_input = "c"
    assert_equal "C", test_qc.all_caps(test_input)
  end

  def test_all_caps_converts_mixed_test
    test_qc = Qc.new
    test_input = "cRunCh TeChnoLogIEs"
    assert_equal "CRUNCH TECHNOLOGIES", test_qc.all_caps(test_input)
  end

  def test_add_channel_to_keyword_when_applicable
    test_qc = Qc.new
    test_keyword = ":PULSe[1/2/n]"
    test_channel = "A"
    assert_equal ":PULSe1", test_qc.include_channel(test_keyword, test_channel)
  end

end