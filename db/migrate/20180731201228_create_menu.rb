class CreateMenu < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string "category"
      t.text "substances"
    end
  end
end
