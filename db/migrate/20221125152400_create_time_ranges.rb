class CreateTimeRanges < ActiveRecord::Migration[7.0]
  def change
    create_table :time_ranges do |t|
      t.belongs_to :booking, foreign_key: true
      t.date :date, index: true, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end

    add_index :time_ranges, [:date, :start_time, :end_time], unique: true
  end
end
