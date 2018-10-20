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
        if [class_type, NilClass].include?(value.class)
          instance_variable_set("@#{attr_name}", value)
        else
          raise TypeError, "Invalid class type! Should be #{class_type}"
        end
      end

    end
  end
end
