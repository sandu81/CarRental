page 52000 "CR Car Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Car Setup";
    Caption = 'Car Setup';

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Car Nos."; "Car Nos.")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        if not FindFirst() then
            Insert();

    end;
}