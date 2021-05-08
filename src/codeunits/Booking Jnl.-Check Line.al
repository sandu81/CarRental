codeunit 52000 "CR Booking Jnl.-Check Line"
{
    TableNo = "CR Booking Journal Line";

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    procedure RunCheck(var BookingJnlLine: Record "CR Booking Journal Line")
    begin
        if BookingJnlLine.EmptyLine() then
            exit;

        BookingJnlLine.TestField("Posting Date");
        BookingJnlLine.TestField("Booking No.");
        BookingJnlLine.TestField("Car No.");
        BookingJnlLine.TestField("Customer No.");


        if BookingJnlLine."Posting Date" = ClosingDate(BookingJnlLine."Posting Date") then
            BookingJnlLine.FieldError("Posting Date", NotClosingDatelbl);

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

        if (BookingJnlLine."Posting Date" < AllowPostingFrom) OR (BookingJnlLine."Posting Date" > AllowPostingTo) then
            BookingJnlLine.FieldError("Posting Date", NotWithinPostingDateRangelbl);

        if (BookingJnlLine."Document Date" <> 0D) then
            if (BookingJnlLine."Document Date" = ClosingDate(BookingJnlLine."Document Date")) then
                BookingJnlLine.FieldError("Document Date", NotClosingDatelbl);

    end;

    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        NotClosingDatelbl: Label 'cannot be a closing date.';
        NotWithinPostingDateRangelbl: Label 'is not within your range of allowed posting dates.';
}