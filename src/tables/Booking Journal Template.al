table 52016 "CR Booking Journal Template"
{
    DataClassification = ToBeClassified;
    Caption = 'Booking Journal Template';

    fields
    {
        field(1; Name; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}