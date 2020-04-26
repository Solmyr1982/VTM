table 50350 "VTM Movie"
{
    Caption = 'VTM Movie';
    DrillDownPageID = 50385;
    LookupPageID = 50385;

    fields
    {
        field(1; Number; Integer)
        {
            Caption = 'Number';
            DataClassification = ToBeClassified;
        }
        field(2; Poster; Text[250])
        {
            Caption = 'Poster';
            DataClassification = ToBeClassified;
        }
        field(3; WIKI; Text[250])
        {
            Caption = 'WIKI';
            DataClassification = ToBeClassified;
        }
        field(4; Trailer; Text[150])
        {
            Caption = 'Trailer';
            DataClassification = ToBeClassified;
        }
        field(5; "Name ENU"; Text[100])
        {
            Caption = 'Name ENU';
            DataClassification = ToBeClassified;
        }
        field(6; "Name RU"; Text[100])
        {
            Caption = 'Name RU';
            DataClassification = ToBeClassified;
        }
        field(7; "Relation Number"; Integer)
        {
            Caption = 'Relation Number';
            DataClassification = ToBeClassified;
            TableRelation = "VTM Relation".Number;
        }
        field(8; "Part"; Integer)
        {
            Caption = 'Part';
            DataClassification = ToBeClassified;
        }
        field(9; Series; Boolean)
        {
            Caption = 'Series';
            DataClassification = ToBeClassified;
        }
        field(10; "Poster Blob"; BLOB)
        {
            Caption = 'Poster Blob';
            DataClassification = ToBeClassified;
            Description = 'for displaybg picture on card';
            SubType = Bitmap;
        }
        field(50; "Pool Header Number"; Integer)
        {
            Caption = 'Pool Header Number';
            DataClassification = ToBeClassified;
            Description = 'for filtering';
            TableRelation = "VTM Pool Header";
        }
        field(51; "User ID"; Text[30])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Description = 'shows user who voted';
        }
        field(52; Selected; Integer)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
            Description = 'how many times selected in 3rd round';
        }
        field(53; "Random Number"; Integer)
        {
            Caption = 'Random Number';
            DataClassification = ToBeClassified;
            Description = 'for finalyzing the pool';
        }
        field(100; ID; Guid)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Number)
        {
        }
        key(Key2; "Random Number")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        VTMMovieBatch: Record "VTM Movie Batch";
        VTMSetup: Record "VTM Setup";
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            ERROR('');

        VTMMovieBatch.SETRANGE("Movie Number", Number);
        VTMMovieBatch.DELETEALL;
        VTMSetup.GET;
        IF VTMSetup."Posters Path" <> '' THEN
            IF FILE.EXISTS(VTMSetup."Posters Path" + FORMAT(Number) + '.jpg') THEN
                FILE.ERASE(VTMSetup."Posters Path" + FORMAT(Number) + '.jpg');

    end;

    var
        Text001: Label 'Do you really want to delete the movie?';
}

