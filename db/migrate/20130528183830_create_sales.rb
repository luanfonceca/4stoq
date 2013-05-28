class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.datetime :date

      t.timestamps
    end
  end
end
