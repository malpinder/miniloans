class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :title
      t.string :business_name
      t.integer :amount
      t.text :description

      t.timestamps
    end
  end
end
