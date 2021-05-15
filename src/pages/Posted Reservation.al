page 52011 "CR Posted Reservation"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Posted Reservation Header";
    Caption = 'Posted Reservation';
    //Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Total Price"; "Total Price")
                {
                    ApplicationArea = All;
                }
                field("Is Cancelled"; "Is Cancelled")
                {
                    ApplicationArea = All;
                }
                field("Cancelling No."; "Cancelling No.")
                {
                    ApplicationArea = All;
                }

            }
            part("Lines"; "CR Posted Reservation Lines")
            {
                SubPageLink = "Document No." = field("No.");
            }
            group("Customer Details")
            {

                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Address"; "Address")
                {
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                }
                field("City"; "City")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                }
                field("County"; "County")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Cancel)
            {
                ApplicationArea = All;
                Caption = 'Cancel';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ShortcutKey = F9;
                RunObject = codeunit "CR Reservation-Cancel (Yes/No)";
                Visible = not "Is Cancelled";

            }
        }
    }
}