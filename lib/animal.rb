class Animal
  attr_accessor :name

  def to_s
    result = "#{self.class}"
    result += " with name #{name.titleize}" if name.present?

    result
  end
end
