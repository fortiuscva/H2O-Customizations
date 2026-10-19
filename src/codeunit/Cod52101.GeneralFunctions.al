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
        //CurrentYear := Format(Date2DMY(TODAY, 3));
        InsertTimeKeepingRecord := false;
        if (Rec.Type = Rec.Type::Resource) and (Rec."Resource Type" = Rec."Resource Type"::Person) then
            InsertTimeKeepingRecord := true;

        if InsertTimeKeepingRecord then begin

            // TimeKeepingRec.SetFilter("Entry Number", Format(CurrentYear) + '*');
            // if TimeKeepingRec.FindLast() then begin
            //     LastEntryNumber := TimeKeepingRec."Entry Number";
            //     if not EVALUATE(LastNo, CopyStr(LastEntryNumber, 5)) then
            //         LastNo := 0;
            // end else
            //     LastNo := 0;

            // NewNo := LastNo + 1;
            // NewEntryNumber := Format(CurrentYear) + Format(NewNo);

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
            // TimeKeepingRec.Validate("Entry Number", NewEntryNumber);
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

    procedure GetPurchaseOrder(var WorkOrder: Record "Sales Header")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Vendor: Record Vendor;
        WorkOrderLine: Record "Sales Line";
        LineNo: Integer;
        ImportedLines: Integer;
        SkippedLines: Integer;
    begin
        // Validate Purchase Order No.
        WorkOrder.TestField("H2O Purchase Order No.");

        // Get Purchase Order Header
        if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, WorkOrder."H2O Purchase Order No.")
        then
            Error('Purchase Order %1 does not exist.', WorkOrder."H2O Purchase Order No.");

        // Get Vendor
        // if PurchaseHeader."Buy-from Vendor No." <> '' then begin
        //     if Vendor.Get(PurchaseHeader."Buy-from Vendor No.") then begin
        //         WorkOrder.Validate(
        //             "Vendor No.",
        //             PurchaseHeader."Buy-from Vendor No.");

        //         WorkOrder.Validate(
        //             "Vendor Name",
        //             Vendor.Name);
        //     end;
        // end;

        // Save Work Order Header
        // WorkOrder.Modify(true);

        // Get Purchase Order Lines
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");

        if not PurchaseLine.FindSet() then
            Error('Purchase Order %1 does not contain any lines.', PurchaseHeader."No.");

        // Find last existing Work Order Line
        WorkOrderLine.Reset();
        WorkOrderLine.SetRange("Document No.", WorkOrder."No.");

        if WorkOrderLine.FindLast() then
            LineNo := WorkOrderLine."Line No." + 10000
        else
            LineNo := 10000;

        repeat
            WorkOrderLine.Reset();
            WorkOrderLine.SetRange("Document Type", WorkOrder."Document Type");
            WorkOrderLine.SetRange("Document No.", WorkOrder."No.");
            WorkOrderLine.SetRange("Purch. Order Line No.", PurchaseLine."Line No.");

            if WorkOrderLine.FindFirst() then begin
                SkippedLines += 1;
            end
            else begin
                if PurchaseLine."No." = '' then
                    Error('Purchase Order %1, Line %2 must have an Item No.',
                        PurchaseLine."Document No.",
                        PurchaseLine."Line No.");

                // Create Work Order Line
                WorkOrderLine.Init();
                WorkOrderLine."Document Type" := WorkOrder."Document Type";
                WorkOrderLine."Document No." := WorkOrder."No.";
                WorkOrderLine."Line No." := LineNo;
                WorkOrderLine.Insert(true);
                WorkOrderLine.Validate(Type, PurchaseLine.Type);
                WorkOrderLine.Validate("No.", PurchaseLine."No.");
                WorkOrderLine.Validate(Description, PurchaseLine.Description);
                WorkOrderLine.Validate(Quantity, PurchaseLine.Quantity);
                WorkOrderLine.Validate("Unit Cost", PurchaseLine."Direct Unit Cost");
                WorkOrderLine.Validate("H2O Vendor No.", PurchaseLine."Pay-to Vendor No.");
                WorkOrderLine.Validate("H2O Vendor PO", PurchaseLine."Document No.");
                WorkOrderLine.Validate("H2O PO Amount", PurchaseLine."Line Amount");
                WorkOrderLine.Validate("Purch. Order Line No.", PurchaseLine."Line No.");
                WorkOrderLine.Validate("Purchase Order No.", PurchaseLine."Document No.");
                WorkOrderLine.Modify(true);

                LineNo += 10000;
                ImportedLines += 1;
            end;

        until PurchaseLine.Next() = 0;

        if SkippedLines > 0 then
            Message(
                'Purchase Order %1 was successfully retrieved. %2 new line(s) were added and %3 existing line(s) were skipped.',
                PurchaseHeader."No.",
                ImportedLines,
                SkippedLines)
        else
            Message(
                'Purchase Order %1 was successfully retrieved. %2 line(s) were added to Work Order %3.',
                PurchaseHeader."No.",
                ImportedLines,
                WorkOrder."No.");
    end;

    procedure ValidateH2OVendorPayment(GenJournalLine: Record "Gen. Journal Line")
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Vendor: Record Vendor;
    begin
        if GenJournalLine."Account Type" <> GenJournalLine."Account Type"::Vendor then
            exit;

        if GenJournalLine."Document Type" <> GenJournalLine."Document Type"::Payment then
            exit;

        if GenJournalLine."Account No." = '' then
            exit;

        if not Vendor.Get(GenJournalLine."Account No.") then
            exit;


        if GenJournalLine."Applies-to Doc. No." <> '' then begin

            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange("Vendor No.",
                GenJournalLine."Account No.");
            VendorLedgerEntry.SetRange("Document No.", GenJournalLine."Applies-to Doc. No.");

            if VendorLedgerEntry.FindFirst() then
                ValidateH2OPurchaseInvoice(VendorLedgerEntry."Document No.", GenJournalLine."Account No.");

            exit;
        end;

        if GenJournalLine."Applies-to ID" <> '' then begin

            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange("Vendor No.", GenJournalLine."Account No.");
            VendorLedgerEntry.SetRange("Applies-to ID", GenJournalLine."Applies-to ID");
            VendorLedgerEntry.SetRange(Open, true);

            if VendorLedgerEntry.FindSet() then
                repeat
                    ValidateH2OPurchaseInvoice(VendorLedgerEntry."Document No.", GenJournalLine."Account No.");
                until VendorLedgerEntry.Next() = 0;

            exit;
        end;
    end;

    procedure ValidateH2OVendorPaymentFromVendorLedgerEntry(VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        if VendorLedgerEntry."Document No." = '' then
            exit;

        ValidateH2OPurchaseInvoice(VendorLedgerEntry."Document No.", VendorLedgerEntry."Vendor No.");
    end;

    procedure ValidateH2OPurchaseInvoice(PurchaseInvoiceNo: Code[20]; VendorNo: Code[20])
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchaseOrderNo: Code[20];
    begin
        if PurchaseInvoiceNo = '' then
            exit;

        PurchInvHeader.Reset();
        PurchInvHeader.SetRange("No.", PurchaseInvoiceNo);

        if not PurchInvHeader.FindFirst() then
            exit;


        if (VendorNo <> '') and
           (PurchInvHeader."Buy-from Vendor No." <> VendorNo) then
            exit;

        PurchaseOrderNo := PurchInvHeader."Order No.";

        if (PurchaseOrderNo = '') and (not PurchInvHeader."H2O ByPass Work Order Payment") then
            exit;

        ValidateH2OCustomerPayment(PurchaseOrderNo);
    end;

    procedure ValidateH2OCustomerPayment(PurchaseOrderNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        FoundSalesInvoice: Boolean;
    begin
        if PurchaseOrderNo = '' then
            exit;

        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange(
            "H2O Purchase Order No.",
            PurchaseOrderNo);

        if not SalesInvoiceHeader.FindSet() then
            exit;

        repeat
            FoundSalesInvoice := true;

            CustLedgerEntry.Reset();
            CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
            CustLedgerEntry.SetRange("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");

            if CustLedgerEntry.FindSet() then
                repeat
                    if CustLedgerEntry.Open then
                        Error('Vendor payment cannot be posted.\' +
                            'Work order payment have not received\' +
                            ' Purchase Order No.: %1\' +
                            ' Sales Invoice No.: %2\' +
                            ' Customer No.: %3.',
                            PurchaseOrderNo,
                            SalesInvoiceHeader."No.",
                            CustLedgerEntry."Customer No.");

                until CustLedgerEntry.Next() = 0;

        until SalesInvoiceHeader.Next() = 0;
    end;
}
