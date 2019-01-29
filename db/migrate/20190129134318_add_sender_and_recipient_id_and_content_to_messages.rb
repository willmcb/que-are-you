class AddSenderAndRecipientIdAndContentToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :user_id, :integer
    add_column :messages, :recipient_id, :integer
    add_column :messages, :content, :string
  end
end
