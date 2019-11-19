codeunit 50001 "Example Interface"
{
    procedure GetExampletEnabled(): Boolean
    var
        ExampleSetup: Record "Example Setup";
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            exit(UserSetup."Example Enabled");
        if ExampleSetup.Get() then
            exit(ExampleSetup."Example Enabled");
        exit(false);
    end;
}
