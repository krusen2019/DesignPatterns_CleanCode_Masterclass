table 50010 "Example Person"
{
    Caption = 'Example Person';
    DataClassification = ToBeClassified;
    LookupPageId = "Example Person List";
    DrillDownPageId = "Example Person List";

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
                    NoSeriesManagement.TestManual(ExampleSetup."Example Person Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xrec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(3; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Name 2"; Text[100])
        {
            Caption = 'Name 2';
            DataClassification = ToBeClassified;
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(8; Contact; Text[100])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
        }
        field(9; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code" else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(10; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");
            end;
        }

        field(11; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
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
        PostCode: Record "Post Code";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            ExampleSetup.Get;
            ExampleSetup.TestField("Example Person Nos.");
            NoSeriesManagement.InitSeries(ExampleSetup."Example Person Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    procedure AssistEdit(OldExamplePerson: Record "Example Person"): Boolean
    var
        ExamplePerson: Record "Example Person";
    begin
        with ExamplePerson do begin
            ExamplePerson := Rec;
            ExampleSetup.Get;
            ExampleSetup.TestField("Example Person Nos.");
            if NoSeriesManagement.SelectSeries(ExampleSetup."Example Person Nos.", OldExamplePerson."No. Series", "No. Series") then begin
                NoSeriesManagement.SetSeries("No.");
                Rec := ExamplePerson;
                exit(true);
            end;
        end;
    end;

    // procedure FormatAddr(var AddrArray: array[8] of Text[100])
    // var
    //     FormatAddress: Codeunit "Format Address";
    // begin
    //     FormatAddress.FormatAddr(
    //           AddrArray, Name, "Name 2", Contact, Address, "Address 2",
    //           City, "Post Code", County, "Country/Region Code");
    // end;
    procedure FormatAddr(var AddrArray: array[8] of Text[100])
    var
        AddressArguments: Record "Address Arguments" temporary;
    begin
        AddressArguments.FormatAddrExamplePerson(AddrArray, Rec);
    end;
}
