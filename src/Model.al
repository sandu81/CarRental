table 52004 "CR Model"
{
    CaptionML = ENU = 'Model';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; Code; Code[10])
        {
            CaptionML = ENU = 'Code';
            DataClassification = ToBeClassified;
        }
        field(20; Name; Text[100])
        {
            CaptionML = ENU = 'Name';
            DataClassification = ToBeClassified;
        }
        field(30; Year; Integer)
        {
            CaptionML = ENU = 'Year';
            DataClassification = ToBeClassified;
        }
        field(40; Mileage; Integer)
        {
            CaptionML = ENU = 'Mileage';
            DataClassification = ToBeClassified;
        }
        field(50; "Brand Code"; Code[10])
        {
            CaptionML = ENU = 'Brand Code';
            TableRelation = "CR Brand";
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