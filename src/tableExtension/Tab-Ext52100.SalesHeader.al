tableextension 52100 "H2O Sales Header" extends "sales header"
{
    fields
    {
        modify("Work Order Type Code")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Shortcut Dimension 2 Code" <> Rec."Work Order Type Code" then
                    Rec.Validate("Shortcut Dimension 2 Code", Rec."Work Order Type Code");
            end;

        }
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
    }
}
