class Snippet < ApplicationRecord
  belongs_to :user
  has_many :snippet_tags
  has_many :tags, through: :snippet_tags

  validates :title, presence: true
  validates :code, presence: true
  validates :language, presence: true
  validates :privacy, inclusion: { in: [ "public", "private", "unlisted" ] }
end
