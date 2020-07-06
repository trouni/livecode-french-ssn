require 'date'
require 'yaml'

SSN_PATTERN = /^(?<gender>[12])\s?(?<year>\d{2})\s?(?<month>\d{2})\s?(?<department>\d{2}|2[AB])\s?\d{3}\s?\d{3}\s?(?<key>\d{2})$/

def french_ssn_info(ssn)
	match_data = ssn.match(SSN_PATTERN)
	if match_data && key_valid?(ssn, match_data[:key])
		gender = gender(match_data[:gender])
		year = match_data[:year]
		month = month_name(match_data[:month])
		department = department(match_data[:department])
		return "A #{gender}, born in #{month}, 19#{year} in #{department}."
	else
		return 'Invalid SSN'
	end
end

def gender(code)
	code == '1' ? 'man' : 'woman'
end

def month_name(code)
	Date::MONTHNAMES[code.to_i]
end

def department(code)
	YAML.load_file('data/french_departments.yml')[code]
end

def key_valid?(ssn, key)
	match_data = ssn.match(/[AB]/)
	key.to_i == (97 - ssn.delete(' ')[0...-2].to_i) % 97
end





