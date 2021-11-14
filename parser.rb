#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/exceptions'
require_relative 'lib/args_reader'
require_relative 'lib/file_loader'
require_relative 'lib/file_reader'
require_relative 'lib/repository'
require_relative 'lib/analyser'
require_relative 'lib/presenter'

begin
  path = ArgsReader.new(ARGV).path

  file_loader = FileLoader.new(file_path: path)
  file_reader = FileReader.new(file_loader: file_loader)

  Analyser.new(
    reader:     file_reader,
    repository: repository = Repository.new
  ).call

  # Print most views
  Presenter.new(
    data:            repository.count_visits,
    header:          'Most visits:',
    append_sentence: 'visits'
  ).to_console

  # Print most unique views
  Presenter.new(
    data:            repository.unique_count_visits,
    header:          'Unique visits:',
    append_sentence: 'unique visits'
  ).to_console
rescue FileNotExistError
  warn('ERROR: provided file is not exist')
  exit 1
rescue FileIsEmptyError
  warn('ERROR: provided file is empty')
  exit 1
rescue FileNotProvidedError
  warn("ERROR: please provide a file\nUSAGE: ./parser.rb LOG_FILE_PATH")
  exit 1
end
