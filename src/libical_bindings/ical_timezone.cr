require "./ical_component"
require "./ical_array"
require "./ical_timezone"

@[Link("ical")]
lib LibIcal
  struct IcalTimezone
    tzid : LibC::Char*
    # /**< The unique ID of this timezone,
    #   e.g. "/citadel.org/Olson_20010601_1/Africa/Banjul".
    #   This should only be used to identify a VTIMEZONE. It is not
    #   meant to be displayed to the user in any form. */

    location : LibC::Char*
    # /**< The location for the timezone, e.g. "Africa/Accra" for the
    #   Olson database. We look for this in the "LOCATION" or
    #   "X-LIC-LOCATION" properties of the VTIMEZONE component. It
    #   isn't a standard property yet. This will be NULL if no location
    #   is found in the VTIMEZONE. */

    tznames : LibC::Char*
    # /**< This will be set to a combination of the TZNAME properties
    #   from the last STANDARD and DAYLIGHT components in the
    #   VTIMEZONE, e.g. "EST/EDT".  If they both use the same TZNAME,
    #   or only one type of component is found, then only one TZNAME
    #   will appear, e.g. "AZOT". If no TZNAME is found this will be
    #   NULL. */

    latitude : LibC::Double
    longitude : LibC::Double
    # /**< The coordinates of the city, in degrees. */

    component : IcalComponent*
    # /**< The toplevel VTIMEZONE component loaded from the .ics file for this
    #     timezone. If we need to regenerate the changes data we need this. */

    builtin_timezone : IcalTimezone*
    # /**< If this is not NULL it points to the builtin icaltimezone
    #   that the above TZID refers to. This icaltimezone should be used
    #   instead when accessing the timezone changes data, so that the
    #   expanded timezone changes data is shared between calendar
    #   components. */

    end_year : LibC::Int
    # /**< This is the last year for which we have expanded the data to.
    #   If we need to calculate a date past this we need to expand the
    #   timezone component data from scratch. */

    changes : IcalArray*
    # /**< A dynamically-allocated array of time zone changes, sorted by the
    #   time of the change in local time. So we can do fast binary-searches
    #   to convert from local time to UTC. */
  end
end
