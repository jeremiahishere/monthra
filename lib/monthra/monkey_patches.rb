# Decided not to use refinements due to backwards compatibility issues with Jruby 1.7.  Sorry.

class Date
  def to_monthra_month
    Monthra.at(self)
  end
  alias to_monthra to_monthra_month
end

class Time
  def to_monthra_month
    Monthra.at(self)
  end
  alias to_monthra to_monthra_month
end
