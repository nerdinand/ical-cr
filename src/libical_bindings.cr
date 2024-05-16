@[Link("ical")]
lib LibIcal
  TMP_BUF_SIZE = 80

  struct IcalArray
    element_size : LibC::SizeT
    increment_size : LibC::SizeT
    num_elements : LibC::SizeT
    space_allocated : LibC::SizeT
    chunks : Void**
  end

  enum IcalComponentKind
    ICAL_NO_COMPONENT
    ICAL_ANY_COMPONENT # Used to select all components
    ICAL_XROOT_COMPONENT
    ICAL_XATTACH_COMPONENT # MIME attached data, returned by parser.
    ICAL_VEVENT_COMPONENT
    ICAL_VTODO_COMPONENT
    ICAL_VJOURNAL_COMPONENT
    ICAL_VCALENDAR_COMPONENT
    ICAL_VAGENDA_COMPONENT
    ICAL_VFREEBUSY_COMPONENT
    ICAL_VALARM_COMPONENT
    ICAL_XAUDIOALARM_COMPONENT
    ICAL_XDISPLAYALARM_COMPONENT
    ICAL_XEMAILALARM_COMPONENT
    ICAL_XPROCEDUREALARM_COMPONENT
    ICAL_VTIMEZONE_COMPONENT
    ICAL_XSTANDARD_COMPONENT
    ICAL_XDAYLIGHT_COMPONENT
    ICAL_X_COMPONENT
    ICAL_VSCHEDULE_COMPONENT
    ICAL_VQUERY_COMPONENT
    ICAL_VREPLY_COMPONENT
    ICAL_VCAR_COMPONENT
    ICAL_VCOMMAND_COMPONENT
    ICAL_XLICINVALID_COMPONENT
    ICAL_XLICMIMEPART_COMPONENT # A non-stardard component that mirrors structure of MIME data
    ICAL_VAVAILABILITY_COMPONENT
    ICAL_XAVAILABLE_COMPONENT
    ICAL_VPOLL_COMPONENT
    ICAL_VVOTER_COMPONENT
    ICAL_XVOTE_COMPONENT
    ICAL_VPATCH_COMPONENT
    ICAL_XPATCH_COMPONENT
    ICAL_PARTICIPANT_COMPONENT
    ICAL_VLOCATION_COMPONENT
    ICAL_VRESOURCE_COMPONENT
    ICAL_NUM_COMPONENT_TYPES # MUST be last (unless we can put NO_COMP last)
  end

  struct IcalComponent
    id : LibC::Char[5]
    kind : IcalComponentKind
    x_name : LibC::Char*
    properties : PvlList
    property_iterator : PvlElem
    components : PvlList
    component_iterator : PvlElem
    parent : IcalComponent*

    # An array of icaltimezone structs. We use this so we can do fast
    #  lookup of timezones using binary searches. timezones_sorted is
    #  set to 0 whenever we add a timezone, so we remember to sort the
    #  array before doing a binary search.
    timezones : IcalArray*
    timezones_sorted : LibC::Int
  end

  enum IcalParserState
    # An error occurred while parsing.
    ICALPARSER_ERROR

    # Parsing was successful.
    ICALPARSER_SUCCESS

    # Currently parsing the begin of a component.
    ICALPARSER_BEGIN_COMP

    # Currently parsing the end of the component.
    ICALPARSER_END_COMP

    # Parsing is currently in progress.
    ICALPARSER_IN_PROGRESS
  end

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

  struct PvlElem
    # MAGIC : LibC::Int               # < Magic Identifier
    magic : LibC::Int               # < Magic Identifier
    d : Void*         # < Pointer to data user is storing
    next : PvlElem**            # < Next element
    prior : PvlElem**           # < Prior element
  end

  struct PvlList
    # MAGIC : LibC::Int                      # < Magic Identifier
    magic : LibC::Int                      # < Magic Identifier
    head : PvlElem**            # < Head of list
    tail : PvlElem**            # < Tail of list
    count : LibC::Int                      # < Number of items in the list
    p : PvlElem**               # < Pointer used for iterators
  end

  struct IcalParser
    buffer_full : LibC::Int # flag indicates that temp is smaller that data being read into it
    continuation_line : LibC::Int # last line read was a continuation line
    tmp_buf_size : LibC::SizeT
    temp : LibC::Char[TMP_BUF_SIZE]
    root_component : IcalComponent*
    version : LibC::Int
    level : LibC::Int
    lineno : LibC::Int
    error_count : LibC::Int
    state : IcalParserState
    components : PvlList

    line_gen_data : Void*
  end

  struct IcalDurationType
    is_neg : LibC::Int
    days : LibC::UInt
    weeks : LibC::UInt
    hours : LibC::UInt
    minutes : LibC::UInt
    seconds : LibC::UInt
  end

  fun new_parser = icalparser_new() : IcalParser*
  fun set_gen_data = icalparser_set_gen_data(parser : IcalParser*, data : Void*)

  alias ParserLineGenFunc = Proc(LibC::Char*, LibC::SizeT, Void*, LibC::Char*)

  fun get_line = icalparser_get_line(parser : IcalParser*,
                                    line_gen_func : ParserLineGenFunc) : LibC::Char*

  fun add_line = icalparser_add_line(parser : IcalParser*, line : LibC::Char*) : IcalComponent*

  fun free_component = icalcomponent_free(IcalComponent*)
  fun free_parser = icalparser_free(IcalParser*)

  fun get_state = icalparser_get_state(parser : IcalParser*): IcalParserState

  fun error_number = icalerrno_return(): IcalError*
  fun error_message = icalerror_strerror(error : IcalError) : LibC::Char*

  fun count_errors = icalcomponent_count_errors(component : IcalComponent*) : LibC::Int
  fun get_duration = icalcomponent_get_duration(component : IcalComponent*) : IcalDurationType
end
