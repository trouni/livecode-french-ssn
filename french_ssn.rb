require 'date'
require 'yaml'

SSN_REGEX = /^(?<gender>1|2)\s?(?<year>\d{2})\s?(?<month>(0[1-9]|1[0-2]))\s?(?<department>0[1-9]|[1-8][0-9]|9[0-5]|2[AB])(\s?\d{3}){2}\s?(?<key>\d{2})$/

def french_ssn_info(ssn)
	match_data = SSN_REGEX.match(ssn)
	departments = YAML.load_file('data/french_departments.yml')

	# We validate the ssn first
	if match_data && key_valid?(match_data)
		gender = match_data[:gender] == '1' ? 'man' : 'woman'
		year = "19#{match_data[:year]}"
		month = Date::MONTHNAMES[match_data[:month].to_i]
		department = departments[match_data[:department]]
		return "a #{gender}, born in #{month}, #{year} in #{department}."
	else
		return "Invalid SSN"
	end
end

def key_valid?(match_data)
	# The index 0 of our match_data returns the original string
	ssn = match_data[0].delete(' ')[0...-2].to_i
	return match_data[:key].to_i == (97 - ssn) % 97
end