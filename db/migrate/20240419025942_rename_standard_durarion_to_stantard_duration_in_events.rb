class RenameStandardDurarionToStantardDurationInEvents < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :standard_durarion, :standard_duration
  end
end
