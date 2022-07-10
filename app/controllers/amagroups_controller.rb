class AmagroupsController < ApplicationController
  before_action :logged_in_user
  include ApplicationHelper
  def new
    @amagroup = Amagroup.new
    @amatemps=user_amatemps
  end

  def create
    @amagroup = current_user.amagroups.build(amagroup_params)
    if @amagroup.save
      add_amagrouptwitha   @amagroup
      set_current_used @amagroup,current_user.amagroups
      flash[:success] = "Amagroup created"
      redirect_to amagroups_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

    @amagroup = Amagroup.find(params[:id])

  end

  def edit
    @amagroup = Amagroup.find(params[:id])
    @amatemps=user_amatemps
  end

  def destroy
    Amagroup.find(params[:id]).destroy
    flash[:success] = "Amagroup deleted"
    redirect_to amagroups_path
  end

  def update
    @amagroup = Amagroup.find(params[:id])
    # ss= params.require(:amatemp)["sport_type1"]
    # flash[:success] = ss
    # redirect_to amagroups_path

    if @amagroup.update(amagroup_params)
      add_amagrouptwitha   @amagroup
      set_current_used @amagroup,current_user.amagroups
      flash[:success] = "amagroup updated"
      redirect_to amagroups_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  #end update

  def index
    @amagroups = current_user.amagroups.order(isused: :desc).order(created_at: :desc).paginate(page: params[:page])
  end

  #add add_amatwitha
   def add_amagrouptwitha agroup
     user_amatemps.each do |ama|
       valueid = params.require(:amatemp)[ama.id.to_s]
       amagroupwith= agroup.amagroupwithas.where("amatemp_id =? ",ama.id)
       if valueid==ama.id.to_s
          if(amagroupwith.count==0)
            amagroupwith = Amagroupwitha.new
            amagroupwith.amagroup= agroup
            amagroupwith.amatemp = ama
            amagroupwith.save
          end
       else
         if(amagroupwith.count>0)
           amagroupwith= amagroupwith.first
           amagroupwith.destroy
         end
       end

     end
   end



  private
    def amagroup_params
      params.require(:amagroup).permit(:name, :remark, :isused)
    end

    def user_amatemps
      current_user.amatemps.where("isused")
    end
end
