require "./ical_component"

module IcalCr
  class IcalParser
    def initialize
      @parser = LibIcal.new_parser
    end

    def parse_io(io : IO)
      LibIcal.set_gen_data(@parser, pointerof(io))
        
      content_line : LibC::Char*? = nil

      line_number = 1
      loop do
        content_line = LibIcal.get_line(@parser, -> (str : LibC::Char*, size : LibC::SizeT, data : Void*) : LibC::Char* do
          line = data.as(IO*).value.gets(size)
          
          if line.nil?
            Pointer(LibC::Char).null
          else
            Intrinsics.memcpy(str, line.bytes, line.bytesize + 1, false) # copy bytesize + 1 bytes because we need to include the null terminator
            str
          end
        end)

        c = LibIcal.add_line(@parser, content_line)

        if LibIcal.get_state(@parser) == LibIcal::IcalParserState::ICALPARSER_ERROR
          raise "Failed parsing line #{line_number}: #{String.new(content_line)}"
        end

        # unless c.null?
        #   puts String.new(LibIcal.as_ical_string(c))
        # end

        error_number = LibIcal.error_number().value
        if error_number != LibIcal::IcalError::ICAL_NO_ERROR
          raise String.new(LibIcal.error_message(error_number))
        end
        
        unless c.null?
          return IcalComponent.new(c.value)
        end

        line_number += 1
      end
    end

    def parse_string(source : String)
      parse_io(IO::Memory.new(source))
    end

    def parse_file(path : String)
      parse_io(File.open(path))
    end

    def finalize
      LibIcal.free_parser(@parser)
    end
  end
end