pageextension 52105 "H2O Sales Invoice List" extends "Sales Invoice List"
{
    Caption = 'Work Orders';
    trigger OnOpenPage()
    begin
        CurrPage.Caption('Work Orders');
    end;
}
