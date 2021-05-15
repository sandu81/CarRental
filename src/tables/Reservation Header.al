
table 52007 "CR Reservation Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Reservation Header';

    fields
    {
        field(10; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin

                    CarRentalSetup.Get();

                    NoSeriesMgt.TestManual(CarRentalSetup."Booking Nos.");

                    "No. Series" := '';
                end;

            end;
        }
        field(20; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer No.';
            TableRelation = "Customer";

            trigger OnValidate()
            var
                Customer: Record "Customer";
            begin

                if ("Customer No." <> xRec."Customer No.") then begin
                    Customer.Get("Customer No.");

                    "Customer Name" := Customer.Name;
                    "Address" := Customer.Address;
                    "Address 2" := Customer."Address 2";
                    "City" := Customer.City;
                    "Post Code" := Customer."Post Code";
                    "County" := Customer.County;
                    "Country/Region Code" := Customer."Country/Region Code";
                    "Phone No." := Customer."Phone No.";
                    "E-Mail" := Customer."E-Mail";
                end;
            end;
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
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GuiAllowed);
            end;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;
        }
        field(55; County; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'State';


        }
        field(60; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code" ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GuiAllowed);

            end;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;
        }
        field(65; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");
            end;
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

            trigger OnValidate()
            var
                MailManagement: CodeUnit "Mail Management";
            begin
                if "E-Mail" = '' then
                    exit;

                MailManagement.CheckValidEmailAddresses("E-Mail");
            end;
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
            CalcFormula = Sum("CR Reservation Line".Amount where("Document No." = field("No.")));
            Editable = false;
        }
        field(130; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
            Caption = 'No. Series';

        }
        field(140; "Posting No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Caption = 'Posting No. Series';

            trigger OnValidate()
            begin

                if "Posting No. Series" <> '' then begin
                    CarRentalSetup.Get();

                    CarRentalSetup.TestField("Booking Nos.");
                    CarRentalSetup.TestField("Posted Booking Nos.");

                    NoSeriesMgt.TestSeries(CarRentalSetup."Posted Booking Nos.", "Posting No. Series");

                end;

                TestField("Posting No.", '');


            end;

            trigger OnLookup()
            begin
                ReservationHeader := Rec;

                CarRentalSetup.Get();

                CarRentalSetup.TestField("Booking Nos.");
                CarRentalSetup.TestField("Posted Booking Nos.");

                if NoSeriesMgt.LookupSeries(CarRentalSetup."Posted Booking Nos.", ReservationHeader."Posting No. Series") then begin

                    Validate("Posting No. Series");
                end;

                Rec := ReservationHeader;



            end;
        }
        field(150; "Posting No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting No.';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin

        if "No." = '' then begin
            CarRentalSetup.Get();

            CarRentalSetup.TestField("Booking Nos.");

            NoSeriesMgt.InitSeries(CarRentalSetup."Booking Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        InitRecord();

    end;

    trigger OnDelete()
    var
        ReservationLine: Record "CR Reservation Line";
    begin

        ReservationLine.Reset();

        ReservationLine.SetRange("Document No.", "No.");

        ReservationLine.DeleteAll(true);


    end;

    procedure InitRecord()
    begin

        if "Posting Date" = 0D then
            "Posting Date" := WorkDate();

        "Document Date" := WorkDate();

        CarRentalSetup.Get();
        NoSeriesMgt.SetDefaultSeries("Posting No. Series", CarRentalSetup."Posted Booking Nos.");

    end;

    procedure AssistEdit(): boolean
    begin

        ReservationHeader := Rec;

        CarRentalSetup.Get();

        CarRentalSetup.TestField("Booking Nos.");

        if NoSeriesMgt.SelectSeries(CarRentalSetup."Booking Nos.", xRec."No. Series", ReservationHeader."No. Series") then begin
            NoSeriesMgt.SetSeries(ReservationHeader."No.");
            Rec := ReservationHeader;

            exit(true);
        end;



    end;



    var
        CarRentalSetup: Record "CR Car Booking Setup";
        PostCode: Record "Post Code";
        ReservationHeader: Record "CR Reservation Header";
        NoSeriesMgt: CodeUnit NoSeriesManagement;

}


