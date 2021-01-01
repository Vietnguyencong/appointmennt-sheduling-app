class Appointment < ApplicationRecord
    belongs_to :user, optional:true
    belongs_to :old_appt, optional:true
    belongs_to :active_appt, optional:true

    def get_date
        return self.starttime.strftime("%m/%d")
    end
    def get_time
        return self.starttime.strftime("%I:%M %p")
    end

end
