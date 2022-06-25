# coding: utf-8
class AlbumsController < ApplicationController
 before_action :logged_in_user, only: [:index,:edit,:show, :create, :destroy]
 #before_action :correct_album, only: [:show,:edit, :update, :destroy]
 include PhotosHelper
 include AlbumsHelper
 include ExportExcel
 require "spreadsheet"

 Spreadsheet.client_encoding = "UTF-8"


  def index
   # @allalbums = current_user.albums
    @category = category_for current_user.albums

    sql = "name LIKE ?"
    #condition = params[:q].nil? "":"name like \%"+params[:q]+"\%"
   @albums = current_user.albums.where(sql,"%#{params[:q]}%").paginate(page: params[:page])
   # @albums = current_user.albums.search(params[:q]).paginate(page: params[:page])
  end



  def new
    @amatemps = user_amatemps
    @album = Album.new
    if !@album.brand?
      @album.brand = current_user.brand
    end
    if !@album.dnote?
      @album.dnote = current_user.note
    end
  end



  def exportexcel

    @album = Album.find(params["album"][:id])
    @album.update(album_params)
    add_amatwitha @album
    @etemplate = get_template current_user
    #title_arry = @etemplate.title.split(' ')
    path= File.join Rails.root, 'public/'
    #newalbums= Album.where(id: params[:id])
    newalbums = Album.where(id: @album.id)
    filename = @album.name
    if !newalbums.nil?

      outamazon newalbums,@etemplate,path,current_user,filename
    else
      flash[:danger] = "Please check album is exist!"
      redirect_to album_path
    end



  end

  def show
    @amatemps = user_amatemps
    @category = category_for current_user.albums

   # @in_select={"Yes"=>true,"No"=>false}
    @album = Album.find(params[:id])
   # @user_brand = current_user.brand
   # @user_note = current_user.note
    if !@album.brand?
      @album.brand = current_user.brand
    end
    if !@album.dnote?
      @album.dnote = current_user.note
    end
    photo_url = []
    @album.photos.each do |w|
      #photo_url << geturl(w.picture.url)
      photo_url << url_for(w.picture)
    end
    @photourls = photo_url.join(' ')

    @herf = herf_for @album.summary



  end



  def outexcel


    #id = params[:id]
    #id = (params[:album_ids] || []) if(id == "out_multiple")
    id = params[:album_ids]
    path= File.join Rails.root, 'public/'
    etemplate= get_template current_user

    filename = etemplate.name+"_"+Time.now.strftime('%Y-%m-%d')
    #flash[:sucess] = obs.first.name
    if(id.nil?||id.empty?)
      flash[:danger] = "Please select album first!"
      redirect_to albums_path
    else
      obs= Album.find id
      if(obs.nil?||obs.empty?)
        flash[:danger] = "Please check album exist!"
        redirect_to albums_path
      else
      outamazon obs,etemplate,path,current_user,filename


      end
    end


  end



  def download_excel
    #render html: "dd"+params["album"][:id]
    exportexcel
  end

#add add_amatwitha
 def add_amatwitha album
   user_amatemps.each do |ama|
     value = params.require(:amatemp)[ama.name]
     amatempwith= album.amatwithas.where("amatemp_id =? ",ama.id)
     if(amatempwith.count>0)
       amatempwith= amatempwith.first
     else
       amatempwith = Amatwitha.new(value: value)
     end
     amatempwith.album= album
     amatempwith.amatemp = ama
     amatempwith.value = value
     amatempwith.save
   end
 end


  def create
    @album = current_user.albums.build(album_params)
    @album.coverimg = "nopic.jpg"
    if @album.save
      add_amatwitha @album
        # s+= params.require(:amatemp)[ama.name]
        # s+=","
        # if s
        flash[:success] = "Album created!"
        redirect_to albums_path
        #
      else
        render :new, status: :unprocessable_entity
      end



    # @album = current_user.albums.build(album_params)
    # @album.coverimg = "nopic.jpg"
    # if @album.save
    #   flash[:success] = "Album created!"
    #   redirect_to albums_path
    #
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def edit
    @amatemps=user_amatemps
    @album = Album.find(params[:id])
    if !@album.brand?
      @album.brand = current_user.brand
    end
    if !@album.dnote?
      @album.dnote = current_user.note
    end
  end

  def destroy
    Album.find(params[:id]).destroy
    flash[:success] = "Album deleted"
    #redirect_to albums_path
    redirect_to albums_path, status: :see_other

  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      add_amatwitha @album
      flash[:success] = "Album updated"
      redirect_to albums_path
    else
      render :edit, status: :unprocessable_entity
    end

  end




  private

    def album_params
      params.require(:album).permit(:name, :summary,:csize,:ussize,:brand,:fullname,
        :fabric_type,:dname,:description,:dnote,:keywords,:points,:price,:stock,:asize,
      :package,:weight)
    end

    def user_amatemps
      if(current_user.amagroups.where("isused").count>0)
        agroup = current_user.amagroups.where("isused").order(created_at: :desc).first
        ss=""
        agroup.amagroupwithas.each do |ag|
          ss += ag.amatemp_id.to_s
          ss +=","
        end
        ss= ss.split(",")
        current_user.amatemps.where("isused").where(id: ss)
      else
        current_user.amatemps.where("isused")
      end


    end

    # def correct_album
    #   @album = Album.find(params[:id])
    #   redirect_to(albums_path) unless current_user.albums.include?(@album)
    # end

end
