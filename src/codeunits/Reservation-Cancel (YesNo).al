codeunit 52006 "CR Reservation-Cancel (Yes/No)"
{
    TableNo = "CR Posted Reservation Header";

    trigger OnRun()
    begin
        PostedReservationHeader.COPY(Rec);
        Code;
        Rec := PostedReservationHeader;
    end;

    procedure Code()
    var
        ReservationCancel: Codeunit "CR Reservation-Cancel";
        ConfirmCancellbl: Label 'Do you want to cancel the reservation?';
    begin

        IF NOT CONFIRM(ConfirmCancellbl, FALSE) THEN
            EXIT;
        ReservationCancel.Run(PostedReservationHeader);
        COMMIT;
    end;

    var
        PostedReservationHeader: Record "CR Posted Reservation Header";



}