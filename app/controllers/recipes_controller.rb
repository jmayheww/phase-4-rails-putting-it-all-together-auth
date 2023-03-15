class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []
  before_action :authorize

  def index
    recipes = Recipe.all
    render json: recipes, status: :ok
  end

  def create
    user = User.find_by(id: session[:user_id])
    recipe = user.recipes.create!(recipe_params)
    render json: recipe, status: :created
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete, :user_id)
  end

  def authorize
    return render json: { errors: ['Not authorized'] }, status: :unauthorized unless session.include? :user_id
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
