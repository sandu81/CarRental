page 52006 "CR Extra Options"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Extra Option";

    layout
    {
        area(Content)
        {
            repeater(options)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Category; Category)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}