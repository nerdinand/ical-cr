require "./spec_helper"

describe IcalCr do
  # TODO: Write tests

  it "works" do
    ical_component = IcalCr::IcalParser.new.parse_file("spec/fixtures/1-1.ics")
    ical_component.kind.should eq(LibIcal::IcalComponentKind::ICAL_VCALENDAR_COMPONENT)

    ical_component.subcomponents.size.should eq(0)
    ical_component.name.should eq("")
  end
end
