require "./ical_enums"

@[Link("ical")]
lib LibIcal
  ICAL_GEO_LEN = 16

  struct IcalGeoType
    lat : LibC::Char[ICAL_GEO_LEN]
    lon : LibC::Char[ICAL_GEO_LEN]
  end

  struct IcalReqStatType
    code : IcalRequestStatus
    desc : LibC::Char*
    debug : LibC::Char*
  end
end
