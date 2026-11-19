pageextension 52105 "H2O Sales Invoice List" extends "Sales Invoice List"
{
    Caption = 'Work Orders';
    layout
    {
        addlast(Control1)
        {
            field("H2O Ship-to Name 2"; Rec."Ship-to Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies an additional part of the name that products on the sales document will be shipped to.';
            }
            field("H2O Ship-to Phone No."; Rec."Ship-to Phone No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the telephone number of the company''s shipping address.';
            }
            field("H2O Ship-to Address"; Rec."Ship-to Address")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the address that products on the sales document will be shipped to. By default, the field is filled with the value in the Address field on the customer card or with the value in the Address field in the Ship-to Address window.';
            }
            field("H2O Ship-to City"; Rec."Ship-to City")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the city of the shipping address.';
            }
        }
        modify("Ship-to Name")
        {
            Visible = true;
        }
        modify("Ship-to Contact")
        {
            visible = true;
        }
        modify("Ship-to Post Code")
        {
            Visible = true;
        }
    }
    trigger OnOpenPage()
    begin
        CurrPage.Caption('Work Orders');
    end;
}
