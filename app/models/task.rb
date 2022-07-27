class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true

  enum status: {
    not_yet:0,doing:1,done:2
  }
  enum priority:{
    high:0, medium:1, low:2
  }

#def search_and

  scope :search_and, -> (title, status){ where('title LIKE ?',"%#{title}%").where(status: status) if title.present? && status.present?}

  scope :title_search, -> (title){where('title LIKE ?',"%#{title}%") if title.present?}

  scope :status_search, -> (status){where(status: status) if status.present?}

end
