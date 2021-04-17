table 52001 "CR Car"
{
    Caption = 'Car';
    DataClassification = ToBeClassified;
    LookupPageId = "CR Car Card";

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CarSetup.Get();

                    NoSeriesMgt.TestManual(CarSetup."Car Nos.");

                    "No. Series" := '';
                end;
            end;
        }
        field(20; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(30; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(40; "Car Type Code"; Code[10])
        {
            Caption = 'Car Type Code';
            TableRelation = "CR Car Type";
            DataClassification = ToBeClassified;
        }
        field(50; "Brand Code"; Code[10])
        {
            Caption = 'Brand Code';
            TableRelation = "CR Brand";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Brand Code" <> xRec."Brand Code" then
                    Validate("Model Code", '');
            end;
        }
        field(60; "Model Code"; Code[10])
        {
            Caption = 'Model Code';
            TableRelation = "CR Model" where("Brand Code" = field("Brand Code"));
            DataClassification = ToBeClassified;
        }
        field(70; Year; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CR Model".Year where("Code" = field("Model Code")));
            Caption = 'Year';
        }
        field(80; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            DataClassification = ToBeClassified;
            AutoFormatType = 1;
        }
        field(90; Doors; Integer)
        {
            Caption = 'Doors';
            DataClassification = ToBeClassified;
        }
        field(100; Passengers; Integer)
        {
            Caption = 'Passengers';
            DataClassification = ToBeClassified;
        }
        field(110; Baggage; Integer)
        {
            Caption = 'Baggage';
            DataClassification = ToBeClassified;
        }
        field(120; Transmission; Option)
        {
            Caption = 'Transmission';
            OptionMembers = "Automatic","Manual";
            OptionCaption = 'Automatic,Manual';
            DataClassification = ToBeClassified;
        }
        field(130; "Fuel Type"; Option)
        {
            Caption = 'Fuel Type';
            OptionMembers = "Petrol","Diesel","Hybrid","Electric";
            OptionCaption = 'Petrol,Diesel,Hybrid,Electric';
            DataClassification = ToBeClassified;
        }
        field(140; Mileage; Integer)
        {
            Caption = 'Mileage';
            DataClassification = ToBeClassified;
        }
        field(150; Revenue; Decimal)
        {
            Caption = 'Revenue';
            DataClassification = ToBeClassified;
        }
        field(160; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";

        }


    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        CarSetup: Record "CR Car Setup";

    var
        Car: Record "CR Car";

    var
        NoSeriesMgt: CodeUnit NoSeriesManagement;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            CarSetup.Get();

            CarSetup.TestField("Car Nos.");

            NoSeriesMgt.InitSeries(CarSetup."Car Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

    end;

    procedure AssistEdit(): boolean
    begin

        Car := Rec;

        CarSetup.Get();

        CarSetup.TestField("Car Nos.");

        if NoSeriesMgt.SelectSeries(CarSetup."Car Nos.", xRec."No. Series", Car."No. Series") then begin
            NoSeriesMgt.SetSeries(Car."No.");
            Rec := Car;

            exit(true);
        end;



    end;

}