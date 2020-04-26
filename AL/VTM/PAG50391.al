page 50391 "VTM Batch List"
{
    Caption = 'VTM Batch List';
    PageType = List;
    SourceTable = "VTM Batch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Name)
                {
                }
            }
        }
    }

    actions
    {
    }
}

