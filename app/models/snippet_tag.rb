# app/models/snippet_tag.rb
class SnippetTag < ApplicationRecord
  belongs_to :snippet
  belongs_to :tag
end
