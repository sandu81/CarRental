report 52000 "CR Car Profitability"
{
    Caption = 'Car Profitability Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'CarProfitability.rdl';



    dataset
    {
        dataitem(Car; "CR Car")
        {
            column(Car_No; "No.")
            {
            }
            column(Name; "Name")
            {

            }
            column(Total_Revenue; "Total Revenue")
            {

            }
            column(Car_No_Caption; FieldCaption("No."))
            {

            }
            column(Name_Caption; FieldCaption("Name"))
            {

            }
            column(Total_Revenue_Caption; FieldCaption("Total Revenue"))
            {

            }
            column(ReportTitle_CaptionLbl; ReportTitle_CaptionLbl)
            {

            }
            column(StartDate; StartDAte)
            {

            }
            column(EndDate; EndDate)
            {

            }
            trigger OnPreDataItem()
            var
                ReservationLedgerEntry: Record "CR Reservation Ledger Entry";
                CarList: Record "CR Car";
                BookedCarFilter: Text;
            begin


                IF CarList.FindSet() then begin
                    repeat
                        ReservationLedgerEntry.Reset();
                        ReservationLedgerEntry.SetRange("Car No.", CarList."No.");
                        ReservationLedgerEntry.SetRange("Start Date", StartDate, EndDate);


                        if not ReservationLedgerEntry.IsEmpty() then
                            BookedCarFilter += '=' + CarList."No." + '|';
                    until CarList.Next() = 0;
                end;

                if BookedCarFilter <> '' then begin
                    BookedCarFilter := DelStr(BookedCarFilter, StrLen(BookedCarFilter), 1);
                    SetFilter(Car."No.", BookedCarFilter);

                end;


            end;

        }


    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        ReportTitle_CaptionLbl: Label 'Car Profitability Report';
        StartDate: Date;
        EndDate: Date;

}