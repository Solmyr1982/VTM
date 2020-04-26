table 50354 "VTM User Batch"
{
    Caption = 'VTM User Batch';
    DrillDownPageID = 50402;
    LookupPageID = 50402;

    fields
    {
        field(1;"User ID";Text[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "VTM User"."User ID";
        }
        field(2;"Batch Name";Text[50])
        {
            Caption = 'Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "VTM Batch".Name;
        }
        field(3;"Read Only";Boolean)
        {
            Caption = 'Read Only';
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
        key(Key1;"User ID","Batch Name")
        {
        }
    }

    fieldgroups
    {
    }
}

