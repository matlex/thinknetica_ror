module Accessors
  def self.included(receiver)
    receiver.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attrs)
      # Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов,
      # при этом сеттер сохраняет все значения инстанс-переменной при изменении этого значения.
      #
      # Также в класс, в который подключается модуль должен добавляться инстанс-метод
      # <имя_атрибута>_history
      # который возвращает массив всех значений данной переменной.
      attrs.each do |attr_name|
        define_method("#{attr_name}_history") { instance_variable_get("@#{attr_name}_history") }

        define_method(attr_name) { instance_variable_get("@#{attr_name}") }
        define_method("#{attr_name}=") do |value|
          instance_variable_set("@#{attr_name}", value)

          var_history_values = instance_variable_get("@#{attr_name}_history") || []
          var_history_values << value
          instance_variable_set("@#{attr_name}_history", var_history_values)
        end
      end
    end

    def strong_attr_accessor(attr_name, class_type)
      # Принимает имя атрибута и его класс.
      # При этом создается геттер и сеттер для одноименной инстанс-переменной,
      # но сеттер проверяет тип присваемоего значения.
      # Если тип отличается от того, который указан вторым параметром, то выбрасывается исключение.
      # Если тип совпадает, то значение присваивается.
      define_method(attr_name) { instance_variable_get("@#{attr_name}") }  # Геттер

      define_method("#{attr_name}=") do |value|  # Сеттер
        if value.is_a?(class_type)
          instance_variable_set("@#{attr_name}", value)
        else
          raise TypeError, 'Invalid class type!'
        end
      end

    end
  end
end

class Test
  include Accessors

  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :e, String
  strong_attr_accessor :d, String

end

if __FILE__ == $0
  test = Test.new

  test.a = 5
  test.b = 12

  puts test.a, test.b, test.c
  puts '=' * 30
  puts test.a_history
  puts test.b_history
  puts test.c_history

  test.a = 33
  test.b = 35

  print test.a_history
  print test.b_history
  puts
  puts '=' * 30


  test.e = 'Hello'
  puts test.e

  test.d = 123
  puts test.d
end
