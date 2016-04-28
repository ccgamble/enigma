require './lib/encryptor'

message = File.read(ARGV[0]).chomp
key = "%05d" % rand(0..99999)
date = Time.new.strftime("%d""%m""%y")

encrypted_message = Encryptor.new(message, key, date).encrypt_values_to_characters

File.write(ARGV[1], encrypted_message)

puts "Created '#{ARGV[1]}' with the key #{key} and date #{date}"
