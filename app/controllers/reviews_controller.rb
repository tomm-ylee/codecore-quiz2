class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_review, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def create
    @review = Review.new review_params
    @review.idea = Idea.find params[:idea_id]
    @review.user = current_user

    if @review.save
      redirect_to idea_path(@review.idea)
    else
      flash.now[:alert] = @review.errors.full_messages.join(', ')
      @idea = @review.idea
      @reviews = @idea.reviews.order(created_at: :desc)
      render "ideas/show"
    end
  end

  def destroy
    @review.destroy
    redirect_to idea_path(@review.idea)
  end

  private

  def find_review
    @review = Review.find params[:id]
  end

  def review_params
    params.require(:review).permit(:comment)
  end

  def authorize_user!
    unless can?(:manage, @review)
      flash[:alert] = "Access Denied"
      redirect_to root_path
    end
  end

end
