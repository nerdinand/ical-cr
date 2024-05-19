require "./pvl"
require "./ical_enums"
require "./ical_array"

@[Link("ical")]
lib LibIcal  
  struct IcalComponent
    id : LibC::Char[5]
    kind : IcalComponentKind
    x_name : LibC::Char*
    properties : PVLList
    property_iterator : PVLElem
    components : PVLList
    component_iterator : PVLElem
    parent : IcalComponent*

    # An array of icaltimezone structs. We use this so we can do fast
    #  lookup of timezones using binary searches. timezones_sorted is
    #  set to 0 whenever we add a timezone, so we remember to sort the
    #  array before doing a binary search.
    timezones : IcalArray*
    timezones_sorted : LibC::Int
  end
end
