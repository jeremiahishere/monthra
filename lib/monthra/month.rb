require 'date'
require 'time'

module Monthra
  class Month
    include Comparable

    # param [Object] generic_month Must respond to month and year
    # @return [Month]
    def self.at(generic_month)
      if generic_month.respond_to?(:year) && generic_month.respond_to?(:month)
        self.new(generic_month.year, generic_month.month)
      else
        raise Exception("The param must have year and month methods")
      end
    end

    # @param [Fixnum] year The year of the month
    # @param [Fixnum] month The month of the year
    def initialize(year, month)
      @year = year
      @month = month
    end

    # @param [Month] other_month The month to compare to
    # @return [Fixnum] 1 if greater, 0 if equal, -1 if less
    def <=>(other_month)
      if @year == other_month.year && @month == other_month.month
        return 0
      elsif @year > other_month.year || (@year == other_month.year && @month > other_month.month)
        return 1
      else # the current month is less
        return -1
      end
    end

    # @return [Fixnum] The year
    def year
      @year
    end

    # @return [Fixnum] The month
    def month
      @month
    end

    # @return [Time] The beginning of the month
    def to_time
      to_date.to_time
    end

    # @return [Date] The first day of the month
    def to_date
      Date.new(@year, @month, 1)
    end

    # @return [String] year-month (padded)
    def to_s
      padded_month = @month.to_s.rjust(2, '0')

      "#{@year}-#{padded_month}"
    end
  end
end
