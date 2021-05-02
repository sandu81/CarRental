page 52004 "CR Brands"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Brand";
    Caption = 'Brands';

    layout
    {
        area(Content)
        {
            repeater(brands)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}