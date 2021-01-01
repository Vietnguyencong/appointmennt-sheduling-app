class HomeController < ApplicationController
    before_action :admin_user, only: [:admin_view, :show_users]
    before_action :check_time, only: [:index, :admin_view]
    before_action :user_sign_in, only: [:upload_image, :user]
    def index
        if current_user
            @user_appts =  current_user.appointments
        end
    end
    def admin_view
        @appts = Appointment.all
        @booked_appts = ActiveAppt.first.appointments.where(booked: true)
    end

  
    def show_users
        @users = User.all
    end
    # get home/user/id
    def user
        @user = User.find(params[:id])
        @user_appts =  @user.appointments
    end

    private
    def admin_user
        redirect_to(root_path) unless current_user && current_user.admin?
    end
    def check_time
        @appointments = Appointment.all
        active_appts = ActiveAppt.first.appointments.all
        @avai_appts = []
        active_appts.each do |a|
            time = Time.now
            if (time -  a.starttime > 0)
                # put it to old appts and remove it from the active appts 
                a.finsihed = true
                a.active_appt = false
                if a.user
                    user = a.user 
                    user.booked = false
                    user.save
                end
                a.old_appts_id = OldAppt.first.id
            else
                if (a.unbook_time)
                    unbook_time = (a.unbook_time + 1) * 60 * 60 # transform to seconds 
                else
                    unbook_time = 0
                end
                if (a.starttime - time) > unbook_time
                    @avai_appts.append(a)
                end
            end
            a.save!
        end
    end
    def user_sign_in
        if !current_user
          flash[:notice] = 'You do not sign in yet. Please sign in or sign up'
          redirect_to user_session_path
        end
      end
end
