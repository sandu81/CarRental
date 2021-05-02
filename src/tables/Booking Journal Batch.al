table 52017 "CR Booking Journal Batch"
{
    DataClassification = ToBeClassified;
    Caption = 'Booking Journal Batch';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Template Name';
            TableRelation = "CR Booking Journal Template";
        }
        field(2; Name; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Journal Template Name", "Name")
        {
            Clustered = true;
        }
    }
}