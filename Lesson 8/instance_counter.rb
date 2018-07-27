module InstanceCounter
  def self.included(base)
    base.extend ClassMethods # Add class methods without namespace declaring
    base.send :include, InstanceMethods # :include is a private class method, therefore we have to use base.send                                                             # метод send (отправка сообщения/вызов метода).
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
