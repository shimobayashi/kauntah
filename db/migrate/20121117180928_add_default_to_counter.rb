class AddDefaultToCounter < ActiveRecord::Migration
  def change
    change_column_default :counters, :count, 0
  end
end
