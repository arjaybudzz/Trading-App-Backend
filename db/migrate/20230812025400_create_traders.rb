class CreateTraders < ActiveRecord::Migration[7.0]
  def change
    create_table :traders do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :country
      t.decimal :balance
      t.boolean :approved
      t.belongs_to :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
