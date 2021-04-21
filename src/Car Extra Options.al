page 52007 "CR Car Extra Options"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Car Extra Option";
    Caption = 'Car Extra Options';

    layout
    {
        area(Content)
        {
            repeater(carExtraOptions)
            {
                field("Car No."; "Car No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Extra Option Code"; "Extra Option Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}