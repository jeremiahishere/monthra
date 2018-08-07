RSpec.describe Monthra::MonthRange do
  describe '::new' do
    it 'should create a month range' do
      range = Monthra::MonthRange.new(
        Monthra.new(2017, 7),
        Monthra.new(2017, 8)
      )

      expect(range.size).to eq(2)
    end

    it 'should be inclusive on both ends' do
      range = Monthra::MonthRange.new(
        Monthra.new(2017, 7),
        Monthra.new(2017, 9)
      )

      expect(range.size).to eq(3)
      expect(range.first).to eq(Monthra.new(2017, 7))
      expect(range.last).to eq(Monthra.new(2017, 9))
    end

    it 'should create a range over the border of a year' do
      range = Monthra::MonthRange.new(
        Monthra.new(2017, 7),
        Monthra.new(2018, 7)
      )

      expect(range.size).to eq(13)
    end

    it 'should error if the end month is before the start' do
      expect { range = Monthra::MonthRange.new(
        Monthra.new(2017, 7),
        Monthra.new(2017, 6)
      ) }.to raise_error(ArgumentError)
    end

    it 'should not error if the end month is the same as the start' do
      range = Monthra::MonthRange.new(
        Monthra.new(2017, 7),
        Monthra.new(2017, 7)
      )

      expect(range.size).to eq(1)
      expect(range.first).to eq(Monthra.new(2017, 7))
    end

    it 'should error if the end month does not match the month interface' do
      expect { range = Monthra::MonthRange.new(
        Monthra.new(2017, 7),
        6
      ) }.to raise_error(NoMethodError)
    end
  end

  describe '::months_after_start' do
    it 'should create a range starting on the start date with the appropriate size' do
      range = Monthra::MonthRange.months_after_start(
        Monthra.new(2017, 7),
        4
      )
      
      expect(range.size).to eq(4)
      expect(range.first).to eq(Monthra.new(2017, 7))
      expect(range.last).to eq(Monthra.new(2017, 10))
    end
  end
end
