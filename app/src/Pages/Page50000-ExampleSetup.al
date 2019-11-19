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
                field("Example Enabled"; "Example Enabled")
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        InitializeSetup();
    end;
}
