class Loan < ActiveRecord::Base

  has_many :bids
  has_many :comments

  def amount_remaining
    return amount if bids.empty?

    @amount_remaining ||= amount - bids.map(&:amount).reduce(&:+)
  end
end
