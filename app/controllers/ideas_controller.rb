class IdeasController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      redirect_to root_path
    else
      flash.now[:alert] = @idea.errors.full_messages.join(', ')
      render :new
    end
  end

  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def show
    @review = Review.new
    @reviews = @idea.reviews.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @idea.update idea_params
      redirect_to idea_path(@idea)
    else
      flash.now[:alert] = @idea.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to root_path
  end

    @idea

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def authorize_user!
    unless can?(:manage, @idea)
      flash[:alert] = "Access Denied"
      redirect_to root_path
    end
  end

end
