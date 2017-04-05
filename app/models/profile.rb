class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://s3.eu-central-1.amazonaws.com/stark-mountain-25477/profiles/avatars/default-avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
