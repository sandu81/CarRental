table 52003 "CR Brand"
{
    Caption = 'Brand';
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
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }


}