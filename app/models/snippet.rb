class Snippet < ActiveRecord::Base

  default_scope { order(created_at: :desc) }

  # Per page setting
  self.per_page = 10

  validates :title, :description, :smelly_body, :language_id, presence: true
  validates :title, length: {maximum: 200}
  validates :description, length: {minimum: 50, maximum: 300}

  belongs_to :language
  belongs_to :user

end
