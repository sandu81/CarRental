table 52002 "CR Car Type"
{
    Caption = 'Car Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(20; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(30; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            DataClassification = ToBeClassified;
        }
        field(40; Doors; Integer)
        {
            Caption = 'Doors';
            DataClassification = ToBeClassified;
        }
        field(50; Passengers; Integer)
        {
            Caption = 'Passengers';
            DataClassification = ToBeClassified;
        }
        field(60; Baggage; Integer)
        {
            Caption = 'Baggage';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }


}