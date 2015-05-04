class CreateRappers < ActiveRecord::Migration
  def change
    create_table :rappers do |t|
      t.text :name
      t.integer :pussy_count
      t.integer :bitch_count
      t.integer :ho_count
      t.integer :overall_score
      t.integer :song_count

      t.timestamps null: false
    end
  end
end
