module AmagroupsHelper

  # get Amagroupwitha value
    def getamagcheck(amatemp,amagroup)
      amawith = amagroup.amagroupwithas.where('amatemp_id=?',amatemp.id)
      if(amawith.count>0)
        return true
      else
        return false
      end
    end


end
