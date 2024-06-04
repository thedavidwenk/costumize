class AddUserIdToCostumes < ActiveRecord::Migration[7.1]
  def change
    add_reference :costumes, :user, null: true, foreign_key: true
  end
end
