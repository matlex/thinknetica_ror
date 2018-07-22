module InstanceCounter
  def self.included(base)
    base.extend ClassMethods  # Подключаем методы класса без указания неймспейса
    base.send :include, InstanceMethods  # include является приватным методом класса, и поэтому нужно использовать send                                                                  # метод send (отправка сообщения/вызов метода).
  end

  module ClassMethods
    def instances
      @counter
    end

    private

    def increase_counter
      @counter ||= 0
      @counter += 1
    end
  end

  module InstanceMethods

    private

    def register_instance
      self.class.send :increase_counter
    end
  end
end
