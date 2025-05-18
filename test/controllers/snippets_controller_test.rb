require "test_helper"

class SnippetsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  fixtures :users

  def setup
    @user = users(:one)
    sign_in @user
  end

  test "should get new" do
    get new_snippet_url
    assert_response :success
  end

  test "should create snippet" do
    tag1 = Tag.create(name: "test_tag_1")
    tag2 = Tag.create(name: "test_tag_2")

    assert_difference("Snippet.count") do
      post snippets_url, params: { snippet: { title: "My Snippet", language: "Ruby", code: "puts 'hello'", description: "A simple snippet", privacy: "public", tag_ids: [ tag1.id, tag2.id ] } }
    end

    assert_redirected_to snippet_path(Snippet.last)
  end

  test "should get index" do
    get snippets_url
    assert_response :success
  end

  test "should get show" do
    snippet = snippets(:one) # Assuming you have snippets in your fixtures
    get snippet_url(snippet)
    assert_response :success
  end

  # Add tests for edit, update, and destroy if needed
end
