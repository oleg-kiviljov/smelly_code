class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable,  :trackable, :validatable

  validates :username, :email, presence: true
  validates :username, length: {minimum: 4, maximum: 20}
  validates :username, :email, uniqueness: { case_sensitive: false }
  validates_format_of :email, with: email_regexp
  validates :password, length: { minimum: 8 }
  validates_confirmation_of :password

  has_many :snippets

  def self.user_exists?(login)
    # username and email are unique attributes
    where("username = ? or email = ?", login.downcase, login.downcase).present?
  end

  def self.find(input)
    input.to_i == 0 ? find_by(username: input) : super
  end

  def to_param
    username
  end

end
