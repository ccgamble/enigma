class Rotator
  attr_accessor :date, :key

  def initialize(key, date)
    @key = key.to_s
    @date = date
    date_offset
  end

  def date_offset
    (date.to_i ** 2).to_s
  end

  def a_key_rotation
    key[0..1].to_i
  end

  def b_key_rotation
    key[1..2].to_i
  end

  def c_key_rotation
    key[2..3].to_i
  end

  def d_key_rotation
    key[3..4].to_i
  end

  def a_rotation
    a_key_rotation + date_offset[-4].to_i
  end

  def b_rotation
    b_key_rotation + date_offset[-3].to_i
  end

  def c_rotation
    c_key_rotation + date_offset[-2].to_i
  end

  def d_rotation
    d_key_rotation + date_offset[-1].to_i
  end
end
