class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = current_user.categories.order(:name)
  end

  def new
    @category = Category.new
    @category.pricing = { 'hourly_rate' => 0, 'new_word' => 0, 'fuzzy_75_84' => 0, 'fuzzy_85_94' => 0, 'fuzzy_95_99' => 0, 'leveraged_match' => 0 }
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to @category, notice: 'Cost code was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Cost code was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @category.tasks.any?
      message = "This cost code has pending task(s). Empty the cost code first!"
      redirect_to categories_path, alert: message
    else
      @category.destroy
      redirect_to categories_path, notice: 'Cost code was successfully deleted.'
    end
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    permitted_params = params.require(:category).permit(:name, :billing_unit)
    pricing_params = case permitted_params[:billing_unit]
                      when 'HOURS'
                        { pricing: { hourly: params[:hourly_rate].to_f } }
                      when 'WORDS'
                        { pricing: {
                            new_word: params[:new_word].to_f,
                            fuzzy_75_84: params[:fuzzy_75_84].to_f,
                            fuzzy_85_94: params[:fuzzy_85_94].to_f,
                            fuzzy_95_99: params[:fuzzy_95_99].to_f,
                            leveraged_match: params[:leveraged_match].to_f
                          } }
                      else
                        { pricing: nil }
                      end
    permitted_params.merge(pricing_params)
  end
end
