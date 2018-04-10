class UsersController < ApplicationController
  def create
    User.create(user_params)
  end
  def destroy
    user = User.find(params[:id])
    user.destroy
  end
  def update
    user = User.find(params[:id])
    user.update(user_params)
  end
  def show
    user = User.find(params[:id])
    render :json => user
  end
  def best_users
    users = UserTicket.limit(10).group(:user_id).order('count_user_id desc').count('user_id')
    all_users = []
    users.each do |user|
      the_user = User.find(user[0])
      dict = {"Name": the_user.name + " " + the_user.last_name, "Tickets": user[1]}
      all_users.append(dict)
    end
    render :json => all_users
  end

  def user_params
    params.require(:users).permit(:name, :last_name, :email, :phone, :password, :address, :active)
  end
end
