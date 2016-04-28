require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/decryptor"

class DecryptorTest < Minitest::Test
  def test_it_can_find_index_values_of_characters_from_map
    d = Decryptor.new("84i4m5sj7. 4tzrq8u.kt dkn", "12345", "070416")

    assert_equal "d", d.character_map[3]
    assert_equal "5", d.character_map[31]
    assert_equal 17, d.character_map.index("r")
  end

  def test_it_can_take_a_message_and_split_into_groups_of_four_in_character_values
    d = Decryptor.new("84i4m5sj7. 4tzrq8u.kt dkn", "12345", "070416")
    output = [[34, 30, 8, 30], [12, 31, 18, 9], [33, 37, 36, 30], [19, 25, 17, 16], [34, 20, 37, 10], [19, 36, 3, 10], [13]]

    assert_equal output, d.divide_character_value_groups_of_four
  end

  def test_it_can_subtract_decryptor_values_to_get_final_values
    d = Decryptor.new("84i4m5sj7. 4tzrq8u.kt dkn", "12345", "070416")
    output = [19, 7, 8, 18, 36, 8, 18, 36, 18, 14, 36, 18, 4, 2, 17, 4, 19, 36, 37, 37, 4, 13, 3, 37, 37]

    assert_equal output, d.subtract_final_decryptor_values
  end

  def test_it_converts_final_values_back_to_characters
    d = Decryptor.new("84i4m5sj7. 4tzrq8u.kt dkn", "12345", "070416")
    output = "this is so secret ..end.."

    assert_equal output, d.convert_values_to_characters
  end
end
