require "./spec_helper"
require "../src/libical_bindings/ical_property"

EVENT_SOURCE = "BEGIN:VCALENDAR
PRODID:\"-//RDU Software//NONSGML HandCal//EN\"
VERSION:2.0
BEGIN:VTIMEZONE
TZID:US-Eastern
BEGIN:STANDARD
DTSTART:19990404T020000
RDATE:19990u404xT020000
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
END:STANDARD
BEGIN:DAYLIGHT
DTSTART:19990404T020000
RDATE:19990404T020000
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
TZNAME:EDT
Dkjhgri:derhvnv;
BEGIN:dfkjh
END:dfdfkjh
END:DAYLIGHT
END:VTIMEZONE
BEGIN:VEVENT
GEO:Bongo
DTSTAMP:19980309T231000Z
UID:guid-1.host1.com
ORGANIZER;ROLE=CHAIR:MAILTO:mrbig@host.com
ATTENDEE;RSVP=TRUE;ROLE=REQ-PARTICIPANT;CUTYPE=GROUP
 :MAILTO:employee-A@host.com
DESCRIPTION:Project XYZ Review Meeting
CATEGORIES:MEETING
CLASS:PUBLIC
CREATED:19980309T130000Z
SUMMARY:XYZ Project Review
DTSTART;TZID=US-Eastern:19980312T083000
DTEND;TZID=US-Eastern:19980312T093000
LOCATION:1CP Conference Room 4350
END:VEVENT
END:VCALENDAR
"

describe IcalCr do

  it "works" do
    # ical_component = IcalCr::IcalParser.new.parse_file("spec/fixtures/1-1.ics")
    ical_component = IcalCr::IcalParser.new.parse_string(EVENT_SOURCE)
    ical_component.kind.should eq(LibIcal::IcalComponentKind::ICAL_VCALENDAR_COMPONENT)

    ical_component.properties.size.should eq(2)
    p ical_component.properties[0]

    ical_component.subcomponents.size.should eq(2)
    p ical_component.subcomponents[0]
  end
end
