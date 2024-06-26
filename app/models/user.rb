class User < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :user_questions, dependent: :destroy
  has_many :questions, through: :user_questions
  has_one :statistic, dependent: :destroy

  after_create :create_statistic

  # Permet la connexion via email ou pseudo
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase }]).first
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # Ajoute un attribut virtuel pour le login
  attr_writer :login

  # def avatar_url
  #   Cloudinary::Utils.cloudinary_url(avatar, width: 100, height: 100, crop: :fill) if avatar.present?
  # end
  def avatar_url
    avatar if avatar.present?
  end

  private
  
  def create_statistic
    Statistic.create(user: self)
  end
  
  def login
    @login || self.username || self.email
  end
  
  # Define ransackable attributes for searching
  def self.ransackable_attributes(auth_object = nil)
    %w[email username first_name last_name created_at updated_at]
  end
  
  def self.ransackable_associations(auth_object = nil)
    []
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]
end
