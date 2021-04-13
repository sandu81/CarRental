table 52001 "CR Car"
{
    CaptionML = ENU = 'Car';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "No."; Code[20])
        {
            CaptionML = ENU = 'No.';
            DataClassification = ToBeClassified;
        }
        field(20; Name; Text[100])
        {
            CaptionML = ENU = 'Name';
            DataClassification = ToBeClassified;
        }
        field(30; Blocked; Boolean)
        {
            CaptionML = ENU = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(40; "Car Type Code"; Code[10])
        {
            CaptionML = ENU = 'Car Type Code';
            TableRelation = "CR Car Type";
            DataClassification = ToBeClassified;
        }
        field(50; "Brand Code"; Code[10])
        {
            CaptionML = ENU = 'Brand Code';
            TableRelation = "CR Brand";
            DataClassification = ToBeClassified;
        }
        field(60; "Model Code"; Code[10])
        {
            CaptionML = ENU = 'Model Code';
            TableRelation = "CR Model";
            DataClassification = ToBeClassified;
        }
        field(70; Year; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CR Model".Year where("Code" = field("Model Code")));
            CaptionML = ENU = 'Year';
        }
        field(80; "Daily Rate"; Decimal)
        {
            CaptionML = ENU = 'Daily Rate';
            DataClassification = ToBeClassified;
        }
        field(90; Doors; Integer)
        {
            CaptionML = ENU = 'Doors';
            DataClassification = ToBeClassified;
        }
        field(100; Passengers; Integer)
        {
            CaptionML = ENU = 'Passengers';
            DataClassification = ToBeClassified;
        }
        field(110; Baggage; Integer)
        {
            CaptionML = ENU = 'Baggage';
            DataClassification = ToBeClassified;
        }
        field(120; Transmission; Option)
        {
            CaptionML = ENU = 'Transmission';
            OptionMembers = "Automatic","Manual";
            OptionCaptionML = ENU = 'Automatic,Manual';
            DataClassification = ToBeClassified;
        }
        field(130; "Fuel Type"; Option)
        {
            CaptionML = ENU = 'Fuel Type';
            OptionMembers = "Petrol","Diesel","Hybrid","Electric";
            OptionCaptionML = ENU = 'Petrol,Diesel,Hybrid,Electric';
            DataClassification = ToBeClassified;
        }
        field(140; Mileage; Integer)
        {
            CaptionML = ENU = 'Mileage';
            DataClassification = ToBeClassified;
        }
        field(150; Revenue; Decimal)
        {
            CaptionML = ENU = 'Revenue';
            DataClassification = ToBeClassified;
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