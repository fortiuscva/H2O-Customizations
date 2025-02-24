tableextension 52103 "H2O Sales & Receivables Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(52100; "H2O Temporary Property Nos."; Code[20])
        {
            Caption = 'Temporary Property Nos.';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

    }
}
