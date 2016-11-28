require 'rubyserial'
require 'pry'

class SerialPort

  TERMINATOR = "0D".hex.chr + "0A".hex.chr
  TO_SECONDS = 1000
  QC_USB = "/dev/tty.usbserial-AL01XLZ3"
  MAX_NO_OF_RETRIES = 5
  ACCEPTABLE_SYSTEM_INFO = "QC,8534,05930,1.2.7-1.2.0"

  attr_reader :init_delay,
              :write_delay,
              :read_delay,
              :sp

  def initialize(init_delay = 200, write_delay = 50, read_delay = 50)
    @init_delay = init_delay.to_f / TO_SECONDS
    @write_delay = write_delay.to_f / TO_SECONDS
    @read_delay = read_delay.to_f / TO_SECONDS
    qc_initialize
  end

  def qc_initialize
    @sp = Serial.new QC_USB, 38400
    binding.pry
    patience(init_delay)
    command = ":SYST:COMM:SER:USB 115200"
    write(prepare(command))
    sp.close
    @sp = Serial.new QC_USB, 115200
    patience(init_delay)
    command = "*IDN?"
    expected_value = ACCEPTABLE_SYSTEM_INFO
    write_until(command, expected_value, MAX_NO_OF_RETRIES)
  end

  def patience(duration)
    sleep(duration)
  end

  def write_until(command, expected_return_value, no_of_retries)
    retry_counter = 0
    while !write(prepare(command).eql?(expected_return_value)) && (retry_counter < no_of_retries)
      patience(0.1 * retry_counter)
      retry_counter += 1
    end
  end

  def write(command)
    sp.write(prepare(command))
    patience(write_delay)
    read
  end

  def read
    patience(read_delay)
    response = []
    one_byte = ""
    while !one_byte.nil?
      one_byte = sp.getbyte
      response << one_byte
    end
    response.compact.map {|one_byte| one_byte.chr}.join.gsub("\r\n", "")
  end

  def prepare(command)
    command.to_s + TERMINATOR
  end

  def close
    sp.close
    # puts "finishing up... Serial port closed? #{sp.closed?}"
  end

  def closed?
    sp.closed?
  end

  def delays(init_delay, write_delay, read_delay)
    @init_delay = init_delay / TO_SECONDS
    @write_delay = write_delay / TO_SECONDS
    @read_delay = read_delay / TO_SECONDS
  end

end


#EXAMPLE!!!

# sp = SerialPort.new

# command = "*IDN?"
# response = sp.write(command)

# puts "SerialPort read output: #{response.inspect}"

# command = ":SYST:SERN?"
# response = sp.write(command)

# puts "SerialPort read output: #{response.inspect}"

# sp.close

