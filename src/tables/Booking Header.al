
table 52007 "CR Booking Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Booking Header';

    fields
    {
        field(10; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin

                    CarBookingSetup.Get();

                    NoSeriesMgt.TestManual(CarBookingSetup."Booking Nos.");

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

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GuiAllowed);
            end;
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

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GuiAllowed);

            end;
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

            trigger OnValidate()
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
                    CarBookingSetup.Get();

                    CarBookingSetup.TestField("Booking Nos.");
                    CarBookingSetup.TestField("Posted Booking Nos.");

                    NoSeriesMgt.TestSeries(CarBookingSetup."Posted Booking Nos.", "Posting No. Series");

                end;

                TestField("Posting No.", '');


            end;

            trigger OnLookup()
            begin
                BookingHeader := Rec;

                CarBookingSetup.Get();

                CarBookingSetup.TestField("Booking Nos.");
                CarBookingSetup.TestField("Posted Booking Nos.");

                if NoSeriesMgt.LookupSeries(CarBookingSetup."Posted Booking Nos.", BookingHeader."Posting No. Series") then begin

                    Validate("Posting No. Series");
                end;

                Rec := BookingHeader;



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
            CarBookingSetup.Get();

            CarBookingSetup.TestField("Booking Nos.");

            NoSeriesMgt.InitSeries(CarBookingSetup."Booking Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        InitRecord();

    end;

    trigger OnDelete()
    begin
        TestField("Booking Status", "Booking Status"::Cancelled);

        BookingLine.Reset();

        BookingLine.SetRange("Document No.", "No.");

        BookingLine.DeleteAll(true);


    end;

    procedure InitRecord()
    begin

        if "Posting Date" = 0D then
            "Posting Date" := WorkDate();

        "Document Date" := WorkDate();

        CarBookingSetup.Get();
        NoSeriesMgt.SetDefaultSeries("Posting No. Series", CarBookingSetup."Posted Booking Nos.");

    end;

    procedure AssistEdit(): boolean
    begin

        BookingHeader := Rec;

        CarBookingSetup.Get();

        CarBookingSetup.TestField("Booking Nos.");

        if NoSeriesMgt.SelectSeries(CarBookingSetup."Booking Nos.", xRec."No. Series", BookingHeader."No. Series") then begin
            NoSeriesMgt.SetSeries(BookingHeader."No.");
            Rec := BookingHeader;

            exit(true);
        end;



    end;



    var
        i: Integer;
        MailManagement: CodeUnit "Mail Management";
        PhoneNoCannotContainLettersErr: Label '';
        CarBookingSetup: Record "CR Car Booking Setup";
        NoSeriesMgt: CodeUnit NoSeriesManagement;
        BookingLine: Record "CR Booking Line";
        Customer: Record "Customer";
        PostCode: Record "Post Code";
        BookingHeader: Record "CR Booking Header";

}


