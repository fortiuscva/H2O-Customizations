codeunit 52102 "H2O PO WO Validation"
{

    procedure ValidatePOWorkOrderLink(SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        ExistingSalesLine: Record "Sales Line";
        ExistingSalesHeader: Record "Sales Header";
        PurchaseOrderNo: Code[20];
        ExistingPurchaseOrderNo: Code[20];
    begin
        if SalesLine."Document Type" <> SalesLine."Document Type"::Order then
            exit;
        if not SalesHeader.Get(
            SalesLine."Document Type",
            SalesLine."Document No.")
        then
            exit;

        // Get PO No. from Sales Line.
        // If blank, use the Work Order Header PO No.
        PurchaseOrderNo := SalesLine."Purchase Order No.";
        if PurchaseOrderNo = '' then
            PurchaseOrderNo := SalesHeader."H2O Purchase Order No.";
        if PurchaseOrderNo = '' then
            exit;
        if SalesLine."H2O Purchase Line No." = 0 then
            exit;

        ExistingSalesLine.Reset();
        ExistingSalesLine.SetRange(
            "Document Type",
            ExistingSalesLine."Document Type"::Order);

        ExistingSalesLine.SetRange(
            "H2O Purchase Line No.",
            SalesLine."H2O Purchase Line No.");

        ExistingSalesLine.SetFilter(
            "Document No.",
            '<>%1',
            SalesLine."Document No.");
        if ExistingSalesLine.FindSet() then
            repeat
                ExistingPurchaseOrderNo :=
                    ExistingSalesLine."Purchase Order No.";
                if ExistingSalesHeader.Get(
                    ExistingSalesLine."Document Type",
                    ExistingSalesLine."Document No.")
                then begin
                    if ExistingPurchaseOrderNo = '' then
                        ExistingPurchaseOrderNo :=
                            ExistingSalesHeader."H2O Purchase Order No.";
                    if ExistingPurchaseOrderNo = PurchaseOrderNo then
                        Error(
                            'PO %1, Line %2 is already linked to Work Order %3.',
                            PurchaseOrderNo,
                            SalesLine."H2O Purchase Line No.",
                            ExistingSalesLine."Document No.");
                end;
            until ExistingSalesLine.Next() = 0;
    end;


    procedure IsPOLineLinkedToAnotherWO(
        PurchaseOrderNo: Code[20];
        PurchaseOrderLineNo: Integer;
        CurrentWONo: Code[20]): Boolean
    var
        ExistingSalesLine: Record "Sales Line";
    begin
        ExistingSalesLine.Reset();
        ExistingSalesLine.SetRange("Document Type", ExistingSalesLine."Document Type"::Order);
        ExistingSalesLine.SetRange("Purchase Order No.", PurchaseOrderNo);
        ExistingSalesLine.SetRange("H2O Purchase Line No.", PurchaseOrderLineNo);
        ExistingSalesLine.SetFilter("Document No.", '<>%1', CurrentWONo);
        exit(ExistingSalesLine.FindFirst());
    end;

    procedure ValidatePOCustomerPayment(PurchaseOrderNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        TotalPaymentAmount: Decimal;
    begin
        if PurchaseOrderNo = '' then
            exit;

        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("H2O Purchase Order No.", PurchaseOrderNo);
        if not SalesInvoiceHeader.FindSet() then
            Error(
                'No posted Sales Invoice found for PO %1. WO posting is not allowed.',
                PurchaseOrderNo);
        repeat
            CustLedgerEntry.Reset();
            CustLedgerEntry.SetRange("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
            CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
            CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
            if not CustLedgerEntry.FindFirst() then
                Error(
                    'Customer Ledger Entry not found for Sales Invoice %1. WO posting is not allowed.',
                    SalesInvoiceHeader."No.");

            CustLedgerEntry.CalcFields("Remaining Amount");

            // Check actual payment applications against the invoice
            DetailedCustLedgEntry.Reset();
            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
            DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
            DetailedCustLedgEntry.SetRange("Document Type", DetailedCustLedgEntry."Document Type"::Payment);
            DetailedCustLedgEntry.SetRange(Unapplied, false);

            TotalPaymentAmount := 0;
            if DetailedCustLedgEntry.FindSet() then
                repeat
                    TotalPaymentAmount += Abs(DetailedCustLedgEntry.Amount);
                until DetailedCustLedgEntry.Next() = 0;

            // Payment must cover the complete invoice amount
            if TotalPaymentAmount < Abs(CustLedgerEntry.Amount) then
                Error(
                    'Actual customer payment has not been fully received against PO %1.\Sales Invoice No.: %2\Invoice Amount: %3\Actual Payment Received: %4',
                    PurchaseOrderNo,
                    SalesInvoiceHeader."No.",
                    Abs(CustLedgerEntry.Amount),
                    TotalPaymentAmount);

            // Invoice must also be fully settled
            if CustLedgerEntry."Remaining Amount" <> 0 then
                Error(
                    'Sales Invoice %1 against PO %2 still has an outstanding amount of %3.',
                    SalesInvoiceHeader."No.",
                    PurchaseOrderNo,
                    CustLedgerEntry."Remaining Amount");
        until SalesInvoiceHeader.Next() = 0;
    end;
}