require_relative 'test_helper'
require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/cracker'

class CrackTest < Minitest::Test
  def test_it_converts_encrypted_message_to_an_array_of_character_strings
    c = Crack.new("test", "070416")

    assert_equal ["t", "e", "s", "t"], c.message
  end

  def test_it_converts_character_strings_into_map_values
    c = Crack.new("lxwc2y6u5n71k9mv93rv3", "070416")

    assert_equal [11, 23, 22, 2, 28, 24, 32, 20, 31, 13, 33, 27,
       10, 35, 12, 21, 35, 29, 17, 21, 29], c.find_message_character_values
  end

  def test_it_takes_just_known_crack_values
    c = Crack.new("lxwc2y6u5n71k9mv93rv3", "070416")

    assert_equal [35, 29, 17, 21], c.encrypted_character_values_at_end
  end

  def test_it_finds_the_message_length
    c = Crack.new("lxwc2y6u5n71k9mv93rv3", "070416")

    assert_equal 1, c.count_in
  end

  def test_it_counts_in_on_the_cipher
    c = Crack.new("..end..", "070416")

    assert_equal [37, 37, 4, 13], c.find_abcd_values
  end

  def test_it_finds_encrypted_message_values
    c = Crack.new("..end..", "070416")

    assert_equal [37, 37, 4, 13, 3, 37, 37], c.crack_cipher_character_values
  end

  def test_it_can_determine_rotation_values
    c = Crack.new("lxwc2y6u5n71k9mv93rv3", "070416")

    assert_equal [31, 16, 14, 23], c.determine_rotation_values
  end

  def test_it_can_determine_individual_rotation_values
    c = Crack.new("lxwc2y6u5n71k9mv93rv3", "070416")

    assert_equal 31, c.key_a
    assert_equal 16, c.key_b
    assert_equal 14, c.key_c
    assert_equal 23, c.key_d
  end

  def test_it_can_convert_values_to_characters
    c = Crack.new("2fxhgg7zj8861rn0nls0h", "070416")

    assert_equal "this is a test..end..", c.convert_values_to_characters
  end

  def test_it_converts_date_offset_to_string
    c = Crack.new("2fxhgg7zj8861rn0nls0h", "070416")

    assert_equal String, c.date_offset.class
  end
end
