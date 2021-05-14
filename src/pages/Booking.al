page 52008 "CR Booking"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Booking Header";
    Caption = 'Booking';

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

            }
            part("Booking Lines"; "CR Booking Lines")
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
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'P&ost';
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                ShortcutKey = F9;
                RunObject = codeunit "CR Booking-Post (Yes/No)";

            }
        }
    }

}