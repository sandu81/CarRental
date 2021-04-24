page 52000 "CR Car Booking Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Car Booking Setup";
    Caption = 'Car Booking Setup';

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