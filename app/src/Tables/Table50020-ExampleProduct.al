table 50020 "Example Product"
{
    Caption = 'Example Product';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    ExampleSetup.Get();
                    NoSeriesManagement.TestManual(ExampleSetup."Example Product Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xrec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
            end;
        }
        field(3; "Search Description"; Code[50])
        {
            Caption = 'Search Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
        field(51; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(101; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        ExampleSetup: Record "Example Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            ExampleSetup.Get;
            ExampleSetup.TestField("Example Product Nos.");
            NoSeriesManagement.InitSeries(ExampleSetup."Example Product Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    procedure AssistEdit(OldExampleProduct: Record "Example Product"): Boolean
    var
        ExampleProduct: Record "Example Product";
    begin
        with ExampleProduct do begin
            ExampleProduct := Rec;
            ExampleSetup.Get;
            ExampleSetup.TestField("Example Product Nos.");
            if NoSeriesManagement.SelectSeries(ExampleSetup."Example Product Nos.", OldExampleProduct."No. Series", "No. Series") then begin
                NoSeriesManagement.SetSeries("No.");
                Rec := ExampleProduct;
                exit(true);
            end;
        end;
    end;
}
