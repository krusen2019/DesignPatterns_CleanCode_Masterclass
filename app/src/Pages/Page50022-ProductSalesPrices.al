page 50022 "Product Sales Prices"
{

    PageType = List;
    SourceTable = "Product Sales Price";
    Caption = 'Product Sales Prices';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Example Person No."; "Example Person No.")
                {
                    ApplicationArea = All;
                }
                field("Example Product No."; "Example Product No.")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
