table 50353 "VTM User"
{
    Caption = 'VTM User';
    DrillDownPageID = 50401;
    LookupPageID = 50401;

    fields
    {
        field(1;"User ID";Text[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(3;Administrator;Boolean)
        {
            Caption = 'Administrator';
            DataClassification = ToBeClassified;
        }
        field(100;ID;Guid)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

