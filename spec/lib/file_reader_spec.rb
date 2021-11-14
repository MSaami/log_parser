# frozen_string_literal: true

require 'spec_helper'
require 'file_reader'

describe FileReader do
  let(:visits_string) { StringIO.new(test_visits) }
  let(:mock_file_loader) { double(:file_loader) }
  subject { described_class.new(file_loader: mock_file_loader) }

  before do
    allow(mock_file_loader).to receive(:file).and_return(test_visits)
  end

  context 'with correct lines' do
    let(:test_visits) do
      <<~HEREDOC
        /help_page/1 126.318.035.038
        /contact 184.123.665.067
        /home 184.123.665.067
        /help_page/1 929.398.951.889
        /index 444.701.448.104
        /help_page/1 722.247.931.582
        /about/2 184.123.665.067
      HEREDOC
    end

    it 'returns correct each line' do
      expect { |b| subject.each_entry(&b) }.to yield_successive_args(
        ['/help_page/1', '126.318.035.038'],
        ['/contact', '184.123.665.067'],
        ['/home', '184.123.665.067'],
        ['/help_page/1', '929.398.951.889'],
        ['/index', '444.701.448.104'],
        ['/help_page/1', '722.247.931.582'],
        ['/about/2', '184.123.665.067']
      )
    end
  end

  context 'with inputs which has empty line' do
    let(:test_visits) do
      <<~HEREDOC
        /help_page/1 126.318.035.038

        /home 184.123.665.067
        /help_page/1 929.398.951.889

        /help_page/1 722.247.931.582
      HEREDOC
    end

    it 'should escape empty line' do
      expect { |b| subject.each_entry(&b) }.to yield_control.exactly(4).times
    end

    it 'returns correct each line if it has empty line' do
      expect { |b| subject.each_entry(&b) }.to yield_successive_args(
        ['/help_page/1', '126.318.035.038'],
        ['/home', '184.123.665.067'],
        ['/help_page/1', '929.398.951.889'],
        ['/help_page/1', '722.247.931.582']
      )
    end
  end
end
