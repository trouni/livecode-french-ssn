require_relative '../french_ssn'

SSN_TESTS = {
  "1 85 12 78 284 210 79" => "a man, born in December, 1985 in Yvelines.",
  "2 85 12 78 284 210 29" => "a woman, born in December, 1985 in Yvelines.",
  "185127828421079" => "a man, born in December, 1985 in Yvelines.",
  "1 85 11 78 284 210 63" => "a man, born in November, 1985 in Yvelines.",
  "2 85 09 75 284 210 62" => "a woman, born in September, 1985 in Paris.",
  "1 85 12 78 284 210 23" => "Invalid SSN",
  "1 85 12 78 284 210 7" => "Invalid SSN",
  "3 85 12 78 284 210 76" => "Invalid SSN",
  "1 85 12 96 284 210 78" => "Invalid SSN"
}

describe '#french_ssn_info' do
  it 'returns "Invalid SSN" when given an empty string' do
    actual = french_ssn_info('')
    expected = 'Invalid SSN'
    expect(actual).to eq(expected) # actual == expected
  end

  SSN_TESTS.each do |ssn, expected|
    it "returns '#{expected}' when given '#{ssn}'" do
      actual = french_ssn_info(ssn)
      expect(actual).to eq(expected)
    end
  end
end