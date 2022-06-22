class AmatempsController < ApplicationController

  def new
    @amatemp = Amatemp.new
  end

  def create
    @Amatemp = current_user.amatemps.build(amatemp_params)
    if @Amatemp.save
      flash[:success] = "Amatemp created"
      redirect_to amatemps_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

    @amatemp = Amatemp.find(params[:id])

  end

  def edit
    @amatemp = Amatemp.find(params[:id])
  end

  def destroy
    Amatemp.find(params[:id]).destroy
    flash[:success] = "Amatemp deleted"
    redirect_to amatemps_path
  end

  def update
    @amatemp = Amatemp.find(params[:id])
    if @amatemp.update(amatemp_params)
      flash[:success] = "amatemps updated"
      redirect_to amatemps_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  #end update

  def index
    @amatemps = current_user.amatemps.order(isused: :desc).order(created_at: :desc).paginate(page: params[:page])
  end



  private
    def amatemp_params
      params.require(:amatemp).permit(:name, :value, :isused)
    end
end
