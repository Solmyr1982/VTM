table 50359 "VTM Setup"
{
    Caption = 'VTM Setup';
    DrillDownPageID = 50388;
    LookupPageID = 50388;

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2;"Posters Path";Text[50])
        {
            Caption = 'Posters Path';
            DataClassification = ToBeClassified;
        }
        field(3;"Site URL";Text[50])
        {
            Caption = 'Site URL';
            DataClassification = ToBeClassified;
        }
        field(4;"Resize Poster X";Integer)
        {
            Caption = 'Resize Poster X';
            DataClassification = ToBeClassified;
        }
        field(5;"Resize Poster Y";Integer)
        {
            Caption = 'Resize Poster Y';
            DataClassification = ToBeClassified;
        }
        field(6;"Admin URL";Text[50])
        {
            Caption = 'Admin URL';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

