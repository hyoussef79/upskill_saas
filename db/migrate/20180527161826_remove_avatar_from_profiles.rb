class RemoveAvatarFromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_columns :profiles, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at
  end
end
