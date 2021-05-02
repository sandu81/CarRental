page 52012 "CR Booking Ledger Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Booking Ledger Entry";
    Editable = false;
    Caption = 'Booking Ledger Entries';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Booking No."; "Booking No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Car No."; "Car No.")
                {
                    ApplicationArea = All;
                }
                field("Booking Status"; "Booking Status")
                {
                    ApplicationArea = All;

                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; "Daily Rate")
                {
                    ApplicationArea = All;
                }
                field("No. of Days"; "No. of Days")
                {
                    ApplicationArea = All;
                }
                field("Amount"; "Amount")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}