require "./ical_duration"

@[Link("ical")]
lib LibIcal
  struct IcalPeriodType
    start : IcalTimeType
    end_ : IcalTimeType
    duration : IcalDurationType
  end
end
