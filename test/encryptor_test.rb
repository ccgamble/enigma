require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/encryptor"

class EncryptorTest < Minitest::Test
  def test_it_can_find_index_values_of_characters_from_map
    e = Encryptor.new("this is so secret ..end..", "12345", "070416")

    assert_equal "d", e.character_map[3]
    assert_equal 18, e.character_map.index("s")
  end

  def test_it_can_take_a_message_and_split_into_groups_of_four_in_character_values
    e = Encryptor.new("this is so secret ..end..", "12345", "070416")
    output = [[19, 7, 8, 18], [36, 8, 18, 36], [18, 14, 36, 18], [4, 2, 17, 4], [19, 36, 37, 37], [4, 13, 3, 37], [37]]
    assert_equal output, e.divide_character_value_groups_of_four
  end
#
  def test_it_can_subtract_decryptor_values_to_get_final_values
    e = Encryptor.new("this is so secret ..end..", "12345", "070416")
    output = [34, 30, 8, 30, 12, 31, 18, 9, 33, 37, 36, 30, 19, 25, 17, 16, 34, 20, 37, 10, 19, 36, 3, 10, 13]

    assert_equal output, e.add_final_encryptor_values
  end

  def test_it_converts_final_values_back_to_characters
    e = Encryptor.new("this is so secret ..end..", "12345", "070416")
    output = "84i4m5sj7. 4tzrq8u.kt dkn"

    assert_equal output, e.encrypt_values_to_characters
  end
end
