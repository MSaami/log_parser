# frozen_string_literal: true

require_relative 'exceptions'

# class which loads given file and also validates the file
class FileLoader
  attr_reader :file

  def initialize(file_path:)
    validate_file(file_path)
    @file = open_file(file_path)
  end

  private

  def open_file(file_path)
    File.open(file_path, 'r')
  end

  def validate_file(file_path)
    raise FileNotExistError unless File.exist?(file_path)
    raise FileIsEmptyError if File.zero?(file_path)
  end
end
