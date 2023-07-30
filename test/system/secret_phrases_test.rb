require "application_system_test_case"

class SecretPhrasesTest < ApplicationSystemTestCase
  setup do
    @secret_phrase = secret_phrases(:one)
  end

  test "visiting the index" do
    visit secret_phrases_url
    assert_selector "h1", text: "Secret phrases"
  end

  test "should create secret phrase" do
    visit secret_phrases_url
    click_on "New secret phrase"

    fill_in "Password digest", with: @secret_phrase.password_digest
    fill_in "User", with: @secret_phrase.user_id
    click_on "Create Secret phrase"

    assert_text "Secret phrase was successfully created"
    click_on "Back"
  end

  test "should update Secret phrase" do
    visit secret_phrase_url(@secret_phrase)
    click_on "Edit this secret phrase", match: :first

    fill_in "Password digest", with: @secret_phrase.password_digest
    fill_in "User", with: @secret_phrase.user_id
    click_on "Update Secret phrase"

    assert_text "Secret phrase was successfully updated"
    click_on "Back"
  end

  test "should destroy Secret phrase" do
    visit secret_phrase_url(@secret_phrase)
    click_on "Destroy this secret phrase", match: :first

    assert_text "Secret phrase was successfully destroyed"
  end
end
