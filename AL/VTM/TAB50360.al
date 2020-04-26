table 50360 "VTM Role Center Cue"
{
    Caption = 'VTM Role Center Cue';

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2;Movies;Integer)
        {
            CalcFormula = Count("VTM Movie");
            Caption = 'Movies';
            FieldClass = FlowField;
        }
        field(3;Batches;Integer)
        {
            CalcFormula = Count("VTM Batch");
            Caption = 'Batches';
            FieldClass = FlowField;
        }
        field(4;Relations;Integer)
        {
            CalcFormula = Count("VTM Relation");
            Caption = 'Relations';
            FieldClass = FlowField;
        }
        field(5;Users;Integer)
        {
            CalcFormula = Count("VTM User");
            Caption = 'Users';
            FieldClass = FlowField;
        }
        field(6;"User Batches";Integer)
        {
            CalcFormula = Count("VTM User Batch");
            Caption = 'User Batches';
            FieldClass = FlowField;
        }
        field(7;Pools;Integer)
        {
            CalcFormula = Count("VTM Pool Header");
            Caption = 'Pools';
            FieldClass = FlowField;
        }
        field(8;Setup;Integer)
        {
            CalcFormula = Count("VTM Setup");
            FieldClass = FlowField;
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

