require 'zlib'
require 'base64'
require 'socket'
require 'stringio'

socket = TCPSocket.new 'challenge01.root-me.org', 52022

def connect(socket)
  return "[+] We're connected to the TCP server!"
end

puts connect(socket)

def UM(zlib_base64_string, socket)
  puts "[+] Deciphering the string..."
  zlib_string = Base64.decode64(zlib_base64_string)
  string = Zlib::Inflate.inflate(zlib_string)
  socket.puts(string)
  puts "[+] Done !"
end

while data = socket.recv(4096)

  zlib_base64_string= data.partition("'").last
  zlib_base64_string = zlib_base64_string.partition("'")[0]

  if zlib_base64_string != ""      
    puts "[+] Just got the ciphered string, sending it right through..." 
    UM(zlib_base64_string, socket)
  else
    puts data
    socket.close
    exit(0)
  end
end