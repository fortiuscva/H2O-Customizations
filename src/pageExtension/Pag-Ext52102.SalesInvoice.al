pageextension 52102 "H2O Sales Invoice" extends "Sales Invoice"
{
    Caption = 'Work Order';
    layout
    {
        addlast("Shipping and Billing")
        {
            field("H2O Route No."; Rec."H2O Route No.")
            {
                ApplicationArea = all;
                ToolTip = 'Route No.';
            }
            field("H2O Location Stop"; Rec."H2O Location Stop")
            {
                ToolTip = 'Location Stop';
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field("H2O WOComments"; WOComments)
            {
                ApplicationArea = all;
                Caption = 'WOComments';
            }
            field("H2O SystemModifiedAt"; Rec.SystemModifiedAt)
            {
                Caption = 'System Modified At';
                ApplicationArea = All;
            }
            field("H2O Purchase Order No."; Rec."H2O Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Order No. field.', Comment = '%';
            }
        }

    }
    actions
    {
        addlast(Processing)
        {
            action("H2O GetPurchaseOrder")
            {
                Caption = 'Get Purchase Order';
                ApplicationArea = All;
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    GeneralFunctions: Codeunit "H2O General Functions";
                begin
                    GeneralFunctions.GetPurchaseOrder(Rec);

                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.Caption('Work Order');
    end;


    trigger OnModifyRecord(): Boolean
    var
        RecLink: Record "Record Link";
        SalesHeaderRec: Record "Sales Header";
        EntryNo: Integer;
        OutStreamLcl: OutStream;
    begin
        if SalesHeaderRec.Get(Rec."Document Type", Rec."No.") then begin
            RecLink.SetRange("Record ID", SalesHeaderRec.RecordId);
            RecLink.SetRange(Type, RecLink.Type::Note);
            if RecLink.FindFirst() then begin
                RecLink."User ID" := UserId;
                RecLink.Created := CreateDateTime(Today, Time);
                RecLink.Note.CreateOutStream(OutStreamLcl);
                OutStreamLcl.WriteText(WOComments);
                RecLink.Modify();
            end else begin
                RecLink.Reset();
                if RecLink.FindLast() then
                    EntryNo := RecLink."Link ID" + 1
                else
                    EntryNo := 1;

                RecLink.Init();
                RecLink."Link ID" := EntryNo;
                RecLink."Record ID" := SalesHeaderRec.RecordId;
                RecLink.Type := RecLink.Type::Note;
                RecLink."User ID" := UserId;
                RecLink.Created := CreateDateTime(Today, Time);
                RecLink.Company := CompanyName;
                RecLink.Note.CreateOutStream(OutStreamLcl);
                OutStreamLcl.WriteText(WOComments);
                RecLink.Insert();
            end;
        end;
        exit(true);
    end;


    var
        WOComments: Text;
}
