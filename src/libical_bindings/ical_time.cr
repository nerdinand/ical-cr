require "./ical_timezone"

@[Link("ical")]
lib LibIcal
  struct IcalTimeType
    year : LibC::Int #           /**< Actual year, e.g. 2001. */
    month : LibC::Int #          /**< 1 (Jan) to 12 (Dec). */
    day : LibC::Int
    hour : LibC::Int
    minute : LibC::Int
    second : LibC::Int

    is_date : LibC::Int #        /**< 1 -> interpret this as date. */

    is_daylight : LibC::Int #    /**< 1 -> time is in daylight savings time. */

    zone : IcalTimezone* # /**< timezone */
  end
end
