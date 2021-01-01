class UserController < ApplicationController
    def delete_image
        if !current_user
            redirect_to root_path, notice: "You need to sign in or sign up before doing anything in this app"
        else
            # find the image  in the bucket 
            @user = User.find(params[:id])
            image = ActiveStorage::Attachment.find(params[:image_id])
            # check if image 
            
            if @user == image.record || current_user.admin == true
                if (params[:image_id] == @user.avatar_id)
                    @user.avatar_id = nil
                    @user.save
                end
                image.purge
                redirect_to user_path(@user), notice: "You successfully delete the image!"
            end
        end
    end

    def upload_image
        @user = User.find(params[:id])
        index = @user.images.count 
        if params[:images].present?
            @user.images.attach(params[:images])
            @user.save
            redirect_to user_path(@user)
        else
            redirect_to user_path(@user), notice:"missing one argument"
        end
    end
    # set this to be the avatar 
    def set_main_image
        @user = User.find(params[:id])
        @user.avatar_id = params[:image_id]
        @user.save!
        redirect_to user_path(@user), notice: "You successfully se the main profile as your avatar!"
    end
    
    private
    def user_params
        params.require(:user).permit(:images)
    end
end
