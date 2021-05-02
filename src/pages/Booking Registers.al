page 52013 "CR Booking Registers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Booking Register";
    Editable = false;
    Caption = 'Booking Registers';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("From Entry No."; "From Entry No.")
                {
                    ApplicationArea = All;
                }
                field("To Entry No."; "To Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area("Processing")
        {
            action("Booking Ledger")
            {
                ApplicationArea = All;
                RunObject = codeunit "CR Booking-Show Ledger";
                Image = "WarrantyLedger";


            }
        }
    }
}