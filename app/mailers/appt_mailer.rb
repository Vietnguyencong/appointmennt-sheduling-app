class ApptMailer < ApplicationMailer
    def new_appt_email
        @appt = params[:appt]
        @user = @appt.user
        mail to: "vietdbm@gmail.com", subject:"BOOKING"
    end
    def appt_user_remind
        @user = params[:user]
        @appt = params[:appt]
        mail to: @user.email, subject:"You have a appointment with Viet"
    end
    def somebody_unbook_admin
        @user = params[:user]
        @appt = params[:appt]
        mail to: "vietdbm@gmail.com", subject:"UN__BOOKING"
    end
    def somebody_unbook_user
        @user = params[:user]
        @appt = params[:appt]
        mail to: @user.email, subject:"You successfully unbook an appointment"
    end
end
