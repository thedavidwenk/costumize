class AddPhotoUrlToCostumes < ActiveRecord::Migration[7.1]
  def change
    add_column :costumes, :photo_url, :string
  end
end
