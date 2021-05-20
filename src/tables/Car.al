table 52001 "CR Car"
{
    Caption = 'Car';
    DataClassification = ToBeClassified;
    LookupPageId = "CR Car List";

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;


            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CarBookingSetup.Get();

                    NoSeriesMgt.TestManual(CarBookingSetup."Car Nos.");

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

            trigger OnValidate()
            var
                CarType: Record "CR Car Type";
            begin
                if "Car Type Code" <> xRec."Car Type Code" then
                    if "Car Type Code" <> '' then begin
                        CarType.GET("Car Type Code");
                        "Daily Rate" := CarType."Daily Rate";
                        Doors := CarType.Doors;
                        Passengers := CarType.Passengers;
                        Baggage := CarType.Baggage;
                    end
                    else begin
                        Validate("Daily Rate", 0);
                        Validate("Doors", 0);
                        Validate("Passengers", 0);
                        Validate("Baggage", 0);
                    end;
            end;
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
        field(120; Transmission; Enum "CR Transmission Types")
        {
            Caption = 'Transmission';
            DataClassification = ToBeClassified;
        }
        field(130; "Fuel Type"; Enum "CR Fuel Types")
        {
            Caption = 'Fuel Type';
            DataClassification = ToBeClassified;
        }
        field(140; Mileage; Integer)
        {
            Caption = 'Mileage';
            DataClassification = ToBeClassified;
        }
        field(160; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";

        }

        field(170; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor";
        }

        field(180; "Total Revenue"; Decimal)
        {
            Caption = 'Total Revenue';
            FieldClass = FlowField;
            CalcFormula = Sum("CR Reservation Ledger Entry".Amount where("Car No." = field("No."), "Start Date" = field("From Date")));
        }
        field(190; "From Date"; Date)
        {
            Caption = 'From Date';
            FieldClass = FlowFilter;
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
        CarBookingSetup: Record "CR Car Booking Setup";
        NoSeriesMgt: CodeUnit NoSeriesManagement;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            CarBookingSetup.Get();

            CarBookingSetup.TestField("Car Nos.");

            NoSeriesMgt.InitSeries(CarBookingSetup."Car Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

    end;

    procedure AssistEdit(Rec: Record "CR Car"): boolean
    var
        Car: Record "CR Car";
    begin

        Car := Rec;

        CarBookingSetup.Get();

        CarBookingSetup.TestField("Car Nos.");

        if NoSeriesMgt.SelectSeries(CarBookingSetup."Car Nos.", xRec."No. Series", Car."No. Series") then begin
            NoSeriesMgt.SetSeries(Car."No.");
            Rec := Car;

            exit(true);
        end;
    end;

}