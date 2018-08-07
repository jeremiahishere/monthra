RSpec.describe Monthra do
  it "has a version number" do
    expect(Monthra::VERSION).not_to be nil
  end

  # delegated methods
  it { should respond_to(:new) }
  it { should respond_to(:current) }
  it { should respond_to(:at) }
  it { should respond_to(:strpmonth) }

  it { should respond_to(:range) }
end
