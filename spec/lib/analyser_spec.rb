# frozen_string_literal: true

require 'spec_helper'
require 'analyser'

describe Analyser do
  let(:mock_reader) { double(:reader) }
  let(:mock_repository) { double(:repository) }

  subject { described_class.new(reader: mock_reader, repository: mock_repository) }
  before do
    allow(mock_reader).to receive(:each_entry)
      .and_yield("/contact", '192.168.1.1')
      .and_yield("/about", '192.168.1.2')
      .and_yield("/contact", '192.168.1.2')
  end

  it "stores each visit into repository" do
    expect(mock_repository).to receive(:increment_visit).exactly(3).times

    subject.call
  end
end
