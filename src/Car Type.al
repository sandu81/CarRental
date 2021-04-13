table 52002 "CR Car Type"
{
    CaptionML = ENU = 'Car Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; Code; Code[10])
        {
            CaptionML = ENU = 'Code';
            DataClassification = ToBeClassified;
        }
        field(20; Description; Text[100])
        {
            CaptionML = ENU = 'Description';
            DataClassification = ToBeClassified;
        }
        field(30; "Daily Rate"; Decimal)
        {
            CaptionML = ENU = 'Daily Rate';
            DataClassification = ToBeClassified;
        }
        field(40; Doors; Integer)
        {
            CaptionML = ENU = 'Doors';
            DataClassification = ToBeClassified;
        }
        field(50; Passengers; Integer)
        {
            CaptionML = ENU = 'Passengers';
            DataClassification = ToBeClassified;
        }
        field(60; Baggage; Integer)
        {
            CaptionML = ENU = 'Baggage';
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