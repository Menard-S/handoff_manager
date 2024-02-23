class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
  
    # GET /categories
    def index
      @categories = Category.all
    end
  
    # GET /categories/new
    def new
      @category = Category.new
    end
  
    # POST /categories
    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to @category, notice: 'Category was successfully created.'
      else
        render :new
      end
    end
  
    # GET /categories/:id
    def show
    end
  
    # GET /categories/:id/edit
    def edit
    end
  
    # PATCH/PUT /categories/:id
    def update
      if @category.update(category_params)
        redirect_to @category, notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /categories/:id
    def destroy
      @category.destroy
      redirect_to categories_url, notice: 'Category was successfully destroyed.'
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions
    def set_category
      @category = Category.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through
    def category_params
        # Start with the base permitted parameters
        permitted_params = params.require(:category).permit(:name, :billing_unit)
      
        # Depending on the billing unit, merge in the pricing information
        pricing_params = case permitted_params[:billing_unit]
                         when 'HOURS'
                           { pricing: { hourly: params[:hourly_rate].to_f } }
                         when 'WORDS'
                           { pricing: {
                               new: params[:new_word].to_f,
                               fuzzy_75_84: params[:fuzzy_75_84].to_f,
                               fuzzy_85_94: params[:fuzzy_85_94].to_f,
                               fuzzy_95_99: params[:fuzzy_95_99].to_f,
                               leveraged: params[:leveraged_match].to_f
                             } }
                         else
                           { pricing: nil }
                         end
      
        # Merge the pricing params with the permitted params and return
        permitted_params.merge(pricing_params)
      end
      

  end
  