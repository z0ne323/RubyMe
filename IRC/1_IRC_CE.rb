require 'base64'
require 'socket'

socket = TCPSocket.new 'irc.root-me.org', 6667

def connect(socket)
  socket.puts("NICK z0ne")
  socket.puts("USER z0ne z0ne z0ne: z0ne")
  socket.puts("JOIN: #root-me_challenge")
  return "[+] We're connected to the IRC server!"
end

puts connect(socket)

def CE(base64_string, socket, line)
  if line.include? "You dit it!"
    return true
  end
  string = Base64.decode64(base64_string)
  socket.puts("PRIVMSG Candy : !ep2 -rep " + string)
end

sleep(2)

socket.puts("PRIVMSG Candy :!ep2")

while line = socket.gets
  puts line        
  parts = line.split(/(\d+)/)
  if parts[0] == ":Candy!Candy@root-me.org PRIVMSG z" 
    base64_string = line.partition(':').last
    base64_string = base64_string.partition(':').last
    if base64_string != "" 
        if CE(base64_string, socket, line)
            break
        end
    end
    end    
end

socket.close            
