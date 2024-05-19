@[Link("ical")]
lib LibIcal
  struct PVLElemT
    # MAGIC : LibC::Int               # < Magic Identifier
    magic : LibC::Int               # < Magic Identifier
    d : Void*         # < Pointer to data user is storing
    next : PVLElemT*            # < Next element
    prior : PVLElemT*           # < Prior element
  end

  struct PVLListT
    # MAGIC : LibC::Int                      # < Magic Identifier
    magic : LibC::Int                      # < Magic Identifier
    head : PVLElemT*            # < Head of list
    tail : PVLElemT*            # < Tail of list
    count : LibC::Int                      # < Number of items in the list
    p : PVLElemT*               # < Pointer used for iterators
  end

  alias PVLElem = Pointer(PVLElemT)
  alias PVLList = Pointer(PVLListT)
end
