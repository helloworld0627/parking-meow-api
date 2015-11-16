class CreateApiRequestSchedules < ActiveRecord::Migration
  def change
    create_table :api_request_schedules do |t|

      t.string :request_url, null: false
      t.string :file_path, null: false
      t.column :status, :integer, default: 0

      t.timestamps null: false
    end
  end
end
