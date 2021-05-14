codeunit 52008 "CR Booking-Show Models"
{
    TableNo = "CR Brand";

    trigger OnRun()
    var
        CarModel: Record "CR Model";
    begin
        CarModel.SetRange("Brand Code", "Code");

        Page.Run(Page::"CR Models", CarModel);
    end;


}