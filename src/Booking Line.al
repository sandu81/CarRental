table 52008 "CR Booking Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Booking Line';

    fields
    {
        field(10; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';
            TableRelation = "CR Booking Header";
        }
        field(20; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }
        field(30; "Car Type No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Car Type No.';
            TableRelation = "CR Car Type";
        }
        field(40; "Car No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Car No.';
            TableRelation = "CR Car";

            trigger OnValidate()
            begin
                if "Car No." <> xRec."Car No." then
                    if "Car No." <> '' then begin
                        Car.GET("Car No.");
                        "Daily Rate" := Car."Daily Rate";
                        "Car Name" := Car."Name";
                        "Brand Code" := Car."Brand Code";
                        "Model Code" := Car."Model Code";
                        "Year" := Car.Year;
                        "Doors" := Car.Doors;
                        "Passengers" := Car.Passengers;
                        "Baggage" := Car.Baggage;
                        "Transmission" := Car.Transmission;
                        "Fuel Type" := Car."Fuel Type";
                        "Mileage" := Car.Mileage;
                    end
            end;
        }
        field(50; "Daily Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Daily Rate';
        }
        field(60; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';

            trigger OnValidate()
            begin

                //Throw an error is start date is less than or equal to current date
            end;
        }
        field(70; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';

            trigger OnValidate()
            begin

                //Throw an error is end date is less than or equal to start date
            end;
        }
        field(80; "Car Name"; Text[100])
        {
            Caption = 'Car Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(90; "Brand Code"; Code[10])
        {
            Caption = 'Brand Code';
            TableRelation = "CR Brand";
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(100; "Model Code"; Code[10])
        {
            Caption = 'Model Code';
            TableRelation = "CR Model" where("Brand Code" = field("Brand Code"));
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(110; Year; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("CR Model".Year where("Code" = field("Model Code")));
            Caption = 'Year';
            Editable = false;
        }
        field(120; Doors; Integer)
        {
            Caption = 'Doors';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(130; Passengers; Integer)
        {
            Caption = 'Passengers';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(140; Baggage; Integer)
        {
            Caption = 'Baggage';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(150; Transmission; Option)
        {
            Caption = 'Transmission';
            OptionMembers = "Automatic","Manual";
            OptionCaption = 'Automatic,Manual';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(160; "Fuel Type"; Option)
        {
            Caption = 'Fuel Type';
            OptionMembers = "Petrol","Diesel","Hybrid","Electric";
            OptionCaption = 'Petrol,Diesel,Hybrid,Electric';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(170; Mileage; Integer)
        {
            Caption = 'Mileage';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(180; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        Car: Record "CR Car";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}