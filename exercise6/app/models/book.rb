class Book < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
    validates :body,    length: { maximum: 200 }

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("body LIKE?","#{word}%")
    else
      @book = Book.all
    end
  end
end