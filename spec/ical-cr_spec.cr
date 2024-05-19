require "./spec_helper"
require "../src/libical_bindings/ical_property"

describe IcalCr do
  describe "Apple Calendar" do
    it "parses correctly" do
      ical_component = IcalCr::IcalParser.new.parse_file("spec/fixtures/apple-calendar.ics")
      ical_component.error_count.should eq(0)

      ical_component.kind.should eq(LibIcal::IcalComponentKind::ICAL_VCALENDAR_COMPONENT)

      ical_component.duration.hours.should eq(1)

      ical_component.properties.size.should eq(5)
      property_0 = ical_component.properties[0]
      property_0.kind.should eq(LibIcal::IcalPropertyKind::ICAL_CARID_PROPERTY)
      property_0.parameters.size.should eq(0)
      p property_0
      p property_0.to_s

      property_1 = ical_component.properties[1]
      property_1.parameters.size.should eq(0)
      p property_1
      p property_1.to_s

      property_2 = ical_component.properties[2]
      property_2.parameters.size.should eq(0)
      p property_2
      p property_2.to_s

      property_3 = ical_component.properties[3]
      property_3.parameters.size.should eq(0)
      p property_3
      p property_3.to_s

      property_4 = ical_component.properties[4]
      property_4.parameters.size.should eq(0)
      p property_4
      p property_4.to_s
    end
  end
end
