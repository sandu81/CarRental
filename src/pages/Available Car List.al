page 52020 "CR Avilable Car List"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CR Car";
    Caption = 'Cars';

    layout
    {
        area(Content)
        {
            field("Car Types"; CarType)
            {
                ApplicationArea = All;
                TableRelation = "CR Car Type".Code;
                trigger OnValidate()
                begin
                    FilterList();
                end;
            }

            field("From Date"; FromDate)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    FilterList();
                end;
            }
            field("To Date"; ToDate)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    FilterList();
                end;
            }

            repeater(cars)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Car Type"; "Car Type Code")
                {
                    ApplicationArea = All;
                }
                field("Brand Code"; "Brand Code")
                {
                    ApplicationArea = All;
                }
                field("Model Code"; "Model Code")
                {
                    ApplicationArea = All;
                }
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; "Daily Rate")
                {
                    ApplicationArea = All;
                }
                field(Doors; Doors)
                {
                    ApplicationArea = All;
                }
                field(Passengers; Passengers)
                {
                    ApplicationArea = All;
                }
                field(Baggage; Baggage)
                {
                    ApplicationArea = All;
                }
                field(Transmission; Transmission)
                {
                    ApplicationArea = All;
                }
                field("Fuel Type"; "Fuel Type")
                {
                    ApplicationArea = All;
                }
                field(Mileage; Mileage)
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Book)
            {
                ApplicationArea = All;
                Caption = 'Book';
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit "CR New Reservation";

                trigger OnAction()
                var
                    NewReservation: Codeunit "CR New Reservation";
                    CarBlockedlbl: Label 'This car is currently unavailable for reservation.';
                begin

                    if Rec.Blocked = true then
                        Error(CarBlockedlbl);

                    NewReservation.Init(Rec, FromDate, ToDate);

                end;
            }
        }
    }

    procedure FilterList()
    var
        CarFilter: Codeunit "CR Available Cars-Filter";
    begin
        Rec.Reset();
        if (FromDate <> 0D) AND (ToDate <> 0D) then begin
            CarFilter.CarListFilter(Rec, FromDate, ToDate);
        end;

        Rec.SetFilter("Car Type Code", CarType);
        currpage.Update();

    end;




    var
        CarType: Code[10];
        FromDate: Date;
        ToDate: Date;



}