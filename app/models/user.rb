class User < ApplicationRecord
  has_many :favorites 
  validates_presence_of :name, :email
  validates_uniqueness_of :email, :api_key

  before_save :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.alphanumeric(28) if self.api_key.nil?
  end
end