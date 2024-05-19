require "./libical_bindings/ical_parser"
require "./libical_bindings/ical_error"
require "./libical_bindings/ical_duration"

@[Link("ical")]
lib LibIcal
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
