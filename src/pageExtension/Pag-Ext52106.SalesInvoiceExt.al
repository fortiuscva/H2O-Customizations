pageextension 52106 "H2O SalesInvoiceExt" extends "Sales Invoice"
{
    layout
    {
        addlast(content)
        {
            field("H2O SystemModifiedAt"; Rec.SystemModifiedAt)
            {
                Caption = 'System Modified At';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}