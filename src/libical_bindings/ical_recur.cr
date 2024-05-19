require "./ical_time"

@[Link("ical")]
lib LibIcal
  ICAL_BY_SECOND_SIZE = 62                             # 0 to 60 */
  ICAL_BY_MINUTE_SIZE = 61                             # 0 to 59 */
  ICAL_BY_HOUR_SIZE = 25                               # 0 to 23 */
  ICAL_BY_MONTH_SIZE = 14                              # 1 to 13 */
  ICAL_BY_MONTHDAY_SIZE = 32                           # 1 to 31 */
  ICAL_BY_WEEKNO_SIZE = 56                             # 1 to 55 */
  ICAL_BY_YEARDAY_SIZE = 386                           # 1 to 385 */
  ICAL_BY_SETPOS_SIZE = ICAL_BY_YEARDAY_SIZE           # 1 to N */
  ICAL_BY_DAY_SIZE = 7 * (ICAL_BY_WEEKNO_SIZE - 1) + 1 # 1 to N */

  enum IcalRecurrenceTypeFrequency
    # These enums are used to index an array, so don't change the
    #   order or the integers */

    ICAL_SECONDLY_RECURRENCE = 0
    ICAL_MINUTELY_RECURRENCE = 1
    ICAL_HOURLY_RECURRENCE = 2
    ICAL_DAILY_RECURRENCE = 3
    ICAL_WEEKLY_RECURRENCE = 4
    ICAL_MONTHLY_RECURRENCE = 5
    ICAL_YEARLY_RECURRENCE = 6
    ICAL_NO_RECURRENCE = 7
  end

  enum IcalRecurrenceTypeWeekday
    ICAL_NO_WEEKDAY
    ICAL_SUNDAY_WEEKDAY
    ICAL_MONDAY_WEEKDAY
    ICAL_TUESDAY_WEEKDAY
    ICAL_WEDNESDAY_WEEKDAY
    ICAL_THURSDAY_WEEKDAY
    ICAL_FRIDAY_WEEKDAY
    ICAL_SATURDAY_WEEKDAY
  end

  enum IcalRecurrenceTypeSkip
    ICAL_SKIP_BACKWARD = 0
    ICAL_SKIP_FORWARD
    ICAL_SKIP_OMIT
    ICAL_SKIP_UNDEFINED
  end

  struct IcalRecurrenceType
    freq : IcalRecurrenceTypeFrequency

    # /* until and count are mutually exclusive. */
    until : IcalTimeType
    count : LibC::Int

    interval : LibC::Short

    week_start : IcalRecurrenceTypeWeekday
    
    # /* The BY* parameters can each take a list of values. Here I
    #  * assume that the list of values will not be larger than the
    #  * range of the value -- that is, the client will not name a
    #  * value more than once.

    #  * Each of the lists is terminated with the value
    #  * ICAL_RECURRENCE_ARRAY_MAX unless the list is full.
    #  */

    by_second : LibC::Short[ICAL_BY_SECOND_SIZE]
    by_minute : LibC::Short[ICAL_BY_MINUTE_SIZE]
    by_hour : LibC::Short[ICAL_BY_HOUR_SIZE]
    by_day : LibC::Short[ICAL_BY_DAY_SIZE]
        #/**< @brief Encoded value
        # *
        # * The 'day' element of the by_day array is encoded to allow
        # * representation of both the day of the week ( Monday, Tuesday), but
        # * also the Nth day of the week (first Tuesday of the month, last
        # * Thursday of the year).
        # *
        # * These values are decoded by icalrecurrencetype_day_day_of_week() and
        # * icalrecurrencetype_day_position().
        # */
    by_month_day : LibC::Short[ICAL_BY_MONTHDAY_SIZE]
    by_year_day : LibC::Short[ICAL_BY_YEARDAY_SIZE]
    by_week_no : LibC::Short[ICAL_BY_WEEKNO_SIZE]
    by_month : LibC::Short[ICAL_BY_MONTH_SIZE]
        # /**< @brief Encoded value
        # *
        # * The 'month' element of the by_month array is encoded to allow
        # * representation of the "L" leap suffix (RFC 7529).
        # *
        # * These values are decoded by icalrecurrencetype_month_is_leap()
        # * and icalrecurrencetype_month_month().
        # */
    by_set_pos : LibC::Short[ICAL_BY_SETPOS_SIZE]

    # /* For RSCALE extension (RFC 7529) */
    rscale : LibC::Char*
    skip : IcalRecurrenceTypeSkip
  end
end
