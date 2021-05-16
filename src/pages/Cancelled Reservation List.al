page 52022 "CR Cancelled Reservation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Posted Reservation Header";
    Caption = 'Cancelled Reservation List';
    CardPageId = "CR Posted Reservation";
    SourceTableView = where("Is Cancelled" = const(true));
    Editable = false;

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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}