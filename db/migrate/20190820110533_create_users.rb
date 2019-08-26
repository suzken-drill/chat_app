class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.references :room, null: false, index: true
      t.string :session_key, null: false, limit: 16
      t.datetime :deleted_at, null: true, default: nil

      t.timestamps
    end
  end
end
