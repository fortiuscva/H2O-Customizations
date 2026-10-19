tableextension 52106 "H2O Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(52100; "H2O Route No."; Integer)
        {
            Caption = 'Route No.';
            //TableRelation = Route."No." where("Customer No." = field("Sell-to Customer No."));
            fieldclass = FlowField;
            calcformula = lookup("Ship-to Address"."Route No." where("Customer No." = field("Sell-to Customer No."), Code = field("Ship-to Code")));
            editable = false;
        }
        field(52101; "H2O Location Stop"; Code[20])
        {
            Caption = 'Location Stop';
            fieldclass = FlowField;
            calcformula = lookup("Ship-to Address"."Location Stop" where("Customer No." = field("Sell-to Customer No."), Code = field("Ship-to Code")));
            editable = false;
        }
        field(52102; "H2O Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
        }
    }
}

