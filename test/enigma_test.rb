require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/enigma"

class EnigmaTest < Minitest::Test
  def test_it_can_encrypt_message
    e = Enigma.new
    message = "this is so secret ..end.."
    output = e.encrypt(message, "12345", "070416")

    assert_equal "84i4m5sj7. 4tzrq8u.kt dkn", output
  end

  def test_it_can_decrypt_message
    e = Enigma.new
    message = "84i4m5sj7. 4tzrq8u.kt dkn"
    output = e.decrypt(message, "12345", "070416")

    assert_equal "this is so secret ..end..", output
  end

  def test_it_can_encrypt_without_key
    e = Enigma.new
    message = "this is so secret ..end.."
    output = e.encrypt(message, "070416")

    refute_equal "84i4m5sj7. 4tzrq8u.kt dkn", output
  end

  def test_it_can_encrypt_message_without_date
    e = Enigma.new
    message = "this is so secret ..end.."
    output = e.encrypt(message, "12345")

    assert_equal "84i4m5sj7. 4tzrq8u.kt dkn", output
  end

  def test_it_can_decrypt_same_message_without_date
    e = Enigma.new
    message = "84i4m5sj7. 4tzrq8u.kt dkn"
    output = e.decrypt(message, "12345")

    assert_equal "this is so secret ..end..", output
  end
end
