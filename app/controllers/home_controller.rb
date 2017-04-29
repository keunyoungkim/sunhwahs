class HomeController < ApplicationController
  def index
    
    @post = Post.order("created_at DESC").limit(1)
    @user = User.all
  end

  def create
  @user = User.find_or_create_from_auth_hash(auth_hash)
  session[:user_id] = @user.id
  redirect_to '/'
  end
  
def destroy
  if current_user
    session.delete(:user_id)
    flash[:success] = '잘가요!'
  end
  redirect_to '/'
end

  def owner_notice
    
  end
  def school_info
    
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
 end

end
