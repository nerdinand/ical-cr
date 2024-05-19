@[Link("ical")]
lib LibIcal
  struct IcalDurationType
    is_neg : LibC::Int
    days : LibC::UInt
    weeks : LibC::UInt
    hours : LibC::UInt
    minutes : LibC::UInt
    seconds : LibC::UInt
  end
end
