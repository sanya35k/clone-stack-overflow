require 'pry'

class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_question, only: [:create, :new, :destroy]
  before_action :find_answer, only: [:show, :destroy]

  def show
  end

  def new
    @answer = @question.answers.build
  end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end