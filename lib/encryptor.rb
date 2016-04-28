require './lib/rotator'
require './lib/character_map'

class Encryptor
  attr_reader :message, :rotation, :character_map

  def initialize(message, key, date)
    @message = message.chars
    @rotation = Rotator.new(key, date)
    @character_map = CharacterMap.new.character_map
  end

  def encrypt
    find_message_character_values
    divide_character_value_groups_of_four
    add_final_encryptor_values
    encrypt_values_to_characters
  end

  def find_message_character_values
    message.map do |character|
      character_map.index(character)
    end
  end

  def divide_character_value_groups_of_four
    groups_of_four = []
    find_message_character_values.each_slice(4) do |character|
    groups_of_four << character
    end
    groups_of_four
  end

  def add_final_encryptor_values
    final_encryptor_values = []
    divide_character_value_groups_of_four.each do |group|
      group.each_with_index do |character, index|
        if index == 0
          a_final_rotation = rotation.a_rotation + character
          final_encryptor_values << a_final_rotation % 39
        elsif index == 1
          b_final_rotation = rotation.b_rotation + character
          final_encryptor_values << b_final_rotation % 39
        elsif index == 2
          c_final_rotation = rotation.c_rotation + character
          final_encryptor_values << c_final_rotation % 39
        elsif index == 3
          d_final_rotation = rotation.d_rotation + character
          final_encryptor_values << d_final_rotation % 39
        end
      end
    end
    final_encryptor_values
  end

  def encrypt_values_to_characters
    final_message = add_final_encryptor_values.map do |value|
      character_map[value]
    end
    final_message.join
  end
end
