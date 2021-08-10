class Book < ApplicationRecord
  is_impressionable

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  validates :rate, presence: true, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }

  belongs_to :user
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 13.day.ago.beginning_of_day..1.week.ago.end_of_day) }


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(word, search)
    if search == "perfect_match"
      Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      Book.where("title LIKE?", "#{word}%")
    elsif search == "backword_match"
      Book.where("title LIKE?", "%#{word}")
    elsif search == "backword_match"
      Book.where("title LIKE?", "%#{word}%")
    else
      Book.all
    end
  end

  def self.cate_search(search)
    Book.where("category LIKE?", "#{search}")
  end
end
