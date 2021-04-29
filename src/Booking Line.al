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
        field(30; "Car Type Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Car Type Code';
            TableRelation = "CR Car Type";

            trigger OnValidate()
            begin

                if "Car Type Code" <> xRec."Car Type Code" then begin
                    "Car No." := '';
                    "Daily Rate" := 0;
                    "Car Name" := '';
                    "Brand Code" := '';
                    "Model Code" := '';
                    "Year" := 0;
                    "Doors" := 0;
                    "Passengers" := 0;
                    "Baggage" := 0;
                    "Mileage" := 0;
                end;



            end;
        }
        field(40; "Car No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Car No.';
            TableRelation = "CR Car" where("Car Type Code" = field("Car Type Code"));

            trigger OnValidate()
            begin
                if "Car No." <> xRec."Car No." then
                    if "Car No." <> '' then begin

                        CheckAvailability();

                        Car.GET("Car No.");

                        Car.CalcFields(Year);

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

            trigger OnValidate()
            begin
                if "Daily Rate" <> xRec."Daily Rate" then begin
                    CalculateAmount();
                end;
            end;
        }
        field(60; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                if "Start Date" <> xRec."Start Date" then begin
                    CheckAvailability();
                    ValidateDateFields();
                    CalculateAmount();
                end;
            end;
        }
        field(70; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';

            trigger OnValidate()
            begin
                if "End Date" <> xRec."End Date" then begin
                    CheckAvailability();
                    ValidateDateFields();
                    CalculateAmount();
                end;
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
            DataClassification = ToBeClassified;
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
        field(180; "No. of Days"; Integer)
        {
            Caption = 'No. of Days';
            Editable = false;
        }
        field(190; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            Editable = false;
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
        BookingLine: Record "CR Booking Line";
        BookingHeader: Record "CR Booking Header";


    procedure ValidateDateFields()
    var
        PastDateErr: label 'Bookings can be made only for future dates.';
        DateRangeErr: label 'End date has to be greater than start date';

    begin
        if ("Start Date" <> 0D) AND ("Start Date" <= TODAY) then
            Error(PastDateErr);

        if ("End Date" <> 0D) AND ("End Date" <= TODAY) then
            Error(PastDateErr);

        if ("Start Date" <> 0D) AND ("End Date" <> 0D) AND ("End Date" <= "Start Date") then
            Error(DateRangeErr);
    end;

    procedure CalculateAmount()
    begin

        if ("Start Date" <> 0D) AND ("End Date" <> 0D) then begin
            "No. of Days" := "End Date" - "Start Date";
            "Amount" := "Daily Rate" * "No. of Days";
        end;
    end;

    procedure CheckAvailability()
    var
        AlreadyBookedErr: label 'The selected car has already been booked for the period';
    begin

        if ("Car No." <> '') AND ("Start Date" <> 0D) AND ("End Date" <> 0D) then begin
            BookingHeader.SetFilter("Booking Status", '%1|%2', BookingHeader."Booking Status"::Reservation, BookingHeader."Booking Status"::Open);
            BookingHeader.SetFilter("No.", '<>%1', "Document No.");

            if BookingHeader.FindSet() then
                repeat

                    //Bookings for same Car with Start Date between current Start Date and End Date
                    BookingLine.Reset();
                    BookingLine.SetRange("Document No.", BookingHeader."No.");
                    BookingLine.SetRange("Car No.", "Car No.");
                    BookingLine.SetRange("Start Date", "Start Date", "End Date");
                    if not BookingLine.IsEmpty() then
                        Error(AlreadyBookedErr);

                    //Bookings for same Car with End Date between current Start Date and End Date
                    BookingLine.Reset();
                    BookingLine.SetRange("Document No.", BookingHeader."No.");
                    BookingLine.SetRange("Car No.", "Car No.");
                    BookingLine.SetRange("End Date", "Start Date", "End Date");
                    if not BookingLine.IsEmpty() then
                        Error(AlreadyBookedErr);

                    //Bookings for same Car with Start Date before current Start Date and End Date after current End Date
                    BookingLine.Reset();
                    BookingLine.SetRange("Document No.", BookingHeader."No.");
                    BookingLine.SetRange("Car No.", "Car No.");
                    BookingLine.SetFilter("Start Date", '<%1', "Start Date");
                    BookingLine.SetFilter("End Date", '>%1', "End Date");

                    if not BookingLine.IsEmpty() then
                        Error(AlreadyBookedErr);

                until BookingHeader.Next() = 0;
        end;

    end;

}