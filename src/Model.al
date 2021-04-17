table 52004 "CR Model"
{
    Caption = 'Model';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(20; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(30; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
        field(40; Mileage; Integer)
        {
            Caption = 'Mileage';
            DataClassification = ToBeClassified;
        }
        field(50; "Brand Code"; Code[10])
        {
            Caption = 'Brand Code';
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