RSpec.describe Monthra::Month do

  describe '::new' do
    it 'should save the year and month if valid' do
      m = Monthra::Month.new(2018, 7)

      expect(m.year).to eq(2018)
      expect(m.month).to eq(7)
    end

    it 'should error if the month is out of range' do
      expect { Monthra::Month.new(2018, 9001) }.to raise_error(Exception)
    end

    it 'should handle a negative month by subtracting 1 from the year' do
      m = Monthra::Month.new(2018, -1)

      expect(m.year).to eq(2017)
      expect(m.month).to eq(12)
    end
  end

  describe '::strpmonth' do
    it 'should convert a string into a month' do
      m = Monthra::Month.strpmonth('2018-07', '%Y-%m')

      expect(m.year).to eq(2018)
      expect(m.month).to eq(7)
    end
  end

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

  describe '.begin_on' do
    it "should be converted to a date on the first of the month" do
      month = Monthra::Month.new(2018, 7)
      expect(month.begin_on).to eq(Date.new(2018, 7, 1))
    end
  end

  describe '.end_on' do
    it "should be converted to a date on the first of the month" do
      month = Monthra::Month.new(2018, 7)
      expect(month.end_on).to eq(Date.new(2018, 7, 31))
    end

    it 'should handle leap years' do
      month = Monthra::Month.new(2016, 2)
      expect(month.end_on).to eq(Date.new(2016, 2, 29))
    end
  end

  describe '.to_time' do
    it "should be converted to a time on the first of the month" do
      month = Monthra::Month.new(2018, 7)
      expect(month.to_time).to eq(Time.at(1530417600))
    end
  end

  describe '.strfmonth' do
    it "should format the month as described" do
      month = Monthra::Month.new(2018, 7)
      expect(month.strfmonth("%Y-%m")).to eq('2018-07')
    end
  end

  describe ".<=>" do
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

  describe '.+' do
    it 'should add an integer month' do
      month = Monthra::Month.new(2017, 7)

      output = month + 3

      expect(output.year).to eq(2017)
      expect(output.month).to eq(10)
    end

    it 'should add an integer month greater than 12 and affect the year' do
      month = Monthra::Month.new(2017, 7)

      output = month + 14

      expect(output.year).to eq(2018)
      expect(output.month).to eq(9)
    end

    it 'should update the year if the month goes above 12' do
      month = Monthra::Month.new(2017, 7)

      output = month + 7

      expect(output.year).to eq(2018)
      expect(output.month).to eq(2)
    end

    it 'should add a monthra month' do
      month = Monthra::Month.new(2017, 7)
      offset = Monthra::Month.new(1, 8)

      output = month + offset

      expect(output.year).to eq(2019)
      expect(output.month).to eq(3)
    end
  end

  describe '.-' do
    it 'should subtract an integer month' do
      month = Monthra::Month.new(2017, 7)

      output = month - 3

      expect(output.year).to eq(2017)
      expect(output.month).to eq(4)
    end

    it 'should subtract an integer month greater than 12 and affect the year' do
      month = Monthra::Month.new(2017, 7)

      output = month - 14

      expect(output.year).to eq(2016)
      expect(output.month).to eq(5)
    end

    it 'should update the year if the month goes below 1' do
      month = Monthra::Month.new(2017, 7)

      output = month - 10

      expect(output.year).to eq(2016)
      expect(output.month).to eq(9)
    end

    # this is a strange edge case because the months are one indexed
    it 'should update the year if the month goes to exactly zero' do
      month = Monthra::Month.new(2017, 7)

      output = month - 7

      expect(output.year).to eq(2016)
      expect(output.month).to eq(12)
    end

    it 'should subtract a monthra month' do
      month = Monthra::Month.new(2017, 7)
      offset = Monthra::Month.new(1, 8)

      output = month - offset

      expect(output.year).to eq(2015)
      expect(output.month).to eq(11)
    end
  end
end
