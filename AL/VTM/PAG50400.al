page 50400 "VTM Relation List"
{
    Caption = 'VTM Relation List';
    PageType = List;
    SourceTable = "VTM Relation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number; Number)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

