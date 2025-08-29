table 52100 "H2O Time Keeping Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(5; Type; Enum "Sales Line Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';

        }
        field(6; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {

            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FieldNo("Unit Price"));
            Caption = 'Unit Price';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item),
                                "No." = filter(<> '')) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const(Resource),
                                         "No." = filter(<> '')) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            if (Type = filter("Charge (Item)" | "Fixed Asset" | "G/L Account")) "Unit of Measure";
        }
        field(50270; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(50250; "Start Time"; time)
        {
            Caption = 'Start Time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Start Date" = 0D then "Start Date" := today;
                StartDT := CreateDateTime("Start Date", "Start Time");
                If Rec."Start Time" <> xRec."Start Time" then begin
                    "End Date" := 0D;
                    "End Time" := 0T;
                end;
            end;
        }
        field(50290; StartDT; DateTime)
        {
            Caption = 'StartDT';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50280; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(50260; "End Time"; time)
        {
            Caption = 'End Time';
            DataClassification = ToBeClassified;
        }
        field(50200; "Original Document No."; code[20])
        {
            Caption = 'Original Document No.';
            DataClassification = ToBeClassified;
        }
        field(50205; "Original Line No."; integer)
        {
            Caption = 'Original Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50207; "Original Ship-to Code"; code[10])
        {
            Caption = 'Original Ship-to Code';
            DataClassification = ToBeClassified;
            //Editable = false;
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Sell-to Customer No."));
        }
        field(52201; "Time Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(52202; "Entry Number"; Text[20])
        {
            Caption = 'Entry Number';
            DataClassification = ToBeClassified;
        }

        field(52203; "Payroll Code"; Code[20])
        {
            Caption = 'Payroll Code';
            DataClassification = ToBeClassified;
            TableRelation = "USPY Payroll Code".Code WHERE("Type" = field("Payroll Code Type"));
        }

        field(52204; "Payroll Description"; Text[100])
        {
            Caption = 'Payroll Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("USPY Payroll Code".Description where(Code = field("Payroll Code")));
        }
        field(52205; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(52206; "Payroll Code Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payroll Code Type';
            OptionMembers = " ",Earnings,Deduction,Withholding,"Employer Tax","Direct Deposit",Payment,,"Employer Contribut.",Reimbursement,"Advance / Loan";
            OptionCaption = ' ,Earnings,Deduction,Withholding,Employer Tax,Direct Deposit,Payment,,Employer Contribut.,Reimbursement,Advance / Loan';
        }
    }

    keys
    {
        key(key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    var
        SalesLineCaptionClassMgmt: Codeunit "Sales Line CaptionClass Mgmt";
        SalesLine: Record "Sales Line";
    begin
        exit(SalesLineCaptionClassMgmt.GetSalesLineCaptionClass(SalesLine, FieldNumber));
    end;
}