class CreateRappers < ActiveRecord::Migration
  def change
    create_table :rappers do |t|
      t.text :name
      t.int :pussy_count
      t.int :bitch_count
      t.int :ho_count
      t.int :overall_score
      t.int :song_count

      t.timestamps null: false
    end
  end
end
