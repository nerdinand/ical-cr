require "./libical_bindings"
require "./lib/pvl_list"
require "./lib/ical_parser"

# TODO: Write documentation for `Ical::Cr`
module IcalCr
  VERSION = "0.1.0"

  def IcalCr.to_string(array : StaticArray(UInt8, 5))
    String.new(array.to_slice).rstrip('\0')
  end

  class IcalSubcomponents < PVLList
    def [](index)
      super.as(LibIcal::IcalComponent*).value
    end
  end

  class IcalProperties < PVLList
    def [](index)
      IcalProperty.new(super.as(LibIcal::IcalProperty*).value)
    end
  end

  class IcalParameters < PVLList
    def [](index)
      IcalProperty.new(super.as(LibIcal::IcalProperty*).value)
    end
  end

  class IvalValue
    @value : LibIcal::IcalValue

    def initialize(@value)
    end

    def id
      IcalCr.to_string(@value.id)
    end
  end
  
  class IcalProperty
    @property : LibIcal::IcalProperty

    def initialize(@property)
    end

    def kind
      @property.kind
    end

    def id
      IcalCr.to_string(@property.id)
    end

    def parameters
      IcalParameters.new(@property.parameters)
    end

    def value
      IvalValue.new(@property.value.value)
    end

    def name
      @property.x_name.null? ? nil : String.new(@property.x_name)
    end

    def to_s
      [id, name].compact.join(" ")
    end
  end
end
