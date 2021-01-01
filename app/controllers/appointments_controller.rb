class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :unbook]
  before_action :admin_user, :only => [:new, :create, :edit, :set_finish, :set_un_finish, :destroy]
  before_action :unbook_time_constra, :only => [:unbook, :book]
  before_action :user_validate_vote, only: [:book] 
  before_action :user_sign_in, only: [:book, :unbook, :index, :show, :update]
  # GET /appointments
  # GET /appointments.json

  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.active_appt = ActiveAppt.first
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to home_admin_view_path, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to home_admin_view_path, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
  
    if @appointment.booked
      # release the user to free 
      @user = @appointment.user
      @user.booked = false
      @user.save
    end
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to home_admin_view_path, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def book
    
    if current_user 
      current_user.booked = true
      @a.user = current_user
      @a.booked = true
      @a.questions = params[:questions]
      @a.save
      current_user.save
      #send email to user 
      ApptMailer.with(appt: @a).new_appt_email.deliver_now  # send email to adin and let him know there is a person that book the appt 
      # ApptMailer.with(user: current_user, appt: @a).appt_user_remind.deliver_now # send email to user to remind them that they have an appointment 
    end
    redirect_to(root_path)
  end

  # post or put 
  def unbook
    if current_user
      # @a.user.booked = false
      if @a.booked
        @user = @a.user
        @user.booked = false
        @a.booked = false
        @a.user = false
        @a.save
        @user.save
        ApptMailer.with(user: current_user, appt: @a).somebody_unbook_admin.deliver_now # send email to user to remind them that they have an appointment 
        # ApptMailer.with(user: current_user, appt: @a).somebody_unbook_user.deliver_now # send email to user to remind them that they have an appointment 
        # ApptMailer.with(appt: @a).new_appt_email.deliver_now 
        
      end
    end
    redirect_back fallback_location: root_path
  end 

  def set_finish # set the appoint to status finish and release the user if it is booked 
    @a = Appointment.find(params[:id])
    @a.finsihed = true 
    if @a.booked # if the appointment has been booked by someone 
      @user = @a.user
      @user.booked = false
      @user.save
    end
    @a.save
  redirect_back fallback_location: home_admin_view_path
  end

  def set_un_finish # un - finish  if it is booked then set the user to busy again 
    @a = Appointment.find(params[:id])
    @a.finsihed = false 
    if @a.booked        
      @user = @a.user
      @user.booked = true
      @user.save
    end
    @a.save
    redirect_back fallback_location: home_admin_view_path
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end
    def admin_user
      redirect_to(root_path) unless current_user && current_user.admin?
    end
    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:user_id, :time, :questions, :date, :starttime, :unbook_time)
    end

    def unbook_time_constra
      @a = Appointment.find(params[:id])
      if current_user #&& !current_user.admin
        @current_time = Time.now
        @start_time = @a.starttime
        @diff  = @start_time  - @current_time
        if (@a.unbook_time)
          unbook_time = (@a.unbook_time + 1) * 60 * 60 # transform to seconds 
        else
          unbook_time  = 0  
      end

        if @diff < unbook_time
          flash[:notice] = 'Time Constraint: Sorry, cannot book or unbook the appointment when it is toooo late! You got to book it beffore 12 hours of the appointment start_time'
          redirect_to root_path 
        else
          flash[:notice] = 'Thank you for booking a appointment with me. You only can book another appointment unless you unbook or finish the appointment you just booked'
        end
      end
    end

    def user_validate_vote
      if current_user && current_user.booked
      flash[:notice] = 'CANNOT book this appointemnt because you are currently having another one. Once finishing your appointment, you can book another appointment'
      redirect_to root_path
      end
    end
    def user_sign_in
      if !current_user
        flash[:notice] = 'You do not sign in yet. Please sign in'
        redirect_to user_session_path
      end
    end

end
