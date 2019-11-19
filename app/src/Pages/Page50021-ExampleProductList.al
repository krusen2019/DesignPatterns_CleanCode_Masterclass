page 50021 "Example Product List"
{

    PageType = List;
    SourceTable = "Example Product";
    Caption = 'Example Product List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Example Product Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                    Visible = false;
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
