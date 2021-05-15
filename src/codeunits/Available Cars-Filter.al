codeunit 52009 "CR Available Cars-Filter"
{
    trigger OnRun()
    begin

    end;

    procedure CarListFilter(VAR FilteredCarList: Record "CR Car"; "From Date": Date; "To Date": Date)
    var
        CarList: Record "CR Car";
        BookedCarFilter: Text;
    begin

        IF CarList.FindSet() then begin
            repeat
                if CarAlreadyBooked(CarList."No.", "From Date", "To Date") then
                    BookedCarFilter += '<>' + CarList."No." + '&';
            until CarList.Next() = 0;
        end;

        if BookedCarFilter <> '' then begin
            BookedCarFilter := DelStr(BookedCarFilter, StrLen(BookedCarFilter), 1);
            FilteredCarList.SetFilter("No.", BookedCarFilter);

        end;

    end;


    procedure CarAlreadyBooked(CarNo: Code[20]; "From Date": Date; "To Date": Date): Boolean
    var
        ReservationLedgerEntry: Record "CR Reservation Ledger Entry";

    begin

        //Bookings for same Car with Start Date between current Start Date and End Date
        ReservationLedgerEntry.Reset();
        ReservationLedgerEntry.SetRange("Is Cancelled", false);
        ReservationLedgerEntry.SetRange("Car No.", CarNo);
        ReservationLedgerEntry.SetRange("Start Date", "From Date", "To Date");
        if not ReservationLedgerEntry.IsEmpty() then
            exit(true);



        //Bookings for same Car with End Date between current Start Date and End Date
        ReservationLedgerEntry.Reset();
        ReservationLedgerEntry.SetRange("Is Cancelled", false);
        ReservationLedgerEntry.SetRange("Car No.", CarNo);
        ReservationLedgerEntry.SetRange("End Date", "From Date", "To Date");
        if not ReservationLedgerEntry.IsEmpty() then
            exit(true);

        //Bookings for same Car with Start Date before current Start Date and End Date after current End Date
        ReservationLedgerEntry.Reset();
        ReservationLedgerEntry.SetRange("Is Cancelled", false);
        ReservationLedgerEntry.SetRange("Car No.", CarNo);
        ReservationLedgerEntry.SetFilter("Start Date", '<%1', "From Date");
        ReservationLedgerEntry.SetFilter("End Date", '>%1', "To Date");
        if not ReservationLedgerEntry.IsEmpty() then
            exit(true);
    end;
}