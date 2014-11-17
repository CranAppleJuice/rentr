class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title, index: true
      t.text :description
      t.string :location, index: true
      t.string :housing_type, index: true
      t.date :available_from
      t.date :available_to
      t.integer :price
      t.references :user

      t.timestamps
    end
  end
end
