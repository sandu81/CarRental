page 52001 "CR Car Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Car";
    Caption = 'Car Card';

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
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Car Type"; "Car Type Code")
                {
                    ApplicationArea = All;
                }
                field("Brand Code"; "Brand Code")
                {
                    ApplicationArea = All;
                }
                field("Model Code"; "Model Code")
                {
                    ApplicationArea = All;
                }
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; "Daily Rate")
                {
                    ApplicationArea = All;
                }
                field(Doors; Doors)
                {
                    ApplicationArea = All;
                }
                field(Passengers; Passengers)
                {
                    ApplicationArea = All;
                }
                field(Baggage; Baggage)
                {
                    ApplicationArea = All;
                }
                field(Transmission; Transmission)
                {
                    ApplicationArea = All;
                }
                field("Fuel Type"; "Fuel Type")
                {
                    ApplicationArea = All;
                }
                field(Mileage; Mileage)
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(Profitability; "CR Car Profitability")
            {
                Caption = 'Key Figures';
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }

        }
    }


}