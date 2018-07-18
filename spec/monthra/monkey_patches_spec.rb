RSpec.describe Date do
  describe '.to_monthra_month' do
    it 'should convert a date into a month' do
      date = Date.new(2017, 7, 18)

      month = date.to_monthra_month

      expect(month.year).to eq(2017)
      expect(month.month).to eq(7)
    end
  end
end

RSpec.describe Time do
  describe '.to_monthra_month' do
    it 'should convert a Time into a month' do
      time = Time.strptime("2017-7-18", "%Y-%m-%d")

      month = time.to_monthra_month

      expect(month.year).to eq(2017)
      expect(month.month).to eq(7)
    end
  end
end
