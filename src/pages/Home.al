page 52030 "CR Home"
{
    PageType = RoleCenter;
    Caption = 'Car Rental Home';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {

    }

    actions
    {
        area(Sections)
        {
            group(Reservations)
            {
                Caption = 'Reservations';
                Image = Receivables;

                action(Tentative)
                {
                    Caption = 'Tentative';
                    RunObject = Page "CR Reservation List";
                }
                action(Confirmed)
                {
                    Caption = 'Confirmed';
                    RunObject = Page "CR Posted Reservation List";
                }
                action(Cancelled)
                {
                    Caption = 'Cancelled';
                    RunObject = Page "CR Cancelled Reservation List";
                }
            }
            group(Settings)
            {
                Caption = 'Settings';
                Image = Administration;
                action("Cars")
                {
                    Caption = 'Cars';
                    RunObject = Page "CR Car List";
                    ApplicationArea = All;
                }

                action(CarType)
                {
                    Caption = 'Car Types';
                    RunObject = Page "CR Car Types";
                    ApplicationArea = All;
                }
                action(Brands)
                {
                    Caption = 'Brands';
                    RunObject = Page "CR Brands";
                    ApplicationArea = All;
                }
            }
            group(PostedDocuments)
            {
                Caption = 'Posted Documents';

                action(Regisers)
                {
                    Caption = 'Registers';
                    RunObject = Page "CR Reservation Registers";
                    ApplicationArea = All;
                }
                action(Ledgers)
                {
                    Caption = 'Ledger Entries';
                    RunObject = Page "CR Reservation Ledger Entries";
                    ApplicationArea = All;
                }
            }


        }

        area(Creation)
        {
            action("New Reservation")
            {
                Caption = 'New';
                RunObject = Page "CR Avilable Car List";
            }
        }

        area(Reporting)
        {
            action(Profitability)
            {
                Caption = 'Profitability';
                RunObject = Report "CR Car Profitability";
            }
        }
    }


}

// Creates a profile that uses the Role Center
profile CarRentalSalesPerson
{
    Description = 'Car Rental Sales Person';

    RoleCenter = "CR Home";
}