require 'rs232'

serial_port = RS232.new '/dev/tty.usbserial-AL01XLZ3', {:baudrate => 38400, :bytesize => 8, :stopbits => 1, :parity => DCB::NOPARITY}
