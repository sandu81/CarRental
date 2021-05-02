table 52012 "CR Booking Journal Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Booking Journal';

    fields
    {
        field(10; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Template Name';
        }
        field(20; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }
        field(25; Description; Text[50])
        {

        }
        field(30; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                Validate("Document Date", "Posting Date");
            end;
        }
        field(40; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Date';
        }
        field(50; "Booking No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Booking No.';
        }
        field(60; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer No.';
            TableRelation = "Customer";
        }
        field(70; "Car No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Car No.';
            TableRelation = "CR Car";
        }
        field(75; "Booking Status"; Option)
        {
            OptionMembers = "Reservation","Open","Closed","Canceled";
            OptionCaption = 'Reservation,Open,Closed,Canceled';
            Caption = 'Booking Status';
            DataClassification = ToBeClassified;

        }
        field(80; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(90; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(100; "Daily Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Daily Rate';
        }
        field(105; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No. of Days';
        }
        field(110; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(120; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';
        }
        field(130; "Posting No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting No. Series';
        }
        field(200; "Source Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Code';
        }
        field(300; "Reason Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason Code';
        }

        field(400; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Batch Name';
        }
    }

    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure EmptyLine(): Boolean
    begin
        Exit("Customer No." = '');
        Exit("Car No." = '');
    end;

}