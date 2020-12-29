class Change < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :sex, :string, default: 'other'
  end

  def down
    change_column :users, :sex, :string
  end
end
