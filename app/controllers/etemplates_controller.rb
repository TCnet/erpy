class EtemplatesController < ApplicationController
  before_action :logged_in_user
  include EtemplatesHelper
  include ApplicationHelper

  def new
    @etemplate = Etemplate.new
  end

  def create
    @etemplate = current_user.etemplates.build(etemplate_params)
    if @etemplate.save
      set_current_used @etemplate,current_user.etemplates
      flash[:success] = "Template created"
      redirect_to etemplates_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

    @etemplate = Etemplate.find(params[:id])

  end

  def edit
    @etemplate = Etemplate.find(params[:id])
  end

  def destroy
    Etemplate.find(params[:id]).destroy
    flash[:success] = "Template deleted"
    redirect_to etemplates_path
  end

  def update
    @etemplate = Etemplate.find(params[:id])
    if @etemplate.update(etemplate_params)
      set_current_used @etemplate,current_user.etemplates
      flash[:success] = "Template updated"
      redirect_to etemplates_path
    else
      render 'edit', status: :unprocessable_entity
    end

  end
  #end update

  def index
    @etemplates = current_user.etemplates.order(isused: :desc).order(created_at: :desc).paginate(page: params[:page])
  end



  private

    def etemplate_params
      params.require(:etemplate).permit(:name, :title, :isused)
    end
end
