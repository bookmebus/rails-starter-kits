class Quote::SubmissionsController < ApplicationController
  before_action :set_quote_submission, only: [:show, :edit, :update, :destroy]

  # GET /quote/submissions
  # GET /quote/submissions.json
  def index
    @quote_submissions = Quote::Submission.includes(:contact, :pickup_address, :delivery_address, :shipment_items).all
  end

  # GET /quote/submissions/1
  # GET /quote/submissions/1.json
  def show
  end

  # GET /quote/submissions/new
  def new
    @quote_submission = Quote::Submission.new
    @quote_submission.build_pickup_address
    @quote_submission.build_delivery_address
    @quote_submission.shipment_items.build
    @quote_submission.build_contact
  end

  # GET /quote/submissions/1/edit
  def edit
  end

  # POST /quote/submissions
  # POST /quote/submissions.json
  def create
    @quote_submission = Quote::Submission.new(quote_submission_params)

    respond_to do |format|
      if @quote_submission.save
        format.html { redirect_to @quote_submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @quote_submission }
      else
        format.html { render :new }
        format.json { render json: @quote_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quote/submissions/1
  # PATCH/PUT /quote/submissions/1.json
  def update
    respond_to do |format|
      if @quote_submission.update(quote_submission_params)
        format.html { redirect_to @quote_submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote_submission }
      else
        format.html { render :edit }
        format.json { render json: @quote_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quote/submissions/1
  # DELETE /quote/submissions/1.json
  def destroy
    @quote_submission.destroy
    respond_to do |format|
      format.html { redirect_to quote_submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote_submission
      @quote_submission = Quote::Submission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_submission_params
      result = params.require(:quote_submission).permit(
            pickup_address_attributes: [:id, :name, :lat, :lon], 
            delivery_address_attributes: [:id, :name, :lat, :lon],
            contact_attributes: [:id, :name, :email, :phone_number, :title],
            shipment_items_attributes: [:id, :width, :length, :height, :weight, :weight_unit, :dimension_unit]
          )
      result
    end
end
