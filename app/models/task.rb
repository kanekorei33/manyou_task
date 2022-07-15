class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true

  enum status: {
    not_yet:0,doing:1,done:2
  }
  enum priority:{
    high:0, medium:1, low:2
  }


  scope :search_and, -> (title, status){ where('title LIKE ?',"%#{title}%").where(status: status)} #if title.present? && status.present?

  scope :title_search, -> (title){where('title LIKE ?',"%#{title}%")}

  scope :status_search, -> (status){where(status: status)}

end
