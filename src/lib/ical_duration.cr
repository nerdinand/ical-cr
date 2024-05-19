require "../libical_bindings/ical_duration"

module IcalCr
  class IcalDuration
    @duration : LibIcal::IcalDurationType
    
    delegate days, hours, is_neg, minutes, seconds, weeks, to: @duration

    def initialize(@duration)
    end
  end
end
