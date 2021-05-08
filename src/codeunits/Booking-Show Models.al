codeunit 52008 "CR Booking-Show Models"
{
    TableNo = "CR Brand";

    trigger OnRun()
    begin
        CarModel.SetRange("Brand Code", "Code");

        Page.Run(Page::"CR Models", CarModel);
    end;

    var
        CarModel: Record "CR Model";
}