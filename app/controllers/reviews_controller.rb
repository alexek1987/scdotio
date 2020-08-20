class ReviewsController < ApplicationController
  def new
    @request = Request.find(params[:request_id])
    @review = Review.new
    @review.request = @request
    authorize @review
  end

  def create
    # find request to review
    @request = Request.find(params[:request_id])
    @review = Review.new(review_params)
    @review.request = @request
    authorize @review
    if @review.save
      redirect_to dashboard_path
    else
      render :new
    end
end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
