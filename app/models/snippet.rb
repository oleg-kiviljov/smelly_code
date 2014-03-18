class Snippet < ActiveRecord::Base

  # Per page setting
  self.per_page = 10

  validates :title, :description, :smelly_body, presence: true
  validates :title, length: {maximum: 200}
  validates :description, length: {minimum: 100, maximum: 200}
  validates :smelly_body, length: {maximum: 500}

  belongs_to :language
  belongs_to :user

end
