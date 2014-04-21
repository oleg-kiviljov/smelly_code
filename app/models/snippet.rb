class Snippet < ActiveRecord::Base

  default_scope { order(created_at: :desc) }

  # Pagination
  self.per_page = 10

  validates :title, :description, :smelly_body, :lexer_id, presence: true
  validates :title, length: {maximum: 200}
  validates :description, length: {minimum: 50, maximum: 300}

  belongs_to :lexer
  belongs_to :user

  # Select status
  scope :smelly, -> { where(clean_body: nil) }
  scope :cleaned, -> { where.not(clean_body:  nil) }
  scope :status, ->(status) { public_send(status) }

  # Select lexers
  scope :lexers, -> (lexer_ids) { where(lexer_id: lexer_ids) }

  # Select post date
  scope :today, -> { where(created_at: DateTime.current.beginning_of_day..DateTime.current.end_of_day) }
  scope :yesterday, -> { where(created_at: DateTime.yesterday.beginning_of_day..DateTime.yesterday.end_of_day) }
  scope :this_week, -> { where(created_at: DateTime.current.beginning_of_week..DateTime.current.end_of_week) }
  scope :this_month, -> { where(created_at: DateTime.current.beginning_of_week..DateTime.current.end_of_week) }
  scope :posted, ->(posted) { public_send(posted) }

end
