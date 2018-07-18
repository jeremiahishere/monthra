module Monthra
  class MonthRange
    include Enumerable
    attr_accessor :months

    # Note that this method will return a range with <size> number of months.
    # It will not return a range from <start month> to <start month + size>
    # It will actually return a range from <start month> to <start month + size - 1> because
    #   that will return a range with <size> elements.
    #
    # @param [Month/Date/Time] start_month The beginning of the range.  Needs to include a year and month
    #   method to match the interface.
    # @param [Integer] size The Number of months in the range
    def self.months_after_start(start_month, size)
      start_month = Month.at(start_month)
      # the end date is inclusive so it needs to end one month before <size> to get the correct
      # number of months
      end_month = start_month + (size - 1)

      self.new(start_month, end_month)
    end

    # @param [Month/Date/Time] start_month The beginning of the range.  Needs to include a year and 
    #   month method to match the interface.
    # @param [Month/Date/Time] end_month The end of the range.  Needs to include a year and month
    #   method to match the interface.
    def initialize(start_month, end_month)
      start_month = Month.at(start_month)
      end_month = Month.at(end_month)

      if end_month < start_month
        raise ArgumentError, "Start month must occur before the end month"
      end

      setup_months(start_month, end_month)
    end

    # Iterates over the months to meet the conditions of Enumerable
    def each
      months.each do |m|
        yield(m)
      end
    end

    # @return [Integer] Number of months in the range
    def size
      months.size
    end

    # @return [Month] The last month in the range
    def last
      months.last
    end

    private

    # Creates the internal representation of the month range
    #
    # @param [Month] start_month
    # @param [Month] end_month
    def setup_months(start_month, end_month)
      @months = []
      while start_month <= end_month
        @months << start_month
        start_month += 1
      end
    end
  end
end
