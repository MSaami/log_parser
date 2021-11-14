# frozen_string_literal: true

class Presenter
  def initialize(data: {}, header: nil, append_sentence: nil)
    @data = data
    @header = header
    @append_sentence = append_sentence
  end

  def to_console
    puts header.to_s unless header.nil?

    data.each do |key, value|
      puts "#{key} #{value} #{append_sentence}"
    end
  end

  private

  attr_reader :data, :header, :append_sentence
end
