require 'station'

describe Station do
subject { described_class.new("Old Street", 1) }

  it 'exposes name when called' do
    expect(subject.name).to eq "Old Street"
  end

  it 'exposes zone when called' do
    expect(subject.zone).to eq 1
  end
end
