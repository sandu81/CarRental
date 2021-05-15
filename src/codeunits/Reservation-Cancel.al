codeunit 52007 "CR Reservation-Cancel"
{
    TableNo = "CR Posted Reservation Header";

    trigger OnRun()
    var

        CancelledReservationLine: Record "CR Posted Reservation Line";
        SourceCodeSetup: Record "Source Code Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineCount: Integer;
    begin

        ClearAll();

        PostedReservationHeader := Rec;

        PostedReservationLine.Reset();

        PostedReservationLine.SetRange("Document No.", PostedReservationHeader."No.");


        //TODO Show progress with a dialog

        PostedReservationHeader."Is Cancelled" := true;
        PostedReservationHeader."Cancelling No." := NoSeriesMgt.GetNextNo(PostedReservationHeader."No. Series", PostedReservationHeader."Posting Date", true);
        PostedReservationHeader.Modify();
        Commit();


        PostedReservationLine.LockTable();

        SourceCodeSetup.Get();

        SourceCode := SourceCodeSetup.Booking;

        CancelledReservationHeader.Init();
        CancelledReservationHeader.TransferFields(PostedReservationHeader);
        CancelledReservationHeader."No." := PostedReservationHeader."Cancelling No.";
        CancelledReservationHeader."No. Series" := PostedReservationHeader."No. Series";
        CancelledReservationHeader."Source Code" := SourceCode;
        CancelledReservationHeader."User ID" := UserId;
        CancelledReservationHeader."Is Cancelled" := true;
        CancelledReservationHeader.Insert();

        LineCount := 0;

        PostedReservationLine.Reset();

        PostedReservationLine.SetRange("Document No.", PostedReservationHeader."No.");

        if PostedReservationLine.FindSet() then begin
            repeat

                LineCount := LineCount + 1;

                CancelledReservationLine.Init();
                CancelledReservationLine.TransferFields(PostedReservationLine);
                CancelledReservationLine."Document No." := CancelledReservationHeader."No.";
                CancelledReservationLine.Amount := -CancelledReservationLine.Amount;

                CancelledReservationLine.Insert();


            until PostedReservationLine.Next() = 0;
        end;

        CancelReservationLedgerEntry();


        Rec := PostedReservationHeader;

    end;


    procedure CancelReservationLedgerEntry()
    var
        ReservationLedgerEntry: Record "CR Reservation Ledger Entry";
        CancelledReservationLedgerEntry: Record "CR Reservation Ledger Entry";
        LastReservationLedgerEntry: Record "CR Reservation Ledger Entry";
        ReservationRegister: Record "CR Reservation Register";
        NextEntryNo: Integer;
    begin
        ReservationLedgerEntry.Reset();

        ReservationLedgerEntry.SetRange("Document No.", PostedReservationHeader."No.");

        if ReservationLedgerEntry.FindSet() then begin
            repeat

                if NextEntryNo = 0 then begin
                    LastReservationLedgerEntry.LockTable();

                    if LastReservationLedgerEntry.FindLast() then
                        NextEntryNo := LastReservationLedgerEntry."Entry No.";

                    NextEntryNo := NextEntryNo + 1;

                end;


                if ReservationRegister."No." = 0 then begin
                    ReservationRegister.LockTable();

                    if (not ReservationRegister.FindLast()) or (ReservationRegister."To Entry No." <> 0) then begin
                        ReservationRegister.Init();

                        ReservationRegister."No." := ReservationRegister."No." + 1;
                        ReservationRegister."From Entry No." := NextEntryNo;
                        ReservationRegister."To Entry No." := NextEntryNo;
                        ReservationRegister."Creation Date" := Today;
                        //ReservationRegister."Source Code" := BookingJnlLine."Source Code";
                        //ReservationRegister."Journal Batch Name" := BookingJnlLine."Journal Batch Name";
                        ReservationRegister."User ID" := UserId;
                        ReservationRegister.Insert();
                    end;
                end;

                ReservationRegister."To Entry No." := NextEntryNo;
                ReservationRegister.Modify();

                CancelledReservationLedgerEntry.Init();
                CancelledReservationLedgerEntry.TransferFields(ReservationLedgerEntry);
                CancelledReservationLedgerEntry."Entry No." := NextEntryNo;
                CancelledReservationLedgerEntry.Amount := -CancelledReservationLedgerEntry.Amount;
                CancelledReservationLedgerEntry."Is Cancelled" := true;
                CancelledReservationLedgerEntry."Document No." := PostedReservationHeader."Cancelling No.";
                CancelledReservationLedgerEntry.Insert();


                ReservationLedgerEntry."Is Cancelled" := true;
                ReservationLedgerEntry."Cancelling Entry No." := NextEntryNo;
                ReservationLedgerEntry.Modify();

                NextEntryNo := NextEntryNo + 1;

            until ReservationLedgerEntry.Next() = 0;
        end;
    end;

    var
        PostedReservationHeader: Record "CR Posted Reservation Header";
        PostedReservationLine: Record "CR Posted Reservation Line";
        CancelledReservationHeader: Record "CR Posted Reservation Header";
        SourceCode: Code[10];

}