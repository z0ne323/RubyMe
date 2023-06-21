require 'socket'

socket = TCPSocket.new 'challenge01.root-me.org', 52002

def connect(socket)
  return "[+] We're connected to the TCP server!"
end

puts connect(socket)

def RAC(f_nb, s_nb, socket)
  puts "[+] Calculating the response..."
  result = ((Math.sqrt(f_nb) * s_nb).round(2))
  puts "[+] Sending the response..."
  socket.puts(result)
  puts socket.recv(4096)
end

data = socket.recv(4096) 
          
parts = data.split

count = 0
numbers = []

for p in parts
	p = p.to_i
	if p > 2
		numbers.append(p)
	end	 
end

if numbers.length() == 2
  f_nb = numbers[0]
  s_nb = numbers[1]
else
  exit(1)
end 

puts "[+] Just got the numbers..."

RAC(f_nb, s_nb, socket)

socket.close   

exit(0)
