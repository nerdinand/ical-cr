require "./libical_bindings"

# TODO: Write documentation for `Ical::Cr`
module IcalCr
  VERSION = "0.1.0"

  class PVLList
    @pvl_list : LibIcal::PVLList
    
    def initialize(@pvl_list)
    end

    def size
      @pvl_list.value.count
    end

    def [](index)
      current = @pvl_list.value.head

      index.times do 
        current = current.value.next
      end

      return current.value.d
    end
  end

  class IcalSubcomponents < PVLList
    def [](index)
      super.as(LibIcal::IcalComponent*).value
    end
  end

  class IcalProperties < PVLList
    def [](index)
      super.as(LibIcal::IcalProperty*).value
    end
  end
  
  class IcalComponent
    @component : LibIcal::IcalComponent
  
    def initialize(component)
      @component = component.value
    end
  
    def kind
      LibIcal::IcalComponentKind.new(@component.kind.value)
    end
  
    def name
      return nil if @component.x_name.null?
      String.new(@component.x_name)
    end
  
    def properties
      IcalProperties.new(@component.properties)
    end

    def subcomponents
      IcalSubcomponents.new(@component.components)
    end
  
    def error_count
      LibIcal.count_errors(pointerof(@component))
    end
  
    def duration
      LibIcal.get_duration(pointerof(@component))
    end
  
    def first_child
      @component.components.head.value
    end
  
    def finalize
      LibIcal.free_component(pointerof(@component))
    end
  
    def components
      @component.components
    end
  end
  
  class IcalParser
    def initialize
      @parser = LibIcal.new_parser
    end

    def parse_io(io : IO)
      LibIcal.set_gen_data(@parser, pointerof(io))
        
      content_line : LibC::Char*? = nil

      loop do
        content_line = LibIcal.get_line(@parser, -> (str : LibC::Char*, size : LibC::SizeT, data : Void*) : LibC::Char* do
          line = data.as(IO*).value.gets(size)
          # p line
          if line.nil?
            Pointer(LibC::Char).null
          else
            Intrinsics.memcpy(str, line.bytes, line.bytesize, false)
            str
          end
        end)

        c = LibIcal.add_line(@parser, content_line)
        p LibIcal.get_state(@parser)
        error_number = LibIcal.error_number().value
        if error_number != LibIcal::IcalError::ICAL_NO_ERROR
          raise String.new(LibIcal.error_message(error_number))
        end
        
        unless c.null?
          return IcalComponent.new(c)
        end
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
