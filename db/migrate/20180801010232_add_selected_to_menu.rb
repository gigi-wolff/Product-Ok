class AddSelectedToMenu < ActiveRecord::Migration[5.1]
  def change
    add_column :menus, :selected, :boolean, default: false
  end
end
