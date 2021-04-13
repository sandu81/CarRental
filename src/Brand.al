table 52003 "CR Brand"
{
    CaptionML = ENU = 'Brand';
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
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }


}