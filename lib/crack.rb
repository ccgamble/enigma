require_relative 'cracker'

encrypted_message = File.read(ARGV[0]).chomp
date = ARGV[2]


cracked_message = Crack.new(encrypted_message, date).convert_values_to_characters

File.write(ARGV[1], cracked_message)

puts "Cracked the message and created '#{ARGV[1]}' using #{date}"
