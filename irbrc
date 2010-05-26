require 'irb/completion'

def ri(*names)
	system(%{ri #{names.map {|name| name.to_s}.join(" ")}})
end

if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

