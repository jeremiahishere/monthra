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

    # @param [Fixnum] new_year The year of the month
    # @param [Fixnum] new_month The month of the year.  If a negative month is passed in, the year
    #   is decremented.
    def initialize(new_year, new_month)
      setup_year_and_month(new_year, new_month)
    end

    # @param [Month] other_month The month to compare to
    # @return [Fixnum] 1 if greater, 0 if equal, -1 if less
    def <=>(other_month)
      if year == other_month.year && month == other_month.month
        return 0
      elsif year > other_month.year || (year == other_month.year && month > other_month.month)
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
      Date.new(year, month, 1)
    end

    # @return [Date] The first day of the month
    def begin_on
      to_date
    end

    # @return [Date] The last day of the month
    def end_on
      Date.new(year, month, -1)
    end

    def strfmonth(format)
      to_time.strftime(format)
    end

    # @return [String] year-month (padded)
    def to_s
      strfmonth("%Y-%m")
    end

    private

    # if month > 12 or < -12 or == 0, raise exception
    # if the month < 0, then subtract that number from 12 and decrement the year
    # otherwise, just set the month and year
    #
    # @param [Fixnum] new_year
    # @param [Fixnum] new_month
    def setup_year_and_month(new_year, new_month)
      if new_month > 12 || new_month < -12 || new_month == 0
        raise Exception "Month out of range.  Allowable values: 1..12 and -12..-1."
      elsif new_month < 0
        @year = new_year - 1
        @month = 13 + new_month
      else
        @year = new_year
        @month = new_month
      end
    end
  end
end
