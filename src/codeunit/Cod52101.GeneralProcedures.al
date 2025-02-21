codeunit 52101 "H2O General Procedures"
{
    procedure InsertRecordInTimeKeepingTable(var Rec: Record "Sales Line")
    var
        TimeKeepingRec: Record "H2O Time Keeping Table";
    begin
        if (Rec.Type <> Rec.Type::Resource) or (Rec."Resource Type" <> Rec."Resource Type"::Person) then
            exit;
        TimeKeepingRec.Init();
        TimeKeepingRec."Document Type" := Rec."Document Type";
        TimeKeepingRec."Document No." := Rec."Document No.";
        TimeKeepingRec."Line No." := Rec."Line No.";
        TimeKeepingRec.Insert();
        TimeKeepingRec."Sell-to Customer No." := Rec."Sell-to Customer No.";
        TimeKeepingRec.Type := Rec.Type;
        TimeKeepingRec."No." := Rec."No.";
        TimeKeepingRec.Description := Rec.Description;
        TimeKeepingRec.Quantity := Rec.Quantity;
        TimeKeepingRec."Unit Price" := Rec."Unit Price";
        TimeKeepingRec."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
        TimeKeepingRec."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        TimeKeepingRec."Unit of Measure Code" := Rec."Unit of Measure Code";
        TimeKeepingRec."Start Date" := Rec."Start Date";
        TimeKeepingRec."Start Time" := Rec."Start Time";
        TimeKeepingRec."End Date" := Rec."End Date";
        TimeKeepingRec."End Time" := Rec."End Time";
        TimeKeepingRec."Original Document No." := Rec."Document No.";
        TimeKeepingRec."Original Line No." := Rec."Line No.";
        TimeKeepingRec."Original Ship-to Code" := Rec."Original Ship-to Code";
        TimeKeepingRec."Time Worked" := Rec."H2O Time Worked";
        TimeKeepingRec.Modify();
    end;

    procedure ModifyRecordInTimeKeepingTable(var Rec: Record "Sales Line")
    var
        TimeKeepingRec: Record "H2O Time Keeping Table";
    begin
        if TimeKeepingRec.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
            if TimeKeepingRec."Sell-to Customer No." = '' then
                TimeKeepingRec."Sell-to Customer No." := Rec."Sell-to Customer No.";
            if TimeKeepingRec.Type = TimeKeepingRec.Type::" " then
                TimeKeepingRec.Type := Rec.Type;
            if TimeKeepingRec."No." = '' then
                TimeKeepingRec."No." := Rec."No.";
            if TimeKeepingRec.Description = '' then
                TimeKeepingRec.Description := Rec.Description;
            if TimeKeepingRec.Quantity = 0 then
                TimeKeepingRec.Quantity := Rec.Quantity;
            if TimeKeepingRec."Unit Price" = 0 then
                TimeKeepingRec."Unit Price" := Rec."Unit Price";
            if TimeKeepingRec."Shortcut Dimension 1 Code" = '' then
                TimeKeepingRec."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
            if TimeKeepingRec."Shortcut Dimension 2 Code" = '' then
                TimeKeepingRec."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
            if TimeKeepingRec."Unit of Measure Code" = '' then
                TimeKeepingRec."Unit of Measure Code" := Rec."Unit of Measure Code";
            if TimeKeepingRec."Start Date" = 0D then
                TimeKeepingRec."Start Date" := Rec."Start Date";
            if TimeKeepingRec."Start Time" = 0T then
                TimeKeepingRec."Start Time" := Rec."Start Time";
            if TimeKeepingRec."End Date" = 0D then
                TimeKeepingRec."End Date" := Rec."End Date";
            if TimeKeepingRec."End Time" = 0T then
                TimeKeepingRec."End Time" := Rec."End Time";
            if TimeKeepingRec."Original Document No." = '' then
                TimeKeepingRec."Original Document No." := Rec."Document No.";
            if TimeKeepingRec."Original Line No." = 0 then
                TimeKeepingRec."Original Line No." := Rec."Line No.";
            if TimeKeepingRec."Original Ship-to Code" = '' then
                TimeKeepingRec."Original Ship-to Code" := Rec."Original Ship-to Code";
            if TimeKeepingRec."Time Worked" = 0 then
                TimeKeepingRec."Time Worked" := Rec."H2O Time Worked";

            TimeKeepingRec.Modify();
        end;
    end;
}
