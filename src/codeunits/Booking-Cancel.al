codeunit 52007 "CR Booking-Cancel"
{
    TableNo = "CR Posted Booking Header";

    trigger OnRun()
    var

        CancelledBookingLine: Record "CR Posted Booking Line";
        SourceCodeSetup: Record "Source Code Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineCount: Integer;
    begin

        ClearAll();

        PostedBookingHeader := Rec;

        PostedBookingLine.Reset();

        PostedBookingLine.SetRange("Document No.", PostedBookingHeader."No.");


        //TODO Show progress with a dialog

        PostedBookingHeader."Is Cancelled" := true;
        PostedBookingHeader."Cancelling No." := NoSeriesMgt.GetNextNo(PostedBookingHeader."No. Series", PostedBookingHeader."Posting Date", true);
        PostedBookingHeader.Modify();
        Commit();


        PostedBookingLine.LockTable();

        SourceCodeSetup.Get();

        SourceCode := SourceCodeSetup.Booking;

        CancelledBookingHeader.Init();
        CancelledBookingHeader.TransferFields(PostedBookingHeader);
        CancelledBookingHeader."No." := PostedBookingHeader."Cancelling No.";
        CancelledBookingHeader."No. Series" := PostedBookingHeader."No. Series";
        CancelledBookingHeader."Source Code" := SourceCode;
        CancelledBookingHeader."User ID" := UserId;
        CancelledBookingHeader."Is Cancelled" := true;
        CancelledBookingHeader.Insert();

        LineCount := 0;

        PostedBookingLine.Reset();

        PostedBookingLine.SetRange("Document No.", PostedBookingHeader."No.");

        if PostedBookingLine.FindSet() then begin
            repeat

                LineCount := LineCount + 1;

                CancelledBookingLine.Init();
                CancelledBookingLine.TransferFields(PostedBookingLine);
                CancelledBookingLine."Document No." := CancelledBookingHeader."No.";
                CancelledBookingLine.Amount := -CancelledBookingLine.Amount;

                CancelledBookingLine.Insert();

            //PostBookingJnlLine();

            until PostedBookingLine.Next() = 0;
        end;

        CancelBookingLedgerEntry();


        Rec := PostedBookingHeader;

    end;


    procedure CancelBookingLedgerEntry()
    var
        BookingLedgerEntry: Record "CR Booking Ledger Entry";
        CancelledBookingLedgerEntry: Record "CR Booking Ledger Entry";
        LastBookingLedgerEntry: Record "CR Booking Ledger Entry";
        BookingRegister: Record "CR Booking Register";
        NextEntryNo: Integer;
    begin
        BookingLedgerEntry.Reset();

        BookingLedgerEntry.SetRange("Document No.", PostedBookingHeader."No.");

        if BookingLedgerEntry.FindSet() then begin
            repeat

                if NextEntryNo = 0 then begin
                    LastBookingLedgerEntry.LockTable();

                    if LastBookingLedgerEntry.FindLast() then
                        NextEntryNo := LastBookingLedgerEntry."Entry No.";

                    NextEntryNo := NextEntryNo + 1;

                end;


                if BookingRegister."No." = 0 then begin
                    BookingRegister.LockTable();

                    if (not BookingRegister.FindLast()) or (BookingRegister."To Entry No." <> 0) then begin
                        BookingRegister.Init();

                        BookingRegister."No." := BookingRegister."No." + 1;
                        BookingRegister."From Entry No." := NextEntryNo;
                        BookingRegister."To Entry No." := NextEntryNo;
                        BookingRegister."Creation Date" := Today;
                        //BookingRegister."Source Code" := BookingJnlLine."Source Code";
                        //BookingRegister."Journal Batch Name" := BookingJnlLine."Journal Batch Name";
                        BookingRegister."User ID" := UserId;
                        BookingRegister.Insert();
                    end;
                end;

                BookingRegister."To Entry No." := NextEntryNo;
                BookingRegister.Modify();

                CancelledBookingLedgerEntry.Init();
                CancelledBookingLedgerEntry.TransferFields(BookingLedgerEntry);
                CancelledBookingLedgerEntry."Entry No." := NextEntryNo;
                CancelledBookingLedgerEntry.Amount := -CancelledBookingLedgerEntry.Amount;
                CancelledBookingLedgerEntry."Is Cancelled" := true;
                CancelledBookingLedgerEntry."Document No." := PostedBookingHeader."Cancelling No.";
                CancelledBookingLedgerEntry.Insert();


                BookingLedgerEntry."Is Cancelled" := true;
                BookingLedgerEntry."Cancelling Entry No." := NextEntryNo;
                BookingLedgerEntry.Modify();

                NextEntryNo := NextEntryNo + 1;

            until BookingLedgerEntry.Next() = 0;
        end;
    end;

    var
        PostedBookingHeader: Record "CR Posted Booking Header";
        PostedBookingLine: Record "CR Posted Booking Line";
        CancelledBookingHeader: Record "CR Posted Booking Header";
        BookingJnlPostLine: Codeunit "CR Booking Jnl.-Post Line";
        SourceCode: Code[10];

}