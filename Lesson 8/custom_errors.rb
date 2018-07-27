module CustomErrors
  # https://github.com/rubocop-hq/ruby-style-guide#single-line-classes
  ValidationError = Class.new(StandardError)
end
