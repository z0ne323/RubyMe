require 'socket'

socket = TCPSocket.new 'irc.root-me.org', 6667

def connect(socket)
  socket.puts("NICK z0ne")
  socket.puts("USER z0ne z0ne z0ne: z0ne")
  socket.puts("JOIN: #root-me_challenge")
  return "[+] We're connected to the IRC server!"
end

puts connect(socket)

def RAC(parts, socket, line)
  if line.include? "You dit it!"
    return true
  end
  f_nb = parts[3].to_i
  s_nb = parts[5].to_i
  result = ((Math.sqrt(f_nb) * s_nb).round(2)).to_s
  socket.puts("PRIVMSG Candy :!ep1 -rep " + result)
end

sleep(2)

socket.puts("PRIVMSG Candy :!ep1")

while line = socket.gets 
  puts line        
  parts = line.split(/(\d+)/)
  if parts[0] == ":Candy!Candy@root-me.org PRIVMSG z" 
    if RAC(parts, socket, line)
      break
    end
  end
end

socket.close           