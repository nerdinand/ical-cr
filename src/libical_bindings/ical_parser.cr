require "./pvl"
require "./ical_component"

@[Link("ical")]
lib LibIcal
  TMP_BUF_SIZE = 80

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
    components : PVLList

    line_gen_data : Void*
  end
end
