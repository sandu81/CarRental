codeunit 52004 "CR Booking-Post (Yes/No)"
{
    TableNo = "CR Booking Header";

    trigger OnRun()
    begin
        RunYesNo(Rec);
    end;

    procedure RunYesNo(var Rec: Record "CR Booking Header")
    begin

        BookingHeader.COPY(Rec);
        Code;
        Rec := BookingHeader;
    end;

    procedure Code()
    begin

        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        BookingPost.RunPost(BookingHeader);
        COMMIT;
    end;

    var
        BookingHeader: Record "CR Booking Header";
        Text001: Label 'Do you want to post the booking?';
        BookingPost: Codeunit "CR Booking-Post";
}