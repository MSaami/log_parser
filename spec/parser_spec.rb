# frozen_string_literal: true

require 'spec_helper'

describe 'parser.rb' do
  subject { system "./parser.rb #{log_path}" }

  context "with a correct file" do
    let(:log_path) { 'spec/fixtures/correct_file.log' }
    let(:expected_output) do
      <<~OUTPUT
        Most visits:
        /help_page/1 4 visits
        /about/2 2 visits
        /index 1 visits
        Unique visits:
        /help_page/1 3 unique visits
        /about/2 2 unique visits
        /index 1 unique visits
      OUTPUT
    end

    it "returns expected output" do
      expect { subject }.to output(expected_output).to_stdout_from_any_process
    end
  end

  context "with empty file" do
    let(:log_path) { 'spec/fixtures/empty_file.log' }
    let(:empty_file_error) { "ERROR: provided file is empty\n" }

    it "returns provided file is empty if given file is empty" do
      expect { subject }.to output(empty_file_error).to_stderr_from_any_process
    end
  end

  context "with files which doesn't exist" do
    let(:log_path) { 'spec/fixtures/does_not_file.log' }
    let(:file_not_found) { "ERROR: provided file is not exist\n" }

    it "returns provided file is not exist if given file does not exist" do
      expect { subject }.to output(file_not_found).to_stderr_from_any_process
    end
  end

  context "without arguments" do
    let(:log_path) { nil }
    let(:usage_message) { "ERROR: please provide a file\nUSAGE: ./parser.rb LOG_FILE_PATH\n" }

    it "returns usage if file not passed" do
      expect { subject }.to output(usage_message).to_stderr_from_any_process
    end
  end
end
