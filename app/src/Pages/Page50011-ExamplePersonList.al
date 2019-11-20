page 50011 "Example Person List"
{

    PageType = List;
    SourceTable = "Example Person";
    Caption = 'Example Person List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Example Person Card";
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
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Name 2"; "Name 2")
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
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
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
                RunPageLink = "Example Person No." = field("No.");
                ApplicationArea = All;
                Image = Price;
                Caption = 'Product Sales Price';
            }
        }
    }
}
