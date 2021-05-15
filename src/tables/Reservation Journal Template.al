table 52016 "CR Reservation Jnl. Template"
{
    DataClassification = ToBeClassified;
    Caption = 'Reservation Journal Template';

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