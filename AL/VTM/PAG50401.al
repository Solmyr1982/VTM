page 50401 "VTM User List"
{
    Caption = 'VTM User List';
    PageType = List;
    SourceTable = "VTM User";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                }
                field(Administrator; Administrator)
                {
                }
            }
        }
    }

    actions
    {
    }
}

