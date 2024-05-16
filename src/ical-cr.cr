require "./libical_bindings"

# TODO: Write documentation for `Ical::Cr`
module IcalCr
  VERSION = "0.1.0"

  class IcalSubcomponents
    @pvl_list : LibIcal::PvlList
    
    def initialize(@pvl_list)
    end
  
    def size
      @pvl_list.count
    end
  end
  
  class ComponentIterator
    @pvl_elem : LibIcal::PvlElem
  
    def initialize(@pvl_elem)
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
  
    def subcomponents
      IcalSubcomponents.new(@component.components)
    end
  
    def component_iterator
      ComponentIterator.new(@component.component_iterator)
    end
  
    def error_count
      LibIcal.count_errors(pointerof(@component))
    end
  
    def duration
      LibIcal.get_duration(pointerof(@component))
    end
  
    def first_child
      # @component.property_iterator.next.value.d.as(IcalComponent*)
      @component.components.head.value
      # .as(IcalComponent*)
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
  
    def parse_file(path : String)
      File.open(path) do |file|
        LibIcal.set_gen_data(@parser, pointerof(file))
        
        content_line : LibC::Char*? = nil
  
        loop do
          content_line = LibIcal.get_line(@parser, -> (str : LibC::Char*, size : LibC::SizeT, data : Void*) : LibC::Char* do
            line = data.as(File*).value.gets(size)
            # p line
            if line.nil?
              Pointer(LibC::Char).null
            else
              Intrinsics.memcpy(str, line.bytes, line.bytesize, false)
              str
            end
          end)
  
          c = LibIcal.add_line(@parser, content_line)
          # p LibIcal.get_state(@parser)
          error_number = LibIcal.error_number().value
          if error_number != LibIcal::IcalError::ICAL_NO_ERROR
            raise String.new(LibIcal.error_message(error_number))
          end
          
          unless c.null?
            return IcalComponent.new(c)
          end
        end
      end
    end
  
    def finalize
      LibIcal.free_parser(@parser)
    end
  end  
end
