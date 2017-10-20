class AddBookToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :book, :string
  end
end
