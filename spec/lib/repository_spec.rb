# frozen_string_literal: true

require 'spec_helper'
require 'repository'

describe Repository do
  subject { described_class.new }

  describe '#increment_visit' do
    it 'stores path and ip' do
      expect do
        subject.increment_visit(path: 'test', ip: '192.168.1.1')
      end.to change { subject.send(:visits) }.from({}).to({ 'test' => ['192.168.1.1'] })
    end
  end

  context 'count visits' do
    let(:visits) do
      [
        ['/contact', '184.123.665.067'],
        ['/help_page/1', '126.318.035.038'],
        ['/home', '184.123.665.067'],
        ['/help_page/1', '929.398.951.889'],
        ['/help_page/1', '929.398.951.889']
      ]
    end
    before do
      visits.each { |visit| subject.increment_visit(path: visit[0], ip: visit[1]) }
    end

    it 'returns sorted visits by views' do
      expect(subject.count_visits).to eq([
                                           ['/help_page/1', 3],
                                           ['/contact', 1],
                                           ['/home', 1]
                                         ])
    end

    it 'returns uniqu sorted vistes' do
      expect(subject.unique_count_visits).to eq([
                                                  ['/help_page/1', 2],
                                                  ['/contact', 1],
                                                  ['/home', 1]
                                                ])
    end
  end
end
