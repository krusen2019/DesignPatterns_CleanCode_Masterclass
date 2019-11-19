table 50021 "Product Sales Price"
{
    Caption = 'Product Sales Price';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Example Product No."; Code[20])
        {
            Caption = 'Example Product No.';
            DataClassification = ToBeClassified;
            TableRelation = "Example Product";
            NotBlank = true;
        }
        field(2; "Example Person No."; Code[20])
        {
            Caption = 'Example Person No.';
            DataClassification = ToBeClassified;
            TableRelation = "Example Person";
            NotBlank = true;
        }
        field(11; "Unit Price (LCY)"; Decimal)
        {
            Caption = 'Unit Price (LCY)';
            DataClassification = ToBeClassified;
            AutoFormatType = 2;
        }
    }

    keys
    {
        key(PK; "Example Product No.", "Example Person No.")
        {
            Clustered = true;
        }
    }
}
