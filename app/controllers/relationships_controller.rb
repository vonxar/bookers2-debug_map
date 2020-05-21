class RelationshipsController < ApplicationController
  before_action :currentuser,only: [:create,:destroy]
  
  
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
  redirect_to request.referer
  end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
      respond_to do |format|
      format.html {redirect_to @user}
      format.js
    redirect_to request.referer
  end
  end
  
  private
  
   def currentuser
  	unless params[:id].to_i != current_user.id
  		redirect_to user_path(current_user)
  	end
   end
end
