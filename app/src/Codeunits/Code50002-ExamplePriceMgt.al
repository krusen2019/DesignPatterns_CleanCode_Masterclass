codeunit 50002 "Example Price Management"
{
    local procedure GetExampleProduct(var ExampleProduct: Record "Example Product"; ExampleProductNo: Code[20])
    begin
        if ExampleProduct.get(ExampleProductNo) then
            exit;
        clear(ExampleProduct);
        ExampleProduct.Init();
        ExampleProduct."No." := ExampleProductNo;
    end;

    procedure GetUnitPriceLCY(ExampleProduct: Record "Example Product"; ExamplePerson: Record "Example Person"): Decimal
    begin
        exit(GetUnitPriceLCY(ExampleProduct, ExamplePerson."No."));
    end;

    procedure GetUnitPriceLCY(ExampleProductNo: Code[20]; ExamplePerson: Record "Example Person"): Decimal
    var
        ExampleProduct: Record "Example Product";
    begin
        GetExampleProduct(ExampleProduct, ExampleProductNo);
        exit(GetUnitPriceLCY(ExampleProduct, ExamplePerson."No."));
    end;

    procedure GetUnitPriceLCY(ExampleProductNo: Code[20]; ExamplePersonNo: Code[20]): Decimal
    var
        ExampleProduct: Record "Example Product";
    begin
        GetExampleProduct(ExampleProduct, ExampleProductNo);
        exit(GetUnitPriceLCY(ExampleProduct, ExamplePersonNo));
    end;

    procedure GetUnitPriceLCY(ExampleProduct: Record "Example Product"; ExamplePersonNo: Code[20]): Decimal
    var
        ProductSalesPrice: Record "Product Sales Price";
    begin
        if ProductSalesPrice.get(ExampleProduct."No.", ExamplePersonNo) then
            exit(ProductSalesPrice."Unit Price (LCY)");
        if ProductSalesPrice.get(ExampleProduct."No.", '') then
            exit(ProductSalesPrice."Unit Price (LCY)");
        exit(ExampleProduct."Unit Price (LCY)");
    end;
}
