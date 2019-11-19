page 50000 "Example Setup"
{

    PageType = Card;
    SourceTable = "Example Setup";
    Caption = 'Example Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Example Enabled"; "Example Enabled")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Example Person Nos."; "Example Person Nos.")
                {
                    ApplicationArea = All;
                }
                field("Example Product Nos."; "Example Product Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        InitializeSetup();
    end;
}
