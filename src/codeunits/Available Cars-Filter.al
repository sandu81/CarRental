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


    local procedure CarAlreadyBooked(CarNo: Code[20]; "From Date": Date; "To Date": Date): Boolean
    var
        BookingLedgerEntry: Record "CR Booking Ledger Entry";

    begin

        //Bookings for same Car with Start Date between current Start Date and End Date
        BookingLedgerEntry.Reset();
        BookingLedgerEntry.SetRange("Is Cancelled", false);
        BookingLedgerEntry.SetRange("Car No.", CarNo);
        BookingLedgerEntry.SetRange("Start Date", "From Date", "To Date");
        if not BookingLedgerEntry.IsEmpty() then
            exit(true);



        //Bookings for same Car with End Date between current Start Date and End Date
        BookingLedgerEntry.Reset();
        BookingLedgerEntry.SetRange("Is Cancelled", false);
        BookingLedgerEntry.SetRange("Car No.", CarNo);
        BookingLedgerEntry.SetRange("End Date", "From Date", "To Date");
        if not BookingLedgerEntry.IsEmpty() then
            exit(true);

        //Bookings for same Car with Start Date before current Start Date and End Date after current End Date
        BookingLedgerEntry.Reset();
        BookingLedgerEntry.SetRange("Is Cancelled", false);
        BookingLedgerEntry.SetRange("Car No.", CarNo);
        BookingLedgerEntry.SetFilter("Start Date", '<%1', "From Date");
        BookingLedgerEntry.SetFilter("End Date", '>%1', "To Date");
        if not BookingLedgerEntry.IsEmpty() then
            exit(true);
    end;
}