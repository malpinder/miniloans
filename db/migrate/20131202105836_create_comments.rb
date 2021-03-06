class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :loan_id
      t.integer :user_id
      t.integer :parent_comment_id
      t.text :text

      t.timestamps
    end
  end
end
