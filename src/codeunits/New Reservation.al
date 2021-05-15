codeunit 52010 "CR New Reservation"
{
    trigger OnRun()
    begin



    end;

    procedure Init(Car: Record "CR Car"; FromDate: Date; ToDate: Date)
    var
        ReservationHeader: Record "CR Reservation Header";
        ReservationLine: Record "CR Reservation Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CarRentalSetup: Record "CR Car Booking Setup";
    begin
        CarRentalSetup.Get();

        CarRentalSetup.TestField("Booking Nos.");

        ReservationHeader.InitRecord();
        NoSeriesMgt.InitSeries(CarRentalSetup."Booking Nos.", ReservationHeader."No. Series", 0D, ReservationHeader."No.", ReservationHeader."No. Series");

        ReservationLine.Init();
        ReservationLine."Car Type Code" := Car."Car Type Code";
        ReservationLine."Car No." := Car."No.";
        ReservationLine.Validate("Car No.");
        ReservationLine."Start Date" := FromDate;
        ReservationLine."End Date" := ToDate;
        ReservationLine.CalculateAmount();
        ReservationLine."Document No." := ReservationHeader."No.";

        ReservationHeader.Insert();
        ReservationLine.Insert();


        Page.Run(Page::"CR Reservation", ReservationHeader);

    end;
}