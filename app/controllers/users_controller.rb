class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:edit,:index,:show]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @hash = Gmaps4rails.build_markers(@user) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
    # latlng = Geocoder.search(@user.city).first.coordinates
    # @hash = {lat: latlng[0], lng: latlng[1]}
    #チャット
    
    if user_signed_in?
            #Entry内のuser_idがcurrent_userと同じEntry
            @currentUserEntry = Entry.where(user_id: current_user.id)
            #Entry内のuser_idがMYPAGEのparams.idと同じEntry
            @userEntry = Entry.where(user_id: @user.id)
                #@user.idとcurrent_user.idが同じでなければ
                unless @user.id == current_user.id
                  @currentUserEntry.each do |cu|
                    @userEntry.each do |u|
                      #もしcurrent_user側のルームidと＠user側のルームidが同じであれば存在するルームに飛ぶ
                      if cu.room_id == u.room_id then
                        @isRoom = true
                        @roomId = cu.room_id
                      end
                    end
                  end
                  #ルームが存在していなければルームとエントリーを作成する
                  unless @isRoom
                    @room = Room.new
                    @entry = Entry.new
                  end
    end
   end
 end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
    @user = current_user
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）

  end
  def edit
  	@user = User.find(params[:id])
    if current_user != @user
        redirect_to user_path(current_user.id)
  end
end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end



  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :latitude, :longitude)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   

end
