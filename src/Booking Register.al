table 52011 "CR Booking Register"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10;"No."; Integer)
        {
            DataClassification = ToBeClassified;
            
        }
        
    }
    
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}