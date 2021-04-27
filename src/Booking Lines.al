page 52009 "CR Booking Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Booking Line";
    Caption = 'Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(lines)
            {
                field("Car Type Code"; "Car Type Code")
                {
                    ApplicationArea = All;
                }
                field("Car No."; "Car No.")
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; "Daily Rate")
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
                field("Car Name"; "Car Name")
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
                field("Year"; "Year")
                {
                    ApplicationArea = All;
                }
                field("Doors"; "Doors")
                {
                    ApplicationArea = All;
                }
                field("Passengers"; "Passengers")
                {
                    ApplicationArea = All;
                }
                field("Baggage"; "Baggage")
                {
                    ApplicationArea = All;
                }
                field("Transmission"; "Transmission")
                {
                    ApplicationArea = All;
                }
                field("Fuel Type"; "Fuel Type")
                {
                    ApplicationArea = All;
                }
                field("Mileage"; "Mileage")
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