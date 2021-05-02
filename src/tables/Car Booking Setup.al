table 52000 "CR Car Booking Setup"
{
    Caption = 'Car Booking Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(20; "Car Nos."; Code[10])
        {
            Caption = 'Car Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(30; "Booking Nos."; Code[10])
        {
            Caption = 'Booking Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(40; "Posted Booking Nos."; Code[10])
        {
            Caption = 'Posted Booking Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}