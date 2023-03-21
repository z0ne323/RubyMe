require 'socket'

socket = TCPSocket.new 'irc.root-me.org', 6667

def connect(socket)
  socket.puts("NICK z0ne")
  socket.puts("USER z0ne z0ne z0ne: z0ne")
  socket.puts("JOIN: #root-me_challenge")
  return "[+] We're connected to the IRC server!"
end

puts connect(socket)

def LRR(rot13_string, socket, line)
  if line.include? "You dit it!"
    return true
  end
  string = rot13_string.tr! "A-Za-z", "N-ZA-Mn-za-m"
  socket.puts("PRIVMSG Candy : !ep3 -rep " + string)
end

sleep(2)

socket.puts("PRIVMSG Candy :!ep3")

while line = socket.gets 
  puts line         
  parts = line.split(/(\d+)/)
  if parts[0] == ":Candy!Candy@root-me.org PRIVMSG z" 
    rot13_string = line.partition(':').last
    rot13_string = rot13_string.partition(':').last
    if rot13_string != "" 
        if LRR(rot13_string, socket, line)
            break
        end
    end
    end    
end

socket.close           
