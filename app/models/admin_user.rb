# app/models/admin_user.rb
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Define ransackable attributes for searching
  def self.ransackable_attributes(auth_object = nil)
    %w[email created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
