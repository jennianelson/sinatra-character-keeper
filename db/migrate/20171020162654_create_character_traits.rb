class CreateCharacterTraits < ActiveRecord::Migration
  def change
    create_table :character_traits do |t|
      t.integer :character_ids
      t.integer :trait_ids
    end
  end
end
