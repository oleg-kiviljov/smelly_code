class User < ActiveRecord::Base

  has_settings do |s|
    s.key :snippets, defaults:{ theme: 'github', line_numbers: 'inline', minimize: false }
  end

  devise :database_authenticatable, :registerable, :recoverable,  :trackable

  validates :username, :email, presence: true
  validates :username, length: {minimum: 4, maximum: 20}
  validates :username, :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

  has_many :snippets

  def self.user_exists?(login)
    # username and email are unique attributes
    where("username = ? OR email = ?", login.downcase, login.downcase).present?
  end

  def self.find(input)
    # Override find for username-slug
    input.to_i == 0 ? find_by(username: input) : super
  end

  def to_param
    username
  end

end
