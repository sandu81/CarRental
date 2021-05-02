
table 52014 "CR Posted Booking Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Posted Booking Header';

    fields
    {
        field(10; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(20; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer No.';
            TableRelation = "Customer";

        }
        field(25; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
        }
        field(30; Address; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Address';
        }
        field(40; "Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Address 2';
        }
        field(50; City; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'City';
        }
        field(55; County; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'County';
        }
        field(60; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Post Code';
        }
        field(65; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country/Region Code';
        }
        field(70; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone No.';
        }
        field(80; "E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(90; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Date';
        }

        field(100; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Date';
        }
        field(110; "Total Price"; Decimal)
        {

            Caption = 'Total Price';
            FieldClass = FlowField;
            CalcFormula = Sum("CR Booking Line".Amount where("Document No." = field("No.")));
            Editable = false;
        }

        field(120; "Booking Status"; Option)
        {
            Caption = 'Booking Status';
            DataClassification = ToBeClassified;
            OptionMembers = "Reservation","Open","Closed","Cancelled";
            OptionCaption = 'Reservation,Open,Closed,Cancelled';
        }
        field(130; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";

        }
        field(140; "Registration No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Caption = 'Registration No. Series';
        }
        field(150; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'User ID';
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.LookupUserID("User ID");
            end;
        }
        field(160; "Source Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Source Code';
            TableRelation = "Source Code";
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


