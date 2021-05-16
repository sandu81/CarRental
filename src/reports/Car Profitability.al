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
            RequestFilterFields = "No.", "From Date";
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
            column(Filters; Filters)
            {

            }
        }
    }

    trigger OnPreReport()
    begin
        Filters := Car.GetFilters();
    end;

    var
        ReportTitle_CaptionLbl: Label 'Car Profitability Report';
        Filters: Text;


}