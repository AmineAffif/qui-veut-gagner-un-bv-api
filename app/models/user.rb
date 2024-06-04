class User < ApplicationRecord
  
  has_many :games
  has_one :statistic, dependent: :destroy

  after_create :create_statistic

  # Permet la connexion via email ou pseudo
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase }]).first
  end
  
  # Ajoute un attribut virtuel pour le login
  attr_writer :login

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
