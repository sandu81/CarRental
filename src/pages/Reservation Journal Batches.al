page 52016 "CR Reservation Journal Batches"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Reservation Journal Batch";
    Caption = 'Reservation Journal Batches';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}