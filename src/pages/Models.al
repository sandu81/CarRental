page 52005 "CR Models"
{
    PageType = List;
    SourceTable = "CR Model";
    Caption = 'Models';


    layout
    {
        area(Content)
        {
            repeater(models)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                field(Mileage; Mileage)
                {
                    ApplicationArea = All;
                }
                field("Brand Code"; "Brand Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}