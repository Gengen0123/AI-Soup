require "test_helper"

class SoupQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @soup_question = soup_questions(:one)
  end

  test "should get index" do
    get soup_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_soup_question_url
    assert_response :success
  end

  test "should create soup_question" do
    assert_difference("SoupQuestion.count") do
      post soup_questions_url, params: { soup_question: { answer: @soup_question.answer, body: @soup_question.body, explanation: @soup_question.explanation, title: @soup_question.title } }
    end

    assert_redirected_to soup_question_url(SoupQuestion.last)
  end

  test "should show soup_question" do
    get soup_question_url(@soup_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_soup_question_url(@soup_question)
    assert_response :success
  end

  test "should update soup_question" do
    patch soup_question_url(@soup_question), params: { soup_question: { answer: @soup_question.answer, body: @soup_question.body, explanation: @soup_question.explanation, title: @soup_question.title } }
    assert_redirected_to soup_question_url(@soup_question)
  end

  test "should destroy soup_question" do
    assert_difference("SoupQuestion.count", -1) do
      delete soup_question_url(@soup_question)
    end

    assert_redirected_to soup_questions_url
  end
end
