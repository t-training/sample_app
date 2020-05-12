module Api
  module V1
    class UsersController < ApplicationController
      def get_microposts
        @user = User.find params[:id]
        @microposts = @user.microposts
        gravatar_id = Digest::MD5::hexdigest(@user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=80"
        render json: {user_name: @user.name, icon_url: gravatar_url, microposts: @microposts}.to_json
#        render json: {microposts: @microposts}.to_json        
      end
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end