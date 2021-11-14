# frozen_string_literal: true

# class which reads line by line of a file and also validates each line
class FileReader
  def initialize(file_loader:)
    @file = file_loader.file
  end

  def each_entry
    file.each_line do |line|
      next unless valid?(line)

      path, ip = line.split

      yield path, ip
    end
  end

  private

  attr_reader :file

  def valid?(line)
    line.match?('\/\w+(\/\w+)* (\d{1,3}\.){3}\d{1,3}')
  end
end
