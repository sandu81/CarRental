page 52008 "CR Reservation"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Reservation Header";
    Caption = 'Reservations';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
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
            part("Reservation Lines"; "CR Reservation Lines")
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

                trigger OnAction()
                var
                    ReservationPost: Codeunit "CR Reservation-Post (Yes/No)";
                    CheckAvailability: Codeunit "CR Available Cars-Filter";
                    ReservationLine: Record "CR Reservation Line";
                    AlreadyBookedlbl: Label 'Atleast one of the cars is already booked for the period selected.';
                begin

                    ReservationLine.SetRange("Document No.", Rec."No.");

                    if ReservationLine.FindSet() then begin
                        repeat
                            if CheckAvailability.CarAlreadyBooked(ReservationLine."Car No.", ReservationLine."Start Date", ReservationLine."End Date") then
                                Error(AlreadyBookedlbl);

                        until ReservationLine.Next() = 0
                    end;


                    ReservationPost.Run(Rec);
                end;

            }
        }
    }

}