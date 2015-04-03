require 'active_support'
require 'active_support/core_ext'

class Animal
  attr_accessor :name

  def to_s
    result = "#{self.class}"
    result += " with name #{name.titleize}" if name.present?

    result
  end
end
