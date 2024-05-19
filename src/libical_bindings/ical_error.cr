@[Link("ical")]
lib LibIcal
  enum IcalError
    # No error happened.
    ICAL_NO_ERROR = 0

    # A bad argument was passed to a function.
    ICAL_BADARG_ERROR

    # An error occurred while creating a new object with a `*_new()` routine.
    ICAL_NEWFAILED_ERROR

    # An error occurred while allocating some memory.
    ICAL_ALLOCATION_ERROR

    # Malformed data was passed to a function.
    ICAL_MALFORMEDDATA_ERROR

    # An error occurred while parsing part of an iCal component.
    ICAL_PARSE_ERROR

    # An internal error happened in library code.
    ICAL_INTERNAL_ERROR # Like assert --internal consist. prob

    # An error happened while working with a file.
    ICAL_FILE_ERROR

    # Failure to properly sequence calls to a set of interfaces.
    ICAL_USAGE_ERROR

    # An unimplemented function was called.
    ICAL_UNIMPLEMENTED_ERROR

    # An unknown error occurred.
    ICAL_UNKNOWN_ERROR # Used for problems in input to icalerror_strerror()
  end
end
