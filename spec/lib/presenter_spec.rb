# frozen_string_literal: true

require 'spec_helper'
require 'presenter'

describe Presenter do
  let(:data) do
    [
      ['/help', 3],
      ['/test', 2],
      ['/home', 1]
    ]
  end

  let(:expected_output) do
    <<~OUTPUT
      most views:
      /help 3 visits
      /test 2 visits
      /home 1 visits
    OUTPUT
  end

  let(:expected_output_without_header) do
    <<~OUTPUT
      /help 3 visits
      /test 2 visits
      /home 1 visits
    OUTPUT
  end

  let(:expected_output_without_append) do
    <<~OUTPUT
      /help 3#{' '}
      /test 2#{' '}
      /home 1#{' '}
    OUTPUT
  end

  describe "#to_console" do
    it "puts correct output" do
      subject = described_class.new(data: data, header: 'most views:', append_sentence: 'visits')
      expect { subject.to_console }.to output(expected_output).to_stdout
    end

    it "omits header if is not passed" do
      subject = described_class.new(data: data, append_sentence: 'visits')
      expect { subject.to_console }.to output(expected_output_without_header).to_stdout
    end

    it "omits append sentence if not passed" do
      subject = described_class.new(data: data)
      expect { subject.to_console }.to output(expected_output_without_append).to_stdout
    end
  end
end
