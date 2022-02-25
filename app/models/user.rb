class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
  validates :password, length: {minimum: 5}
  has_secure_password

  def self.authenticate_with_credentials(params)
    user = User.find_by_email(params[:email])
    user && user.authenticate(params[:password])
  end
end
