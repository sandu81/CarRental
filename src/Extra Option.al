table 52005 "CR Extra Option"
{
    CaptionML = ENU = 'Extra Option';
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
        field(30; Category; Option)
        {
            CaptionML = ENU = 'Category';
            OptionMembers = "Convenience","Entertainment","Safety","Seating","Exterior";
            OptionCaptionML = ENU = 'Convenience, Entertainment,Safety,Seating,Exterior';
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