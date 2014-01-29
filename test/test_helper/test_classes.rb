class ObjectSchemas::Properties::Test < ObjectSchemas::Properties::Property
end

class ObjectSchemas::Properties::TestBlockPassed < ObjectSchemas::Properties::Property
  attr_reader :block_passed
  def initialize(options={}, &block)
    @block_passed = true if block_given?
  end
end

class ObjectSchemas::Properties::AlwaysRightType < ObjectSchemas::Properties::Property
  def matches_type?(value)
    return true
  end
end

class ObjectSchemas::Properties::AlwaysWrongType < ObjectSchemas::Properties::Property
  def matches_type?(value)
    return false
  end
end

class ObjectSchemas::Validators::Test < ObjectSchemas::Validators::Validator
end

class ObjectSchemas::Validators::AlwaysWrong < ObjectSchemas::Validators::Validator
  def valid?(value)
    return false
  end

  def error_message
    "Always Wrong"
  end
end

class ObjectSchemas::Validators::WrongAgain < ObjectSchemas::Validators::Validator
  def valid?(value)
    return false
  end

  def error_message
    "Wrong Again"
  end
end

class ObjectSchemas::Validators::AlwaysRight < ObjectSchemas::Validators::Validator
  def valid?(value)
    return true
  end

  def error_message
    "How did this happen?"
  end
end

class ObjectSchemas::Validators::RightAgain < ObjectSchemas::Validators::Validator
  def valid?(value)
    return true
  end

  def error_message
    "Wha?"
  end
end

class ObjectSchemas::Validators::AlwaysRaiseException < ObjectSchemas::Validators::Validator
  def valid?(value)
    raise Exception, "Bad!"
  end

  def error_message
    "Bad!"
  end
end