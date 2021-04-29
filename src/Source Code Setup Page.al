pageextension 52000 "Source Code Setup Extension" extends "Source Code Setup"
{
    layout
    {
        addafter(General)
        {
            group("Booking Management")
            {
                field("Booking"; "Booking")
                {
                    ApplicationArea = All;
                }
            }
        }



    }


}