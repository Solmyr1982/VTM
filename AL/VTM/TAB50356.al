table 50356 "VTM Pool Header"
{
    Caption = 'VTM Pool Header';
    DrillDownPageID = 50403;
    LookupPageID = 50403;

    fields
    {
        field(1; Number; Integer)
        {
            Caption = 'Number';
            DataClassification = ToBeClassified;
        }
        field(2; "Batch Name"; Text[50])
        {
            Caption = 'Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "VTM Batch".Name;
        }
        field(3; "Initiated By User ID"; Text[50])
        {
            Caption = 'Initiated By User ID';
            DataClassification = ToBeClassified;
            TableRelation = "VTM User"."User ID";
        }
        field(4; "Started At"; DateTime)
        {
            Caption = 'Started At';
            DataClassification = ToBeClassified;
        }
        field(5; "Finished At"; DateTime)
        {
            Caption = 'Finished At';
            DataClassification = ToBeClassified;
        }
        field(6; "Winner Movie Number"; Integer)
        {
            Caption = 'Winner Movie Number';
            DataClassification = ToBeClassified;
            TableRelation = "VTM Movie".Number;
        }
        field(7; "Current Round"; Integer)
        {
            Caption = 'Current Round';
            DataClassification = ToBeClassified;
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
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        VTMPoolLine: Record 50357;
    begin
        IF NOT Confirm('Do you want to delete Pool Header?') then
            Error('');
        VTMPoolLine.SetRange("Header Number", Number);
        VTMPoolLine.DeleteAll();
    end;
}

