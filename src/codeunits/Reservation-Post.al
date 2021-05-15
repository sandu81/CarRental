codeunit 52005 "CR Reservation-Post"
{
    TableNo = "CR Reservation Header";

    trigger OnRun()
    var
        PostedReservationLine: Record "CR Posted Reservation Line";
        SourceCodeSetup: Record "Source Code Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoVehicleslbl: Label 'Cannot post reservation with no vehicles.';
        LineCount: Integer;
    begin

        ClearAll();

        ReservationHeader := Rec;

        ReservationHeader.TestField("Posting Date");
        ReservationHeader.TestField("Document Date");
        ReservationHeader.TestField("Customer No.");

        ReservationLine.Reset();

        ReservationLine.SetRange("Document No.", ReservationHeader."No.");

        if ReservationLine.IsEmpty then
            Error(NoVehicleslbl);

        if ReservationHeader."Posting No." = '' then begin
            ReservationHeader.TestField("Posting No. Series");

            ReservationHeader."Posting No." := NoSeriesMgt.GetNextNo(ReservationHeader."Posting No. Series", ReservationHeader."Posting Date", true);

            ReservationHeader.Modify();

            Commit();
        end;

        ReservationLine.LockTable();

        SourceCodeSetup.Get();

        SourceCode := SourceCodeSetup.Booking;

        PostedReservationHeader.Init();
        PostedReservationHeader.TransferFields(ReservationHeader);
        PostedReservationHeader."No." := ReservationHeader."Posting No.";
        PostedReservationHeader."No. Series" := ReservationHeader."Posting No. Series";
        PostedReservationHeader."Source Code" := SourceCode;
        PostedReservationHeader."User ID" := UserId;
        PostedReservationHeader."Is Cancelled" := false;
        PostedReservationHeader.Insert();

        LineCount := 0;

        ReservationLine.Reset();

        ReservationLine.SetRange("Document No.", ReservationHeader."No.");

        if ReservationLine.FindSet() then begin
            repeat

                LineCount := LineCount + 1;

                ReservationLine.TestField("Car No.");
                ReservationLine.TestField("Start Date");
                ReservationLine.TestField("End Date");

                PostReservationJnlLine();

                PostedReservationLine.Init();
                PostedReservationLine.TransferFields(ReservationLine);
                PostedReservationLine."Document No." := PostedReservationHeader."No.";

                PostedReservationLine.Insert();

            until ReservationLine.Next() = 0;
        end;

        ReservationHeader.Delete();
        ReservationLine.DeleteAll();


        Rec := ReservationHeader;

    end;

    procedure PostReservationJnlLine()
    var
        ReservationJnlLine: Record "CR Reservation Journal Line";

    begin
        ReservationJnlLine.Init();

        ReservationJnlLine."Booking No." := ReservationHeader."No.";
        ReservationJnlLine."Posting Date" := ReservationHeader."Posting Date";
        ReservationJnlLine."Document Date" := ReservationHeader."Document Date";
        ReservationJnlLine."Document No." := PostedReservationHeader."No.";
        ReservationJnlLine."Customer No." := ReservationHeader."Customer No.";
        ReservationJnlLine."Source Code" := SourceCode;
        ReservationJnlLine."Posting No. Series" := ReservationHeader."Posting No. Series";
        ReservationJnlLine.Description := ReservationHeader."Customer Name";

        ReservationJnlLine."Car No." := ReservationLine."Car No.";
        ReservationJnlLine."Start Date" := ReservationLine."Start Date";
        ReservationJnlLine."End Date" := ReservationLine."End Date";
        ReservationJnlLine.Amount := ReservationLine.Amount;
        ReservationJnlLine."Daily Rate" := ReservationLine."Daily Rate";
        ReservationJnlLine."No. of Days" := ReservationLine."No. of Days";

        ReservationJnlPostLine.RunWithCheck(ReservationJnlLine);

    end;

    var
        ReservationHeader: Record "CR Reservation Header";
        ReservationLine: Record "CR Reservation Line";
        PostedReservationHeader: Record "CR Posted Reservation Header";
        ReservationJnlPostLine: Codeunit "CR Reservation Jnl.-Post Line";
        SourceCode: Code[10];

}