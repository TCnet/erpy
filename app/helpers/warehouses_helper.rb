module WarehousesHelper

  def set_current_warehorse(current_ware,user)
    obs =  user.warehouses
    is_current= current_ware.is_current
    obs.each_with_index do |f,e|
      if is_current
        if f!=current_ware
          f.is_current = false
          f.save
        end

      end
     
    end

  end

end
