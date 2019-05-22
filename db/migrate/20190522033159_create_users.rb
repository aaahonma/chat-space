class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string      :nickname, null: false, index: true
      t.string      :email, null: false, unique: true
      t.string      :icon_image
      t.text        :introduction
      t.timestamps
    end
  end
end
