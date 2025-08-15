codeunit 52101 "H2O General Functions"
{
    procedure InsertRecordInTimeKeepingTable(var Rec: Record "Sales Line")
    var
        TimeKeepingRec: Record "H2O Time Keeping Table";
        InsertTimeKeepingRecord: Boolean;
        LastEntryNumber: Text[20];
        LastNo: Integer;
        CurrentYear: Text[4];
        NewNo: Integer;
        NewEntryNumber: Text[20];
        NextEntryNo: Integer;
    begin
        // TimeKeepingRec.Reset();
        // TimeKeepingRec.SetCurrentKey("Entry No.");
        // if TimeKeepingRec.FindLast() then
        //     NextEntryNo := TimeKeepingRec."Entry No." + 1
        // else
        //     NextEntryNo := 1;
        CurrentYear := Format(Date2DMY(TODAY, 3));
        InsertTimeKeepingRecord := false;
        if (Rec.Type = Rec.Type::Resource) and (Rec."Resource Type" = Rec."Resource Type"::Person) then
            InsertTimeKeepingRecord := true;

        if InsertTimeKeepingRecord then begin

            TimeKeepingRec.SetFilter("Entry Number", Format(CurrentYear) + '*');
            if TimeKeepingRec.FindLast() then begin
                LastEntryNumber := TimeKeepingRec."Entry Number";
                if not EVALUATE(LastNo, CopyStr(LastEntryNumber, 5)) then
                    LastNo := 0;
            end else
                LastNo := 0;

            NewNo := LastNo + 1;
            NewEntryNumber := Format(CurrentYear) + Format(NewNo);

            TimeKeepingRec.Init();
            //TimeKeepingRec.Validate("Entry No.", NextEntryNo);
            // TimeKeepingRec.Insert(true);

            TimeKeepingRec.Validate("Document Type", Rec."Document Type");
            TimeKeepingRec.Validate("Document No.", Rec."Document No.");
            TimeKeepingRec.Validate("Line No.", Rec."Line No.");
            TimeKeepingRec.Validate("Sell-to Customer No.", Rec."Bill-to Customer No.");
            TimeKeepingRec.Validate(Type, Rec.Type);
            TimeKeepingRec.Validate("No.", Rec."No.");
            TimeKeepingRec.Validate(Description, Rec.Description);
            TimeKeepingRec.Validate(Quantity, Rec.Quantity);
            TimeKeepingRec.Validate("Unit Price", Rec."Unit Price");
            TimeKeepingRec.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
            TimeKeepingRec.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
            TimeKeepingRec.Validate("Unit of Measure Code", Rec."Unit of Measure Code");
            TimeKeepingRec.Validate("Start Date", Rec."Start Date");
            TimeKeepingRec.Validate("Start Time", Rec."Start Time");
            TimeKeepingRec.Validate("End Date", Rec."End Date");
            TimeKeepingRec.Validate("End Time", Rec."End Time");
            TimeKeepingRec.Validate("Original Document No.", Rec."Document No.");
            TimeKeepingRec.Validate("Original Line No.", Rec."Line No.");
            TimeKeepingRec.Validate("Original Ship-to Code", Rec."Original Ship-to Code");
            TimeKeepingRec.Validate("Time Worked", Rec."H2O Time Worked");
            TimeKeepingRec.Validate("Entry Number", NewEntryNumber);
            // TimeKeepingRec.Modify();
            TimeKeepingRec.Insert(true);
        end;
    end;

    procedure ModifyRecordInTimeKeepingTable(var Rec: Record "Sales Line")
    var
        TimeKeepingRec: Record "H2O Time Keeping Table";
    begin
        TimeKeepingRec.SetRange("Document Type", Rec."Document Type");
        TimeKeepingRec.SetRange("Document No.", Rec."Document No.");
        TimeKeepingRec.SetRange("Line No.", Rec."Line No.");

        if TimeKeepingRec.FindFirst() then begin
            if TimeKeepingRec."Sell-to Customer No." = '' then
                TimeKeepingRec.Validate("Sell-to Customer No.", Rec."Bill-to Customer No.");
            if TimeKeepingRec.Type = TimeKeepingRec.Type::" " then
                TimeKeepingRec.Validate(Type, Rec.Type);
            if TimeKeepingRec."No." = '' then
                TimeKeepingRec.Validate("No.", Rec."No.");
            if TimeKeepingRec.Description = '' then
                TimeKeepingRec.Validate(Description, Rec.Description);
            if TimeKeepingRec.Quantity = 0 then
                TimeKeepingRec.Validate(Quantity, Rec.Quantity);
            if TimeKeepingRec."Unit Price" = 0 then
                TimeKeepingRec.Validate("Unit Price", Rec."Unit Price");
            if TimeKeepingRec."Shortcut Dimension 1 Code" = '' then
                TimeKeepingRec.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
            if TimeKeepingRec."Shortcut Dimension 2 Code" = '' then
                TimeKeepingRec.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
            if TimeKeepingRec."Unit of Measure Code" = '' then
                TimeKeepingRec.Validate("Unit of Measure Code", Rec."Unit of Measure Code");
            if TimeKeepingRec."Start Date" = 0D then
                TimeKeepingRec.Validate("Start Date", Rec."Start Date");
            if TimeKeepingRec."Start Time" = 0T then
                TimeKeepingRec.Validate("Start Time", Rec."Start Time");
            if TimeKeepingRec."End Date" = 0D then
                TimeKeepingRec.Validate("End Date", Rec."End Date");
            if TimeKeepingRec."End Time" = 0T then
                TimeKeepingRec.Validate("End Time", Rec."End Time");
            if TimeKeepingRec."Original Document No." = '' then
                TimeKeepingRec.Validate("Original Document No.", Rec."Document No.");
            if TimeKeepingRec."Original Line No." = 0 then
                TimeKeepingRec.Validate("Original Line No.", Rec."Line No.");
            if TimeKeepingRec."Original Ship-to Code" = '' then
                TimeKeepingRec.Validate("Original Ship-to Code", Rec."Original Ship-to Code");
            if TimeKeepingRec."Time Worked" = 0 then
                TimeKeepingRec.Validate("Time Worked", Rec."H2O Time Worked");

            TimeKeepingRec.Modify();
        end;
    end;
}
