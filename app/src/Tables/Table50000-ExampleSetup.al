table 50000 "Example Setup"
{
    Caption = 'Example Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Example Enabled"; Boolean)
        {
            Caption = 'Example Enabled';
            DataClassification = ToBeClassified;
        }
        field(11; "Example Person Nos."; Code[20])
        {
            Caption = 'Example Person Nos.';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(12; "Example Product Nos."; Code[20])
        {
            Caption = 'Example Product Nos.';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    procedure InitializeSetup()
    var
        ExampleSetup: Record "Example Setup";
    begin
        ExampleSetup.Reset();
        if ExampleSetup.Get() then
            exit;
        ExampleSetup.Init();
        ExampleSetup.Insert();
    end;
}
