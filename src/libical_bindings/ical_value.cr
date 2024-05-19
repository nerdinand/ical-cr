require "./ical_attach"
require "./ical_duration"
require "./ical_period"
require "./ical_types"
require "./ical_time"
require "./ical_recur"

@[Link("ical")]
lib LibIcal
  enum IcalValueKind
    ICAL_ANY_VALUE = 5000
    ICAL_BOOLEAN_VALUE = 5001
    ICAL_UTCOFFSET_VALUE = 5002
    ICAL_RECUR_VALUE = 5003
    ICAL_METHOD_VALUE = 5004
    ICAL_CALADDRESS_VALUE = 5005
    ICAL_PERIOD_VALUE = 5006
    ICAL_STATUS_VALUE = 5007
    ICAL_BINARY_VALUE = 5008
    ICAL_TEXT_VALUE = 5009
    ICAL_DATETIMEDATE_VALUE = 5010
    ICAL_DURATION_VALUE = 5011
    ICAL_DATETIMEPERIOD_VALUE = 5012
    ICAL_INTEGER_VALUE = 5013
    ICAL_TIME_VALUE = 5014
    ICAL_URI_VALUE = 5015
    ICAL_TRIGGER_VALUE = 5016
    ICAL_ATTACH_VALUE = 5017
    ICAL_CLASS_VALUE = 5018
    ICAL_FLOAT_VALUE = 5019
    ICAL_QUERY_VALUE = 5020
    ICAL_STRING_VALUE = 5021
    ICAL_TRANSP_VALUE = 5022
    ICAL_X_VALUE = 5023
    ICAL_DATETIME_VALUE = 5024
    ICAL_GEO_VALUE = 5025
    ICAL_DATE_VALUE = 5026
    ICAL_ACTION_VALUE = 5027
    ICAL_NO_VALUE = 5028
  end

  struct IcalValue
    kind : IcalValueKind
    id : LibC::Char[5]
    size : LibC::Int
    parent : IcalProperty*
    x_value : LibC::Char*
    data : Data
  end

  union Data
    v_attach : IcalAttach*
    #  void *v_binary; */ #  use v_attach */

    v_string : LibC::Char*
    # char *v_text; */       #  use v_string */
    # char *v_caladdress; */ #  use v_string */
    # char *v_query; */      #  use v_string */
    # char *v_uri; */        #  use v_string */

    v_float : LibC::Float

    v_int : LibC::Int
    # int v_boolean; */   #  use v_int */
    # int v_integer; */   #  use v_int */
    # int v_utcoffset; */ #  use v_int */

    v_duration : IcalDurationType

    v_period : IcalPeriodType
    # struct icalperiodtype v_datetimeperiod; */ #  use v_time/v_period */

    v_geo : IcalGeoType

    v_time : IcalTimeType
    # struct icaltimetype v_date; */         #  use v_time */
    # struct icaltimetype v_datetime; */     #  use v_time */
    # struct icaltimetype v_datetimedate; */ #  use v_time */


    v_requeststatus : IcalReqStatType

    #  struct icalrecurrencetype was once included
    # directly ( not referenced ) in this union, but it
    # contributes 2000 bytes to every value, so now it is
    # a reference */
    v_recur : IcalRecurrenceType

    # struct icaltriggertype v_trigger; */ #  use v_time/v_duration */

    v_enum : LibC::Int
    #  v_enum takes care of several enumerated types including:
    #   icalproperty_method v_method;
    #   icalproperty_status v_status;
    #   icalproperty_action v_action;
    #   icalproperty_class v_class;
    #   icalproperty_transp v_transp;
    #   icalproperty_busytype v_busytype;
    #   icalproperty_taskmode v_taskmode;
    #   icalproperty_pollmode v_pollmode;
    #   icalproperty_pollcompletion v_pollcomplete;
    # */
  end
end
