require 'json'
require 'rubygems'
gem 'serialport','>=1.0.4'
require 'serialport'
require 'osc-ruby'

hash = nil
sendList = nil
baud_rate = nil
port = nil
clients = Array.new()
STDOUT.sync = true

File.open("config.json") do |file|
  hash = JSON.load(file)
  baud_rate = hash["arduino"]["baud"]
  port = hash["arduino"]["port"]
  sendList = hash["sendList"]
end


sendList.each{|key, value|
  puts key + "=>" + value
  clients.push(OSC::Client.new(value, 10000))
}

SerialPort.open(port, baud_rate) do |sp|
  sp.read_timeout = 500
  loop do
    begin
      getMes = sp.readline
      puts getMes
      message = OSC::Message.new('/message', getMes.chomp)
      begin
        for client in clients do
          #puts client
          client.send(message)
        end
      rescue
        #puts 'error'
      end

    rescue EOFError
      retry
    end
  end
end
