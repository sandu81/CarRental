table 52017 "CR Reservation Journal Batch"
{
    DataClassification = ToBeClassified;
    Caption = 'Reservation Journal Batch';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Template Name';
            TableRelation = "CR Reservation Jnl. Template";
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