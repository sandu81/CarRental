codeunit 52000 "CR Reservation Jnl.-Check Line"
{
    TableNo = "CR Reservation Journal Line";

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    procedure RunCheck(var ReservationJnlLine: Record "CR Reservation Journal Line")
    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        NotClosingDatelbl: Label 'cannot be a closing date.';
        NotWithinPostingDateRangelbl: Label 'is not within your range of allowed posting dates.';
    begin
        if ReservationJnlLine.EmptyLine() then
            exit;

        ReservationJnlLine.TestField("Posting Date");
        ReservationJnlLine.TestField("Booking No.");
        ReservationJnlLine.TestField("Car No.");
        ReservationJnlLine.TestField("Customer No.");


        if ReservationJnlLine."Posting Date" = ClosingDate(ReservationJnlLine."Posting Date") then
            ReservationJnlLine.FieldError("Posting Date", NotClosingDatelbl);

        if (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) then begin

            if UserId <> '' then
                if UserSetup.Get(UserId) then begin
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                end;


            if (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) then begin
                GLSetup.Get();

                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            end;

            if AllowPostingTo = 0D then
                AllowPostingTo := 99991231D;
        end;

        if (ReservationJnlLine."Posting Date" < AllowPostingFrom) OR (ReservationJnlLine."Posting Date" > AllowPostingTo) then
            ReservationJnlLine.FieldError("Posting Date", NotWithinPostingDateRangelbl);

        if (ReservationJnlLine."Document Date" <> 0D) then
            if (ReservationJnlLine."Document Date" = ClosingDate(ReservationJnlLine."Document Date")) then
                ReservationJnlLine.FieldError("Document Date", NotClosingDatelbl);

    end;


}