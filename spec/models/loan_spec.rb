require 'spec_helper'

describe Loan do
  describe "#amount_remaining" do
    subject { described_class.new(amount: 100) }
    it "defaults to the amount of the loan" do
      expect(subject.amount_remaining).to eq subject.amount
    end
    it "subtracts the amounts of any bids from the loan amount" do
      subject.bids.build(amount: 40)
      expect(subject.amount_remaining).to eq 60
    end
  end
end
