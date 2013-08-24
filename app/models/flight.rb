class Flight < ActiveRecord::Base
  belongs_to  :depart_airport, class_name: 'Airport'
  belongs_to  :arrive_airport, class_name: 'Airport'

  def travel_time
    if any_time_undefined?
      'undefined'
    else
      Time.at(arrive_time - depart_time).getgm.to_s(:time)
    end
  end

  private
  def any_time_undefined?
    time_undefined?(depart_time) || time_undefined?(arrive_time)
  end

  def time_undefined?(time)
    time.hour == 0 && time.min == 0
  end
end
