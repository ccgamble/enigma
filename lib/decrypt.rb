require './lib/decryptor'

encrypted_message = File.read(ARGV[0]).chomp
key = ARGV[2]
date = ARGV[3]

decrypted_message = Decryptor.new(encrypted_message, key, date).convert_values_to_characters

File.write(ARGV[1], decrypted_message)

puts "Created '#{ARGV[1]}' with the key #{key} and date #{date}"
