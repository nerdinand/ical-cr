require "./ical_duration"

module IcalCr
  class IcalComponent
    @component : LibIcal::IcalComponent

    def initialize(@component)
    end

    def kind
      LibIcal::IcalComponentKind.new(@component.kind.value)
    end

    def name
      return nil if @component.x_name.null?
      String.new(@component.x_name)
    end

    def id
      IcalCr.to_string(@component.id)
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
      IcalDuration.new(LibIcal.get_duration(pointerof(@component)))
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
end
