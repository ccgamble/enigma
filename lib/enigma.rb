require './lib/encryptor'
require './lib/cracker'
require './lib/decryptor'

class Enigma
  def encrypt(message, key = "%05d" % rand(0..99999), date = Time.new.strftime("%d""%m""%y"))
    Encryptor.new(message, key, date).encrypt
  end

  def decrypt(message, key, date = Time.new.strftime("%d""%m""%y"))
    Decryptor.new(message, key, date).decrypt
  end

  def crack(message, date = Time.new.strftime("%d""%m""%y"))
   Crack.new(message, date).convert_values_to_characters
 end

end
