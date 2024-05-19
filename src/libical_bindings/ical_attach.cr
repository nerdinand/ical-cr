@[Link("ical")]
lib LibIcal
  alias IcalAttachFreeFn = Proc(LibC::Char*, Void*, Void)

  struct IcalAttach
    refcount : LibC::Int

    u : UrlOrData
  end

  struct UrlOrDataUrl
    url : LibC::Char*
  end

  struct UrlOrDataData
    data : LibC::Char*
    free_fn : IcalAttachFreeFn
    free_vn_data : Void*
  end

  union UrlOrData
    url : UrlOrDataUrl
    data : UrlOrDataData
  end
end