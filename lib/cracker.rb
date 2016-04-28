require_relative 'decryptor'
require_relative 'character_map'

class Crack
  attr_reader :message, :ending, :character_map, :date

  def initialize(message, date)
    @date = date
    @message = message.chars
    @ending = "..end..".chars
    @character_map = CharacterMap.new.character_map
  end

  def date_offset
    (date.to_i ** 2).to_s
  end

  def find_message_character_values
    message.map do |character|
      character_map.index(character)
    end
  end

  def divide_character_value_groups_of_four
    character_values_in_group_of_four = []
    find_message_character_values.each_slice(4) do |character|
    character_values_in_group_of_four << character
    end
    character_values_in_group_of_four
  end

  def count_in
    message.size % 4
  end

  def encrypted_character_values_at_end
    message_values = find_message_character_values
    message_values.pop(count_in)
    message_values[-4..-1]
  end

  def crack_cipher_character_values
    ending.map do |character|
      character_map.index(character)
    end
  end

  def find_abcd_values
    abcd_values = crack_cipher_character_values
    abcd_values.pop(count_in)
    abcd_values[-4..-1]
  end

  def determine_rotation_values
    abcd_message = encrypted_character_values_at_end
    abcd_ending = find_abcd_values
    [abcd_ending, abcd_message].transpose.map do |value|
      if value[0] > value[1]
        (38 - value[0]) + value[1] + 1
      else
        value[1] -= value[0]
      end
    end
  end

  def key_a
    determine_rotation_values[0]
  end

  def key_b
    determine_rotation_values[1]
  end

  def key_c
    determine_rotation_values[2]
  end

  def key_d
    determine_rotation_values[3]
  end

  def subtract_final_crack_values
    final_crack_values = []
    divide_character_value_groups_of_four.each do |group|
      group.each_with_index do |value, index|
        if index == 0
          a_final_value = value - key_a
          final_crack_values << a_final_value % 39
        elsif index == 1
          b_final_value = value - key_b
          final_crack_values << b_final_value % 39
        elsif index == 2
          c_final_value = value - key_c
          final_crack_values << c_final_value % 39
        elsif index == 3
          d_final_value = value - key_d
          final_crack_values << d_final_value % 39
        end
      end
    end
    final_crack_values
  end

  def convert_values_to_characters
    final_crack = subtract_final_crack_values.map do |value|
      character_map[value]
    end
    final_crack.join
  end
end
