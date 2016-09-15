class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :student
      t.decimal :amount, precision: 8, scale: 2
      t.date :received_at
    end
  end
end
