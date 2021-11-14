# frozen_string_literal: true

require_relative 'exceptions'
class ArgsReader
  attr_reader :path

  def initialize(args)
    get_path(args)
  end

  private

  def get_path(args)
    raise FileNotProvidedError if args.empty?

    @path = args[0]
  end
end
