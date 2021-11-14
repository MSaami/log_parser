# frozen_string_literal: true

require 'spec_helper'
require 'args_reader'

describe ArgsReader do
  context "with correct arguments" do
    subject { described_class.new(args) }
    let(:args) { ['path'] }
    it "returns first argument as path" do
      expect(subject.path).to eq(args.first)
    end
  end

  context "with wrong arguments" do
    it "throw excpetions if args is empty" do
      expect { described_class.new([]) }.to raise_error FileNotProvidedError
    end
  end
end
