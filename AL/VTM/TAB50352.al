table 50352 "VTM Movie Batch"
{
    Caption = 'VTM Movie Batch';

    fields
    {
        field(1;"Movie Number";Integer)
        {
            Caption = 'Movie Number';
            DataClassification = ToBeClassified;
            TableRelation = "VTM Movie".Number;
        }
        field(2;"Batch Name";Text[30])
        {
            Caption = 'Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "VTM Batch".Name;
        }
        field(100;ID;Guid)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Movie Number","Batch Name")
        {
        }
    }

    fieldgroups
    {
    }
}

