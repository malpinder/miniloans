class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.integer :loan_id
      t.integer :amount

      t.timestamps
    end
  end
end
