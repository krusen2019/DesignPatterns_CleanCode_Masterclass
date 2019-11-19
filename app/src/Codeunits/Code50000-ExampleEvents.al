codeunit 50000 "Example Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", 'OnCompanyInitialize', '', false, false)]
    local procedure HandleOncapanyInitialize()
    var
        ExampleSetup: Record "Example Setup";
    begin
        ExampleSetup.InitializeSetup();
    end;
}
