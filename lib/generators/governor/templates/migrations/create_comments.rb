class GovernorCreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string      :title, :content
      t.boolean     :hidden, :default => false
      t.references  :commenter, :polymorphic => true
      t.references  :<%= mapping.singular %>
      t.timestamps
    end
  
    create_table :guests do |t|
      t.string      :name
      t.string      :email
      t.string      :website
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
    drop_table :guests
  end
end
