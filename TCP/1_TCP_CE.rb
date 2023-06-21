require 'base64'
require 'socket'

socket = TCPSocket.new 'challenge01.root-me.org', 52023

def connect(socket)
  return "[+] We're connected to the TCP server!"
end

puts connect(socket)

def CE(base64_string, socket)
  puts "[+] Decoding the string..."
  decoded_string = Base64.decode64(base64_string)
  socket.puts(decoded_string)
  puts socket.recv(4096)
end

data = socket.recv(4096)
        
base64_string = data.partition("'").last
base64_string = base64_string.partition("'")[0]

if base64_string != ""
  puts "[+] Just got the base64 string, sending it right through..." 
  CE(base64_string, socket)
else
  exit(1)
end

socket.close 

exit(0)