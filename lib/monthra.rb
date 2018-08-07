require 'date'
require 'time'
require 'forwardable'

require 'monthra/monkey_patches.rb'
require 'monthra/version'
require 'monthra/month'
require 'monthra/month_range'

module Monthra
  class << self
    extend Forwardable
    def_delegators 'Monthra::Month', :new, :current, :at, :strpmonth

    def_delegator 'Monthra::MonthRange', :new, :range
  end
end
