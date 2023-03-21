require 'zlib'
require 'base64'
require 'socket'
require 'stringio'

socket = TCPSocket.new 'irc.root-me.org', 6667

def connect(socket)
  socket.puts("NICK z0ne")
  socket.puts("USER z0ne z0ne z0ne: z0ne")
  socket.puts("JOIN: #root-me_challenge")
  return "[+] We're connected to the IRC server!"
end

puts connect(socket)

def UM(zlib_base64_string, socket, line)
  if line.include? "You dit it!"
    return true
  end
  zlib_string = Base64.decode64(zlib_base64_string)
  string = Zlib::Inflate.inflate(zlib_string)
  socket.puts("PRIVMSG Candy : !ep4 -rep " + string)
end

sleep(2)

socket.puts("PRIVMSG Candy :!ep4")

while line = socket.gets 
  puts line        
  parts = line.split(/(\d+)/)
  if parts[0] == ":Candy!Candy@root-me.org PRIVMSG z" 
    zlib_base64_string = line.partition(':').last
    zlib_base64_string = zlib_base64_string.partition(':').last
    if zlib_base64_string != "" 
        if UM(zlib_base64_string, socket, line)
            break
        end
    end
    end    
end

socket.close            
