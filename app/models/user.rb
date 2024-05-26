class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Define ransackable attributes for searching
  def self.ransackable_attributes(auth_object = nil)
    %w[email first_name last_name created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
