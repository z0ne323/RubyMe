require 'socket'

socket = TCPSocket.new 'challenge01.root-me.org', 52021

def connect(socket)
  return "[+] We're connected to the TCP server!"
end

puts connect(socket)

def LRR(rot13_string, socket)
  puts "[+] Deciphering the string..."
  string = rot13_string.tr! "A-Za-z", "N-ZA-Mn-za-m"
  socket.puts(string)
  puts socket.recv(4096)
end

data = socket.recv(4096)

rot13_string = data.partition("'").last
rot13_string = rot13_string.partition("'")[0]

if rot13_string != ""
  puts "[+] Just got the ROT-13 string, sending it right through..." 
  LRR(rot13_string, socket)
else
  exit(1)
end

socket.close  

exit(0)