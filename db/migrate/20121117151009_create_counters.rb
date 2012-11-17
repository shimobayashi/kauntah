class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string :owner
      t.integer :count

      t.timestamps

    end
    add_index :counters, :owner
  end
end
