codeunit 52003 "CR Show Ledgers"
{
    TableNo = "CR Reservation Register";

    trigger OnRun()
    var
        ReservationLedgerEntry: Record "CR Reservation Ledger Entry";
    begin
        ReservationLedgerEntry.SetRange("Entry No.", "From Entry No.", "To Entry No.");

        Page.Run(Page::"CR Reservation Ledger Entries", ReservationLedgerEntry);
    end;


}