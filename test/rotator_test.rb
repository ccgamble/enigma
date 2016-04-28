require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative "../lib/rotator"


class RotatorTest < Minitest::Test
  def test_it_can_square_the_date
    r = Rotator.new("12345", "040716")

    assert_equal "1657792656", r.date_offset
  end

  def test_rotation_takes_correct_value_from_key
    r = Rotator.new("12345", "040716")

    assert_equal 12, r.a_key_rotation
    assert_equal 23, r.b_key_rotation
    assert_equal 34, r.c_key_rotation
    assert_equal 45, r.d_key_rotation
  end

  def test_it_can_create_offset_by_taking_last_four_digits_of_squared_date
    r = Rotator.new("12345", "040716")

    assert_equal "2656", r.date_offset[-4..-1]
  end
  def test_it_can_rotate_by_adding_key_rotation_and_offset
    r = Rotator.new("12345", "040716")

    assert_equal 14, r.a_rotation
    assert_equal 29, r.b_rotation
    assert_equal 39, r.c_rotation
    assert_equal 51, r.d_rotation
  end
end
