class Snippet < ApplicationRecord
  belongs_to :user
  has_many :snippet_tags
  has_many :tags, through: :snippet_tags
  attr_accessor :tag_list

  validates :title, presence: true
  validates :code, presence: true
  validates :language, presence: true
  validates :privacy, inclusion: { in: %w[public private] }

  def save_tags
    # Logic to handle saving tags based on the tag_list attribute
    # This will depend on how you want to associate tags with snippets.
    # For a simple example, if you have a Tag model and a SnippetTag join table:

    # Remove existing tags for this snippet
    snippet_tags.destroy_all

    # Split the tag_list string into individual tags (e.g., by comma)
    tags = tag_list.to_s.split(",").map(&:strip).reject(&:blank?).uniq

    # Create or find each tag and associate it with the current snippet
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      snippet_tags.create(tag: tag)
    end
  end
end
