# coding: utf-8
module AlbumsHelper
  include ColorCode
  include SizeCode
  include EtemplateSeed

  def get_template(user)
    etemplate =  user.etemplates.first
    if(user.etemplates.count>0)
      etemplate = user.etemplates.order(isused: :desc).order(created_at: :desc).first

    else
      etemplate = user.etemplates.build()
      etemplate.name="Default_template_2015"
      etemplate.title=DEFAULT_E
      etemplate.isused= true
      etemplate.save

    end
    return etemplate
  end

  def category_for(all)
    result= []
    all.each do |f|
      # result << f.name.upcase.split('0').first
      result << f.name.upcase.scan(/^[A-Z]*/).join('')
    end
    result = result.uniq
  end


  def get_titlenumber(str,title)
    i=0
    str.each_with_index do |f,n|
      if(f.include?title)
       i=i+1
      end
    end
    return i
  end


  def keywords_for(num,keywords)

    s= keywords.in_groups(num, false) {|group| p group}

  end

  def keywords_for3(num=250,keywords)
    key_length = keywords.tr(" ","").length
    m = key_length / num
    n =  key_length % num
    key_array =  keywords.split(' ')
    s= key_array.in_groups(m+1, false) {|group| p group}


  end

  def code_for(photos,stylecode)
    code=[]
    strcode = ''

    if stylecode.nil? || stylecode.empty?
      stylecode="$$xx"
    end
    n  = stylecode.index("$")
    m = stylecode.scan(/[$]/).length
    #获取颜色分组

    photos.each do |f|
      if(f.name.downcase =~ (/^sku/))
          name = f.name[0,5].downcase
      else
        if f.name.length < stylecode.length
          name = f.name[0,2].downcase
        else
          name = f.name[n,m].downcase
        end
      end



      if !strcode.include? name
        strcode += name
        strcode +=" "

      end


    end

    code = strcode.split(' ')
    return code


  end


  def fullname_for(brand,name,color,size)
    return brand+" "+name+" "+color +" "+ size
  end



  def twoarray_for(dsize)
    ob = dsize.tr("\n","|").split('|')
    result = Array.new
    ob.each_with_index do |f,n|

      result[n]= f.split(' ')

    end
    return result
  end




  def points_for(points)
    ob = points.tr("\n","|").split('|')
    #ob= points.split('|')
   # if ob.length==1
     # ob = points.split('\n')
    #end
    return ob
  end

  def herf_for(str)
    ob = str.tr("\n","|").split('|')

  end

# stock or weight to two arry
  def stock_two_arry(codelength,csizelength,stock,insert_str=0)
    inse_str =insert_str
    ob = stock.tr("\n","|").split('|').map{|x| x.strip }
    if(ob.length>1)


      result = Array.new
      codelength.times do |n|
        if(ob.length>=codelength)
          mob= ob[n].split(' ')
          result[n]= ob[n].split(' ').map{|item| (inse_str==0) ? item.to_i :  item.to_s}
        else
          if(ob.length>=n+1)
            result[n] = ob[n].split(' ').map{|item| (inse_str==0) ? item.to_i :  item.to_s}
          else
            result[n]=Array.new(csizelength,inse_str)
          end
        end
      end

      return result
    elsif(stock.empty?)
      return Array.new(codelength, Array.new(csizelength, inse_str))
    elsif(stock.split(' ').length>1)
      s= stock.split(' ')
      if(s.length<csizelength)
        (csizelength-s.length).times do |f|
         s << inse_str
        end
      end
      s= s.map{|item| (inse_str==0) ? item.to_i :  item.to_s }
      return Array.new(codelength,s)
    else
      return Array.new(codelength, Array.new(csizelength,(inse_str==0) ? stock.to_i :  stock.to_s))
    end

  end

# get amatempwith value
  def getamavalue(amatemp,album)
    amawith = album.amatwithas.where('amatemp_id=?',amatemp.id)
    if(amawith.count>0)
      amawith.first.value
    end
  end


end
