RSpec.describe Monthra::Month do

  describe '::at' do
    it "should take a month as an argument and make a new month with the same values" do
      m = Monthra::Month.new(2018, 7)

      new_month = Monthra::Month.at(m)

      expect(new_month.year).to eq(m.year)
      expect(new_month.month).to eq(m.month)
    end

    it "should take a date as an argument and make a month" do
      d = Date.new(2018, 7, 15)

      new_month = Monthra::Month.at(d)

      expect(new_month.year).to eq(d.year)
      expect(new_month.month).to eq(d.month)
    end

    it "should take a time as an argument and make a month" do
      t = Date.new(2018, 7, 15)

      new_month = Monthra::Month.at(t)

      expect(new_month.year).to eq(t.year)
      expect(new_month.month).to eq(t.month)
    end

    it "should work if the passed in object has a month and year method" do
      m = double('Month')
      allow(m).to receive(:year) { 2018 }
      allow(m).to receive(:month) { 7 }

      new_month = Monthra::Month.at(m)
      expect(new_month.year).to eq(2018)
      expect(new_month.month).to eq(7)
    end

    it "should error if the passed in object does not have a year method" do
      m = double('Month')
      allow(m).to receive(:month) { 7 }

      expect { Monthra::Month.at(m) }.to raise_error(Exception)
    end

    it "should error if the passed in object does not have a month method" do
      m = double('Month')
      allow(m).to receive(:year) { 2018 }

      expect { Monthra::Month.at(m) }.to raise_error(Exception)
    end
  end

  describe '.to_s' do
    it "loads a year and month and converts it to a string" do
      month = Monthra::Month.new(2018, 7)
      expect(month.to_s).to eq("2018-07")
    end
  end

  describe '.to_date' do
    it "should be converted to a date on the first of the month" do
      month = Monthra::Month.new(2018, 7)
      expect(month.to_date).to eq(Date.new(2018, 7, 1))
    end
  end

  describe '.to_time' do
    it "should be converted to a time on the first of the month" do
      month = Monthra::Month.new(2018, 7)
      expect(month.to_time).to eq(Time.at(1530417600))
    end
  end

  describe "<=> operator" do
    it "should return 1 if the month is greater" do
      month1 = Monthra::Month.new(2018, 7)
      month2 = Monthra::Month.new(2018, 5)

      expect(month1.<=>(month2)).to eq(1)
    end

    it "should return 1 if the year is greater and the month is less" do
      month1 = Monthra::Month.new(2018, 7)
      month2 = Monthra::Month.new(2017, 8)

      expect(month1.<=>(month2)).to eq(1)
    end

    it "should return 1 if the year is equal and the month is greater" do
      month1 = Monthra::Month.new(2018, 7)
      month2 = Monthra::Month.new(2018, 6)

      expect(month1.<=>(month2)).to eq(1)
    end

    it "should return 0 if the months are equal" do
      month1 = Monthra::Month.new(2018, 7)
      month2 = Monthra::Month.new(2018, 7)

      expect(month1.<=>(month2)).to eq(0)
    end

    it "should return -1 if the month is less" do
      month1 = Monthra::Month.new(2018, 7)
      month2 = Monthra::Month.new(2018, 8)

      expect(month1.<=>(month2)).to eq(-1)
    end
    
    it "should return -1 if the year is less but the month is greater" do
      month1 = Monthra::Month.new(2017, 9)
      month2 = Monthra::Month.new(2018, 7)

      expect(month1.<=>(month2)).to eq(-1)
    end
  end
end