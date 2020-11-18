class ChangeGroupToText < ActiveRecord::Migration[5.1]
  def change
    change_column(:menus, :group, :text)
  end
end
