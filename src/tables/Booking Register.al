table 52011 "CR Booking Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(20; "From Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'From Entry No.';
        }
        field(30; "To Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'To Entry No.';
        }
        field(40; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Creation Date';
        }
        field(50; "Source Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Code';
        }
        field(60; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'User ID';
        }
        field(70; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Batch Name';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}