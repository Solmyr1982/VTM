table 50355 "VTM Relation"
{
    Caption = 'VTM Relation';
    DrillDownPageID = 50400;
    LookupPageID = 50400;

    fields
    {
        field(1;Number;Integer)
        {
            Caption = 'Number';
            DataClassification = ToBeClassified;
        }
        field(2;Description;Text[50])
        {
            Caption = 'Description';
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
        key(Key1;Number)
        {
        }
    }

    fieldgroups
    {
    }
}

