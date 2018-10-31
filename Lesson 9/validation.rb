require_relative 'custom_errors'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attr_name, *params)
      @validations ||= []
      @validations << {attr_name.to_s => params }
    end

  end

  module InstanceMethods
    include CustomErrors

    def validate!
      self.class.validations_for_attribute.each do |validation|
        validation.each do |name, params|
          method_name = params[0]
          value = instance_variable_get("@#{name}")
          optional_param = params[1]

          send(method_name, value, optional_param)
        end
      end
    end

    def valid?
      validate!
      true
    rescue ValidationError
      false
    end

    private

    def presence(attr, _optional_attr)
      raise ValidationError, "Value is nil or empty" if attr.nil? || attr.to_s.empty?
    end

    def format(attr, regex_pattern)
      raise ValidationError, "Wrong regex pattern type" if regex_pattern.class != Regexp
      raise ValidationError, "Value not matched with pattern '#{regex_pattern}'" if attr !~ regex_pattern
    end

    def type(attr, type)
      raise ValidationError, "Invalid object type. Given #{attr.class} but needed #{type}" if attr.class != type
    end

  end
end
