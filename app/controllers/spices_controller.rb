class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :somemethod
    wrap_parameters format: []
    
    def index 
        render json: Spice.all
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, except: [:created_at, :updated_at], status: :created
    end

    def update
        spice = Spice.find(params[:id])
        spice.update(spice_params)
        render json: spice, except: [:created_at, :updated_at]
    end

    def destroy
        spice = Spice.find_by(params[:id])
        spice.destroy
        head :no_content
    end
    

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_response
        render json: { error: "Spice not found" }, status: :not_found
    end

end
