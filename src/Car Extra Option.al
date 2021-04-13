table 52006 "CR Car Extra Option"
{
    CaptionML = ENU = 'Car Extra Option';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Car No."; Code[20])
        {
            CaptionML = ENU = 'Car No.';
            TableRelation = "CR Car";
            DataClassification = ToBeClassified;

        }
        field(20; Name; Text[100])
        {
            CaptionML = ENU = 'Name';
            DataClassification = ToBeClassified;
        }
        field(30; "Extra Option Code"; Code[10])
        {
            CaptionML = ENU = 'Extra Option Code';
            TableRelation = "CR Extra Option";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Car No.", "Extra Option Code")
        {
            Clustered = true;
        }
    }
}