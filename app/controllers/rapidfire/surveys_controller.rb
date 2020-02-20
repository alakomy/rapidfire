module Rapidfire
  class SurveysController < Rapidfire::ApplicationController
    before_action :authenticate_administrator!, except: :index

    def index

      if user_has_super_admin_role? || user_has_admin_role?
        surveys = Survey.all

      elsif user_has_relations_mgr_role?
        surveys = Survey.joins('LEFT JOIN "locations" ON "locations"."id" = "rapidfire_surveys"."location_id"')
                        .where(locations: { participating: true })

      elsif user_has_location_mgr_role?
        surveys = Survey.where(location_id: current_user.locations.pluck(:id) )

      else
        surveys = Survey.none
      end

      @surveys = surveys.order('rapidfire_surveys.id desc')


      # @surveys = if defined?(Kaminari)
      #   Survey.page(params[:page])
      # else
      #   @surveys
      # end
    end

    def new
      @survey = Survey.new
    end

    def create
      @survey = Survey.new(survey_params)
      puts "I am saving survey"
      if @survey.save
        respond_to do |format|
          format.html { redirect_to surveys_path }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.js
        end
      end
    end

    def edit
      @survey = Survey.find_by_api_id(params[:api_id])
    end

    def update
      @survey = Survey.find_by_api_id(params[:api_id])
      if @survey.update(survey_params)
        respond_to do |format|
          format.html { redirect_to surveys_path }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.js
        end
      end
    end

    def destroy
      @survey = Survey.find_by_api_id(params[:api_id])
      
      if @survey.active
        @survey.active = false
      else 
        @survey.active = true
      end  
        
      @survey.save!
      

      respond_to do |format|
        format.html { redirect_to surveys_path }
        format.js
      end
    end

    def results
      @survey = Survey.find_by_api_id(params[:api_id])
      @survey_results =
        SurveyResults.new(survey: @survey).extract

      respond_to do |format|
        format.json { render json: @survey_results, root: false }
        format.html
        format.js
      end
    end

    private

    def survey_params
      params.require(:survey).permit(:name, :introduction, :location_id, :api_id, :after_survey_content, :survey_api_id)
    end
  end
end
