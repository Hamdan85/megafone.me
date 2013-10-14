class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.string :name
      t.string :email
      t.text :depo
      t.string :fb
      t.string :photo
      t.boolean :accepted
      t.boolean :cleared

      t.timestamps
    end
  end
end
