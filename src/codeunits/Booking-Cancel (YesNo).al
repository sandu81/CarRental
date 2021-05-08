codeunit 52006 "CR Booking-Cancel (Yes/No)"
{
    TableNo = "CR Posted Booking Header";

    trigger OnRun()
    begin
        RunYesNo(Rec);
    end;

    procedure RunYesNo(var Rec: Record "CR Posted Booking Header")
    begin

        PostedBookingHeader.COPY(Rec);
        Code;
        Rec := PostedBookingHeader;
    end;

    procedure Code()
    begin

        IF NOT CONFIRM(ConfirmCancellbl, FALSE) THEN
            EXIT;
        BookingCancel.RunPost(PostedBookingHeader);
        COMMIT;
    end;

    var
        PostedBookingHeader: Record "CR Posted Booking Header";
        BookingCancel: Codeunit "CR Booking-Cancel";
        ConfirmCancellbl: Label 'Do you want to cancel the booking?';

}