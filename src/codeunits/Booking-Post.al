codeunit 52005 "CR Booking-Post"
{
    TableNo = "CR Booking Header";

    trigger OnRun()
    begin

        RunPost(Rec);

    end;

    procedure RunPost(var Rec: Record "CR Booking Header")
    begin

        ClearAll();

        BookingHeader := Rec;

        BookingHeader.TestField("Posting Date");
        BookingHeader.TestField("Document Date");
        BookingHeader.TestField("Customer No.");
        BookingHeader.TestField("Booking Status", BookingHeader."Booking Status"::Closed);

        BookingLine.Reset();

        BookingLine.SetRange("Document No.", BookingHeader."No.");

        if BookingLine.IsEmpty then
            Error(Text001);


        //TODO Show progress with a dialog

        if BookingHeader."Posting No." = '' then begin
            BookingHeader.TestField("Posting No. Series");

            BookingHeader."Posting No." := NoSeriesMgt.GetNextNo(BookingHeader."Posting No. Series", BookingHeader."Posting Date", true);

            BookingHeader.Modify();

            Commit();
        end;

        BookingLine.LockTable();

        SourceCodeSetup.Get();

        SourceCode := SourceCodeSetup.Booking;

        PostedBookingHeader.Init();
        PostedBookingHeader.TransferFields(BookingHeader);
        PostedBookingHeader."No." := BookingHeader."Posting No.";
        PostedBookingHeader."No. Series" := BookingHeader."Posting No. Series";
        PostedBookingHeader."Source Code" := SourceCode;
        PostedBookingHeader."User ID" := UserId;
        PostedBookingHeader.Insert();

        LineCount := 0;

        BookingLine.Reset();

        BookingLine.SetRange("Document No.", BookingHeader."No.");

        if BookingLine.FindSet() then begin
            repeat

                LineCount := LineCount + 1;

                BookingLine.TestField("Car No.");
                BookingLine.TestField("Start Date");
                BookingLine.TestField("End Date");

                //Post Booking Entry
                PostBookingJnlLine();

                PostedBookingLine.Init();
                PostedBookingLine.TransferFields(BookingLine);
                PostedBookingLine."Document No." := PostedBookingHeader."No.";

                PostedBookingLine.Insert();

            until BookingLine.Next() = 0;
        end;

        BookingHeader.Delete();
        BookingLine.DeleteAll();


        Rec := BookingHeader;

    end;

    procedure PostBookingJnlLine()
    begin
        BookingJnlLine.Init();

        BookingJnlLine."Booking No." := BookingHeader."No.";
        BookingJnlLine."Booking Status" := BookingHeader."Booking Status";
        BookingJnlLine."Posting Date" := BookingHeader."Posting Date";
        BookingJnlLine."Document Date" := BookingHeader."Document Date";
        BookingJnlLine."Document No." := PostedBookingHeader."No.";
        BookingJnlLine."Customer No." := BookingHeader."Customer No.";
        BookingJnlLine."Source Code" := SourceCode;
        //BookingJnlLine."Reason Code" := ?
        BookingJnlLine."Posting No. Series" := BookingHeader."Posting No. Series";
        BookingJnlLine.Description := BookingHeader."Customer Name";

        BookingJnlLine."Car No." := BookingLine."Car No.";
        BookingJnlLine."Start Date" := BookingLine."Start Date";
        BookingJnlLine."End Date" := BookingLine."End Date";
        BookingJnlLine.Amount := BookingLine.Amount;
        BookingJnlLine."Daily Rate" := BookingLine."Daily Rate";
        BookingJnlLine."No. of Days" := BookingLine."No. of Days";

        BookingJnlPostLine.RunWithCheck(BookingJnlLine);

    end;

    var
        BookingHeader: Record "CR Booking Header";
        BookingLine: Record "CR Booking Line";
        PostedBookingHeader: Record "CR Posted Booking Header";
        PostedBookingLine: Record "CR Posted Booking Line";
        BookingJnlLine: Record "CR Booking Journal Line";
        BookingJnlPostLine: Codeunit "CR Booking Jnl.-Post Line";
        Text001: Label 'Cannot post booking with no vehicles.';
        NoSeriesMgt: Codeunit NoSeriesManagement;

        SourceCodeSetup: Record "Source Code Setup";
        SourceCode: Code[10];
        LineCount: Integer;
}