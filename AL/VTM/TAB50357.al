table 50357 "VTM Pool Line"
{
    Caption = 'VTM Pool Line';

    fields
    {
        field(1;"Header Number";Integer)
        {
            Caption = 'Header Number';
            DataClassification = ToBeClassified;
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3;"Round No.";Integer)
        {
            Caption = 'Round No.';
            DataClassification = ToBeClassified;
        }
        field(4;"Line Type";Text[50])
        {
            Caption = 'Line Type';
            DataClassification = ToBeClassified;
        }
        field(5;"Movie Number";Integer)
        {
            Caption = 'Movie Number';
            DataClassification = ToBeClassified;
            TableRelation = "VTM Movie".Number;
        }
        field(6;"User ID";Text[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = "VTM User"."User ID";
        }
        field(7;"Promotional Action";Text[50])
        {
            Caption = 'Promotional Action';
            DataClassification = ToBeClassified;
        }
        field(8;"Promotional State";Text[50])
        {
            Caption = 'Promotional State';
            DataClassification = ToBeClassified;
        }
        field(9;"Promotional Line Number";Integer)
        {
            Caption = 'Promotional Line Number';
            DataClassification = ToBeClassified;
        }
        field(10;"Created At";DateTime)
        {
            Caption = 'Created At';
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
        key(Key1;"Header Number","Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

