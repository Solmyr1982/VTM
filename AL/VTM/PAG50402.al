page 50402 "VTM User Batch List"
{
    Caption = 'VTM User Batch List';
    PageType = List;
    SourceTable = "VTM User Batch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                }
                field("Batch Name"; "Batch Name")
                {
                }
                field("Read Only"; "Read Only")
                {
                }
            }
        }
    }

    actions
    {
    }
}

