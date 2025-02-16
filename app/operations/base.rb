class Base
  attr_accessor :params

  def initialize(args)
    @params = args
  end

  def self.call(args)
    new(args).call
  end
end
