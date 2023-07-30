class SecretPhrasesController < ApplicationController
  before_action :set_secret_phrase, only: %i[ show edit update destroy ]

  # GET /secret_phrases or /secret_phrases.json
  def index
    @secret_phrases = SecretPhrase.all
  end

  # GET /secret_phrases/1 or /secret_phrases/1.json
  def show
  end

  # GET /secret_phrases/new
  def new
    @secret_phrase = SecretPhrase.new
  end

  # GET /secret_phrases/1/edit
  def edit
  end

  # POST /secret_phrases or /secret_phrases.json
  def create
    @secret_phrase = SecretPhrase.new(secret_phrase_params)
    @secret_phrase.user_id=@current_user.id

    respond_to do |format|
      if @secret_phrase.save
        format.html { redirect_to setting_path, notice: "Secret phrase was successfully created." }
        format.json { render :show, status: :created, location: @secret_phrase }
      else
        format.html { redirect_to setting_path, notice: "空白です" }
        format.json { render json: @secret_phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secret_phrases/1 or /secret_phrases/1.json
  def update
    respond_to do |format|
      if @secret_phrase.update(secret_phrase_params)
        format.html { redirect_to setting_path, notice: "Secret phrase was successfully updated." }
        format.json { render :show, status: :ok, location: @secret_phrase }
      else
        format.html { redirect_to setting_path, notice: "空白です2" }
        format.json { render json: @secret_phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secret_phrases/1 or /secret_phrases/1.json
  def destroy
    @secret_phrase.destroy

    respond_to do |format|
      format.html { redirect_to secret_phrases_url, notice: "Secret phrase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secret_phrase
      @secret_phrase = SecretPhrase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def secret_phrase_params
      params.require(:secret_phrase).permit(:user_id, :password)
    end
end
