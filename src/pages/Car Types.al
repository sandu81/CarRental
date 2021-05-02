page 52003 "CR Car Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Car Type";
    Caption = 'Car Types';

    layout
    {
        area(Content)
        {
            repeater(carTypes)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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
            }
        }
    }

}