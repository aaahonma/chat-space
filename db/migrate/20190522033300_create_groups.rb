class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string        :name, null: false, unique: true, index: true
      t.timestamps
    end
  end
end
