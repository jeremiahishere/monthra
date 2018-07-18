# Decided not to use refinements due to backwards compatibility issues with Jruby 1.7.  Sorry.

class Date
  def to_monthra_month
    Monthra::Month.at(self)
  end
end

class Time
  def to_monthra_month
    Monthra::Month.at(self)
  end
end
