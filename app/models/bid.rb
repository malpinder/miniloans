class Bid < ActiveRecord::Base

  belongs_to :loan
  belongs_to :user

end
