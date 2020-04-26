table 50358 "VTM Request Processor"
{
    Caption = 'VTM Request Processor';

    fields
    {
        field(1; ID; Guid)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
        field(2; Text; Text[30])
        {
            Caption = 'Text';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
        {
        }
    }

    fieldgroups
    {
    }
}

