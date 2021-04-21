page 52002 "CR Car List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Car";
    CardPageId = "CR Car Card";
    Caption = 'Car List';

    layout
    {
        area(Content)
        {
            repeater(cars)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
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
            }
        }
    }


}