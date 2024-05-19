@[Link("ical")]
lib LibIcal
  struct IcalArray
    element_size : LibC::SizeT
    increment_size : LibC::SizeT
    num_elements : LibC::SizeT
    space_allocated : LibC::SizeT
    chunks : Void**
  end
end