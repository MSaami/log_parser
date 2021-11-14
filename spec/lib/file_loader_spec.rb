# frozen_string_literal: true

require 'spec_helper'
require 'file_loader'

describe FileLoader do
  context '#exist file' do
    let(:file_path) { 'spec/fixtures/correct_file.log' }
    subject { described_class.new(file_path: file_path) }

    it 'open file correctly' do
      expect(subject.file).to be_a(File)
    end
  end

  context 'wrong file' do
    let(:file_path) { 'spec/fixtures/not_exist.log' }

    it 'throws exception if file not exist' do
      expect { described_class.new(file_path: file_path) }.to raise_error(FileNotExistError)
    end
  end

  context 'empty file' do
    let(:file_path) { 'spec/fixtures/empty_file.log' }

    it 'throws exception if file is empty' do
      expect { described_class.new(file_path: file_path) }.to raise_error(FileIsEmptyError)
    end
  end
end
