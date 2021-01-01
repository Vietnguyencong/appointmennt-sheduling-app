class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :appointments
  has_many_attached :images
  # return the image with the more proper size
  # upload the single image
  # def avatar_thumbnail (image)
  #   if (image.attached?)
  #     return self.images[image].variant(resize :'300x300!').processed
  #   else
  #     "profile.png"
  #   end
  # end
  # upload the multiple image # passing 
  def avatar_thumbnail (image)
      return self.images[image].variant(resize_to_fill:[200,200]).processed
  end

  def display_avatar
    image = ActiveStorage::Attachment.where(:id => avatar_id).first
    if image
      return image.variant(resize_to_fill:[200,200]).processed
    else
      return "profile.png"
    end
  end
  private 
end
