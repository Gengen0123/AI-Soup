class SoupQuestionsController < ApplicationController
  before_action :set_soup_question, only: %i[show edit update destroy answer check_answer give_up retry_attempt]
  before_action :require_login, only: %i[mine new create edit update destroy]
  before_action :require_owner, only: %i[edit update destroy]
    # GET /soup_questions
  def index
    @soup_questions = SoupQuestion.all
  end

  def mine
  @soup_questions = current_user.soup_questions.order(created_at: :desc)
end

  # GET /soup_questions/:id
def show
  @attempt = current_soup_question_attempt
  @question = Question.new
  @questions = @attempt.questions.order(created_at: :desc)

  @rating = current_user ? @soup_question.soup_question_ratings.find_by(user: current_user) : nil
end

  # GET /soup_questions/new
  def new
    @soup_question = SoupQuestion.new
  end

  # GET /soup_questions/:id/edit
  def edit
  end

  # POST /soup_questions
def create
  @soup_question = current_user.soup_questions.build(soup_question_params)

  respond_to do |format|
    if @soup_question.save
      format.html { redirect_to @soup_question, notice: "問題を作成しました。" }
      format.json { render :show, status: :created, location: @soup_question }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @soup_question.errors, status: :unprocessable_entity }
    end
  end
end

  # PATCH/PUT /soup_questions/:id
  def update
    respond_to do |format|
      if @soup_question.update(soup_question_params)
        format.html { redirect_to @soup_question, notice: "問題を更新しました。", status: :see_other }
        format.json { render :show, status: :ok, location: @soup_question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @soup_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /soup_questions/:id
  def destroy
    @soup_question.destroy!

    respond_to do |format|
      format.html { redirect_to soup_questions_path, notice: "問題を削除しました。", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /soup_questions/:id/answer
  def answer
    @answer_text = ""
    @is_correct = false
  end


  
  # POST /soup_questions/:id/check_answer
  def check_answer
    @answer_text = params[:answer_text].to_s.strip

    if @answer_text.blank?
      @is_correct = false
      @error_message = "回答を入力してください"
      render :answer, status: :unprocessable_entity
      return
    end

    @is_correct = judge_correct_answer(@soup_question, @answer_text)

    if @is_correct
  @attempt = current_soup_question_attempt
  @attempt.questions.destroy_all
  @attempt.update!(solved: true)

  render :answer, status: :ok
else
  @error_message = "まだ正解ではありません。もう少し質問してみましょう。"
  render :answer, status: :unprocessable_entity
end
  end

def give_up
  @attempt = current_soup_question_attempt
  @attempt.questions.destroy_all
  @attempt.update!(gave_up: true)

  redirect_to @soup_question, notice: "ギブアップしました。解説を表示します。"
end

def retry_attempt
  @attempt = current_soup_question_attempt
  @attempt.questions.destroy_all
  @attempt.update!(gave_up: false, solved: false)

  redirect_to @soup_question, notice: "もう一度挑戦できます。"
end

  private

  def set_soup_question
    @soup_question = SoupQuestion.find(params.expect(:id))
  end

  def current_soup_question_attempt
  @current_soup_question_attempt ||= SoupQuestionAttempt.find_or_create_by!(
    soup_question: @soup_question,
    session_token: current_session_token
  ) do |attempt|
    attempt.user = current_user if current_user.present?
  end
end

def require_owner
  unless @soup_question.user == current_user
    redirect_to soup_question_path(@soup_question), alert: "この問題を編集する権限がありません。"
  end
end

  def soup_question_params
    params.expect(soup_question: [:title, :body, :answer, :explanation])
  end

  def judge_correct_answer(soup_question, answer_text)
    client = OpenAI::Client.new(
      access_token: ENV.fetch("OPENAI_API_KEY")
    )

    response = client.chat(
      parameters: {
        model: "gpt-4.1-mini",
        messages: [
          {
            role: "system",
            content: "あなたはウミガメのスープの正解判定者です。ユーザーの回答が正解の本質を満たしているかを判定してください。完全な文章一致は不要です。言い換え、要約、多少の表現違いがあっても、重要な原因・人物・出来事が合っていれば正解にしてください。必ず「正解」または「不正解」のどちらか一語だけで答えてください。"
          },
          {
            role: "user",
            content: "問題文: #{soup_question.body}\n正解: #{soup_question.answer}\n解説: #{soup_question.explanation}\nユーザーの回答: #{answer_text}"
          }
        ]
      }
    )

    result = response.dig("choices", 0, "message", "content").to_s.strip

    Rails.logger.debug "AI answer judge result: #{result}"

    result.start_with?("正解")
  end
end