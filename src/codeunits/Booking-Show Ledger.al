codeunit 52003 "CR Booking-Show Ledger"
{
    TableNo = "CR Booking Register";

    trigger OnRun()
    var
        BookingLedgerEntry: Record "CR Booking Ledger Entry";
    begin
        BookingLedgerEntry.SetRange("Entry No.", "From Entry No.", "To Entry No.");

        Page.Run(Page::"CR Booking Ledger Entries", BookingLedgerEntry);
    end;


}