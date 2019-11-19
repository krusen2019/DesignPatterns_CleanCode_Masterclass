page 50020 "Example Product Card"
{

    PageType = Card;
    SourceTable = "Example Product";
    Caption = 'Example Product Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Description)
                {
                    ApplicationArea = All;
                }
                field("Name 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Search Name"; "Search Description")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(ProductSalesPrice)
            {
                RunObject = page "Product Sales Prices";
                RunPageLink = "Example Product No." = field("No.");
                ApplicationArea = All;
                Image = Price;
                Caption = 'Product Sales Price';
            }
        }
    }
}
