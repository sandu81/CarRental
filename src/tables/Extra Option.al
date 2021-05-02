table 52005 "CR Extra Option"
{
    Caption = 'Extra Option';
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
        field(30; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = "Convenience","Entertainment","Safety","Seating","Exterior";
            OptionCaption = 'Convenience, Entertainment,Safety,Seating,Exterior';
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