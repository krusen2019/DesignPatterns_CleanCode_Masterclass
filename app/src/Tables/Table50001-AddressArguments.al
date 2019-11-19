table 50001 "Address Arguments"
{
    Caption = 'Address Arguments';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = ToBeClassified;
        }
        field(4; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(5; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(8; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
        }
        field(9; County; Text[30])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
        }
        field(10; Contact; Text[100])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    local procedure FormatAddr(var AddrArray: array[8] of Text[100])
    var
        FormatAddress: Codeunit "Format Address";
    begin
        FormatAddress.FormatAddr(
              AddrArray, Name, "Name 2", Contact, Address, "Address 2",
              City, "Post Code", County, "Country/Region Code");
    end;

    procedure FormatAddrExamplePerson(var AddrArray: array[8] of Text[100]; ExamplePerson: Record "Example Person")
    begin
        clear(Rec);
        Name := ExamplePerson.Name;
        "Name 2" := ExamplePerson."Name 2";
        Contact := ExamplePerson.Contact;
        Address := ExamplePerson.Address;
        "Address 2" := ExamplePerson."Address 2";
        City := ExamplePerson.City;
        "Post Code" := ExamplePerson."Post Code";
        County := ExamplePerson.County;
        "Country/Region Code" := ExamplePerson."Country/Region Code";
        FormatAddr(AddrArray);
    end;
}
