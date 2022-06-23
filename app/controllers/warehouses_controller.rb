class WarehousesController < ApplicationController
  before_action :logged_in_user
  include WarehousesHelper
  def index

    @warehouses = current_user.warehouses
  end

  def destroy

    @warehouse = Warehouse.find(params[:id])
    name=@warehouse.name
    @warehouse.destroy
    flash[:success] = name+" deleted"
    redirect_to warehouses_path(@warehouse)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = current_user.warehouses.build(warehouse_params)

    if @warehouse.save
      set_current_warehorse @warehouse,current_user
      flash[:success] = "仓库新建成功!"
      redirect_to warehouses_path

    else
      render 'new', status: :unprocessable_entity
    end
  end



  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse =  Warehouse.find(params[:id])
    if @warehouse.update(warehouse_params)
      set_current_warehorse @warehouse,current_user
      flash[:success] = "warehouse  updated"
      redirect_to warehouses_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

    def warehouse_params
      params.require(:warehouse).permit(:name, :address, :is_current)
    end


end
