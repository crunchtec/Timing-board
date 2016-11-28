require 'minitest/autorun'
require_relative '../lib/control_interface'
require 'pry'

class ControlInterfaceTest < Minitest::Test

  attr_reader :test_control_interface

  def setup
    @test_control_interface = ControlInterface.new
  end

  def test_create_instance
    assert ControlInterface.new
  end

  def test_channel_a_delay_default
    assert_equal "100", test_control_interface.channel_a_delay
  end

  def test_channel_a_name_custom_default
    assert_equal "Channel A", test_control_interface.channel_a_name_custom
  end

  def test_main_on_default
    assert_equal "false", test_control_interface.main_on
  end

end