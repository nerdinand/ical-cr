module IcalCr
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
end
