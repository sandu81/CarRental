codeunit 52001 "CR Booking Jnl.-Post Line"
{
    TableNo = "CR Booking Journal Line";

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    procedure RunWithCheck(var BookingJnlLine2: Record "CR Booking Journal Line")
    begin

        BookingJnlLine.Copy(BookingJnlLine2);

        Code();

        BookingJnlLine2 := BookingJnlLine;

    end;

    procedure Code()
    begin

        if BookingJnlLine.EmptyLine() then
            exit;

        BookingJnlCheckLine.RunCheck(BookingJnlLine);

        if NextEntryNo = 0 then begin
            BookingLedgerEntry.LockTable();

            if BookingLedgerEntry.FindLast() then
                NextEntryNo := BookingLedgerEntry."Entry No.";

            NextEntryNo := NextEntryNo + 1;

        end;

        if BookingJnlLine."Document Date" = 0D then
            BookingJnlLine."Document Date" := BookingJnlLine."Document Date";

        if BookingRegister."No." = 0 then begin
            BookingRegister.LockTable();

            if (not BookingRegister.FindLast()) or (BookingRegister."To Entry No." <> 0) then begin
                BookingRegister.Init();

                BookingRegister."No." := BookingRegister."No." + 1;
                BookingRegister."From Entry No." := NextEntryNo;
                BookingRegister."To Entry No." := NextEntryNo;
                BookingRegister."Creation Date" := Today;
                BookingRegister."Source Code" := BookingJnlLine."Source Code";
                BookingRegister."Journal Batch Name" := BookingJnlLine."Journal Batch Name";
                BookingRegister."User ID" := UserId;
                BookingRegister.Insert();
            end;
        end;

        BookingRegister."To Entry No." := NextEntryNo;
        BookingRegister.Modify();

        BookingLedgerEntry.Init();
        BookingLedgerEntry."Booking No." := BookingJnlLine."Booking No.";
        BookingLedgerEntry."Posting Date" := BookingJnlLine."Posting Date";
        BookingLedgerEntry."Document Date" := BookingJnlLine."Document Date";
        BookingLedgerEntry."Document No." := BookingJnlLine."Document No.";
        BookingLedgerEntry.Amount := BookingJnlLine.Amount;
        BookingLedgerEntry."Booking Status" := BookingJnlLine."Booking Status";
        BookingLedgerEntry."Car No." := BookingJnlLine."Car No.";
        BookingLedgerEntry."Customer No." := BookingJnlLine."Customer No.";
        BookingLedgerEntry."Daily Rate" := BookingJnlLine."Daily Rate";
        BookingLedgerEntry."End Date" := BookingJnlLine."End Date";
        BookingLedgerEntry."No. of Days" := BookingJnlLine."No. of Days";
        BookingLedgerEntry."Journal Batch Name" := BookingJnlLine."Journal Batch Name";
        BookingLedgerEntry."Start Date" := BookingJnlLine."Start Date";
        BookingLedgerEntry.Description := BookingJnlLine.Description;
        BookingLedgerEntry."Source Code" := BookingJnlLine."Source Code";
        BookingLedgerEntry."Reason Code" := BookingJnlLine."Reason Code";
        BookingLedgerEntry."No. Series" := BookingJnlLine."Posting No. Series";
        BookingLedgerEntry."User ID" := UserId;
        BookingLedgerEntry."Entry No." := NextEntryNo;
        BookingLedgerEntry.Insert();

        NextEntryNo := NextEntryNo + 1;


    end;

    var
        BookingJnlLine: Record "CR Booking Journal Line";
        BookingLedgerEntry: Record "CR Booking Ledger Entry";
        BookingRegister: Record "CR Booking Register";
        BookingJnlCheckLine: Codeunit "CR Booking Jnl.-Check Line";
        NextEntryNo: Integer;
}