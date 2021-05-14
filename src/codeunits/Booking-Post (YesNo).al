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
    var
        BookingPost: Codeunit "CR Booking-Post";
        ConfirmPostinglbl: Label 'Do you want to post the booking?';
    begin

        IF NOT CONFIRM(ConfirmPostinglbl, FALSE) THEN
            EXIT;
        BookingPost.RunPost(BookingHeader);
        COMMIT;
    end;

    var
        BookingHeader: Record "CR Booking Header";


}