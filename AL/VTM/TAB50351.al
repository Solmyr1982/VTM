table 50351 "VTM Batch"
{
    Caption = 'VTM Batch';
    DrillDownPageID = 50391;
    LookupPageID = 50391;

    fields
    {
        field(1;Name;Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(50;"User ID";Text[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Description = 'for filtering only';
            TableRelation = "VTM User";
        }
        field(100;ID;Guid)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Name)
        {
        }
    }

    fieldgroups
    {
    }
}

