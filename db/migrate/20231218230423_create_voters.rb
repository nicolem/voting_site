class CreateVoters < ActiveRecord::Migration[7.1]
  def change
    create_table :voters, id: :uuid do |t|
      t.string :email
      t.string :zip_code
      t.integer :candidate_id

      t.timestamps
    end
  end
end
