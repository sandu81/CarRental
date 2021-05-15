codeunit 52004 "CR Reservation-Post (Yes/No)"
{
    TableNo = "CR Reservation Header";

    trigger OnRun()
    begin
        ReservationHeader.COPY(Rec);
        Code;
        Rec := ReservationHeader;
    end;

    procedure Code()
    var
        ReservationPost: Codeunit "CR Reservation-Post";
        ConfirmPostinglbl: Label 'Do you want to post the reservation?';
    begin

        IF NOT CONFIRM(ConfirmPostinglbl, FALSE) THEN
            EXIT;
        ReservationPost.Run(ReservationHeader);
        COMMIT;
    end;

    var
        ReservationHeader: Record "CR Reservation Header";


}