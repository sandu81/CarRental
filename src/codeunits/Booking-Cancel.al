codeunit 52007 "CR Booking-Cancel"
{
    TableNo = "CR Posted Booking Header";

    trigger OnRun()
    begin

        RunPost(Rec);

    end;

    procedure RunPost(var Rec: Record "CR Posted Booking Header")
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

            until PostedBookingLine.Next() = 0;
        end;


        Rec := PostedBookingHeader;

    end;


    var
        CancelledBookingHeader: Record "CR Posted Booking Header";
        CancelledBookingLine: Record "CR Posted Booking Line";
        PostedBookingHeader: Record "CR Posted Booking Header";
        PostedBookingLine: Record "CR Posted Booking Line";
        SourceCodeSetup: Record "Source Code Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SourceCode: Code[10];
        LineCount: Integer;
}