# frozen_string_literal: true

# class which analyse the file and stores records to repository
class Analyser
  def initialize(reader:, repository:)
    @reader = reader
    @repository = repository
  end

  def call
    reader.each_entry do |path, ip|
      repository.increment_visit(path: path, ip: ip)
    end
  end

  private

  attr_reader :reader, :repository
end
