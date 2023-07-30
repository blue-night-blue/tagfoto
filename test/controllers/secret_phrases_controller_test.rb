require "test_helper"

class SecretPhrasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @secret_phrase = secret_phrases(:one)
  end

  test "should get index" do
    get secret_phrases_url
    assert_response :success
  end

  test "should get new" do
    get new_secret_phrase_url
    assert_response :success
  end

  test "should create secret_phrase" do
    assert_difference("SecretPhrase.count") do
      post secret_phrases_url, params: { secret_phrase: { password_digest: @secret_phrase.password_digest, user_id: @secret_phrase.user_id } }
    end

    assert_redirected_to secret_phrase_url(SecretPhrase.last)
  end

  test "should show secret_phrase" do
    get secret_phrase_url(@secret_phrase)
    assert_response :success
  end

  test "should get edit" do
    get edit_secret_phrase_url(@secret_phrase)
    assert_response :success
  end

  test "should update secret_phrase" do
    patch secret_phrase_url(@secret_phrase), params: { secret_phrase: { password_digest: @secret_phrase.password_digest, user_id: @secret_phrase.user_id } }
    assert_redirected_to secret_phrase_url(@secret_phrase)
  end

  test "should destroy secret_phrase" do
    assert_difference("SecretPhrase.count", -1) do
      delete secret_phrase_url(@secret_phrase)
    end

    assert_redirected_to secret_phrases_url
  end
end
