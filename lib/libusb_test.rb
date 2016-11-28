begin
  require 'usb'
rescue LoadError
  require 'libusb/compat'
end
# p USB.devices


require 'pry'

usb = USB.devices
usb.map do |one_device|
  puts one_device
end

handle = usb.first.open

binding.pry
sleep(1)

command = "*IDN?/r/n"

handle.usb_bulk_write(usb.first.endpoints.last, "*IDN?/r/n", 1000)

sleep(0.5)

response = handle.usb_bulk_read(usb.first.endpoints.first, 30, 1000)

puts "The response: #{response}"



# device = usb.devices(:idVendor => 0x04b4, :idProduct => 0x8613).first
# device.open_interface(0) do |handle|
#   handle.control_transfer(:bmRequestType => 0x40, :bRequest => 0xa0, :wValue => 0xe600, :wIndex => 0x0000, :dataOut => 1.chr)
# end