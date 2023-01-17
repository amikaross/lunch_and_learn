class User < ApplicationRecord
  has_many :favorites 
  validates_presence_of :name, :email
  validates_uniqueness_of :email

  before_save :generate_api_key

  def generate_api_key
    key = SecureRandom.alphanumeric(28)
    until User.find_by(api_key: key).nil?
      key = SecureRandom.alphanumeric(28)
    end
    self.api_key = key
  end
end