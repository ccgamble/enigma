require './lib/rotator'
require_relative 'character_map'

class Decryptor
  attr_reader :rotation, :message, :character_map

  def initialize(message, key, date)
    @message = message.chars
    @key = key
    @date = date
    @rotation = Rotator.new(key, date)
    @character_map  = CharacterMap.new.character_map
  end

  def decrypt
    find_message_character_values
    divide_character_value_groups_of_four
    subtract_final_decryptor_values
    convert_values_to_characters
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

  def subtract_final_decryptor_values
    final_decryptor_values = []
    divide_character_value_groups_of_four.each do |group|
      group.each_with_index do |value, index|
        if index == 0
          a_final_value = value - rotation.a_rotation
          final_decryptor_values << a_final_value % 39
        elsif index == 1
          b_final_value = value - rotation.b_rotation
          final_decryptor_values << b_final_value % 39
        elsif index == 2
          c_final_value = value - rotation.c_rotation
          final_decryptor_values << c_final_value % 39
        elsif index == 3
          d_final_value = value - rotation.d_rotation
          final_decryptor_values << d_final_value % 39
        end
      end
    end
    final_decryptor_values
  end

  def convert_values_to_characters
    final_message = subtract_final_decryptor_values.map do |value|
      character_map[value]
    end
    final_message.join
  end
end
