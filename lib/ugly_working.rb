require 'rubyserial'
require 'pry'


##### BEGINNING OF UGLY WORKING

QC_USB = "/dev/tty.usbserial-AL01XLZ3"
TERMINATOR = "0D".hex.chr + "0A".hex.chr

sp = Serial.new QC_USB, 38400
puts "Starting up. Serial port open? #{!sp.closed?}"
command = ":SYST:COMM:SER:USB 115200"
sp.write(command + TERMINATOR)
sleep(0.2)
response = []
one_byte = ""
while !one_byte.nil?
  # sleep(0.1)
  one_byte = sp.getbyte
  response << one_byte
end
response = response.compact.map {|one_byte| one_byte.chr}.join
puts response.inspect
sp.close

sp = Serial.new QC_USB, 115200 

command = "*IDN?"
sp.write(command + TERMINATOR)

sleep(0.2)
response = []
one_byte = ""
while !one_byte.nil?
  # sleep(0.1)
  one_byte = sp.getbyte
  response << one_byte
end
response = response.compact.map {|one_byte| one_byte.chr}.join

puts response.inspect

sp.close
puts "finishing up... Serial port closed? #{sp.closed?}"

###### END OF UGLY WORKING!!!
