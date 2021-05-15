codeunit 52001 "CR Reservation Jnl.-Post Line"
{
    TableNo = "CR Reservation Journal Line";

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    procedure RunWithCheck(var BookingJnlLine2: Record "CR Reservation Journal Line")
    begin

        BookingJnlLine.Copy(BookingJnlLine2);

        Code();

        BookingJnlLine2 := BookingJnlLine;

    end;

    procedure Code()
    begin

        if BookingJnlLine.EmptyLine() then
            exit;

        ReservationJnlCheckLine.RunCheck(BookingJnlLine);

        if NextEntryNo = 0 then begin
            ReservationLedgerEntry.LockTable();

            if ReservationLedgerEntry.FindLast() then
                NextEntryNo := ReservationLedgerEntry."Entry No.";

            NextEntryNo := NextEntryNo + 1;

        end;

        if BookingJnlLine."Document Date" = 0D then
            BookingJnlLine."Document Date" := BookingJnlLine."Document Date";

        if ReservationRegister."No." = 0 then begin
            ReservationRegister.LockTable();

            if (not ReservationRegister.FindLast()) or (ReservationRegister."To Entry No." <> 0) then begin
                ReservationRegister.Init();

                ReservationRegister."No." := ReservationRegister."No." + 1;
                ReservationRegister."From Entry No." := NextEntryNo;
                ReservationRegister."To Entry No." := NextEntryNo;
                ReservationRegister."Creation Date" := Today;
                ReservationRegister."Source Code" := BookingJnlLine."Source Code";
                ReservationRegister."Journal Batch Name" := BookingJnlLine."Journal Batch Name";
                ReservationRegister."User ID" := UserId;
                ReservationRegister.Insert();
            end;
        end;

        ReservationRegister."To Entry No." := NextEntryNo;
        ReservationRegister.Modify();

        ReservationLedgerEntry.Init();
        ReservationLedgerEntry."Booking No." := BookingJnlLine."Booking No.";
        ReservationLedgerEntry."Posting Date" := BookingJnlLine."Posting Date";
        ReservationLedgerEntry."Document Date" := BookingJnlLine."Document Date";
        ReservationLedgerEntry."Document No." := BookingJnlLine."Document No.";
        ReservationLedgerEntry.Amount := BookingJnlLine.Amount;
        ReservationLedgerEntry."Car No." := BookingJnlLine."Car No.";
        ReservationLedgerEntry."Customer No." := BookingJnlLine."Customer No.";
        ReservationLedgerEntry."Daily Rate" := BookingJnlLine."Daily Rate";
        ReservationLedgerEntry."End Date" := BookingJnlLine."End Date";
        ReservationLedgerEntry."No. of Days" := BookingJnlLine."No. of Days";
        ReservationLedgerEntry."Journal Batch Name" := BookingJnlLine."Journal Batch Name";
        ReservationLedgerEntry."Start Date" := BookingJnlLine."Start Date";
        ReservationLedgerEntry.Description := BookingJnlLine.Description;
        ReservationLedgerEntry."Source Code" := BookingJnlLine."Source Code";
        ReservationLedgerEntry."Reason Code" := BookingJnlLine."Reason Code";
        ReservationLedgerEntry."No. Series" := BookingJnlLine."Posting No. Series";
        ReservationLedgerEntry."Is Cancelled" := BookingJnlLine."Is Cancelled";
        ReservationLedgerEntry."User ID" := UserId;
        ReservationLedgerEntry."Entry No." := NextEntryNo;
        ReservationLedgerEntry.Insert();

        NextEntryNo := NextEntryNo + 1;


    end;

    var
        BookingJnlLine: Record "CR Reservation Journal Line";
        ReservationRegister: Record "CR Reservation Register";
        ReservationLedgerEntry: Record "CR Reservation Ledger Entry";
        ReservationJnlCheckLine: Codeunit "CR Reservation Jnl.-Check Line";
        NextEntryNo: Integer;




}