page 50403 "VTM Pool Header List"
{
    Caption = 'VTM Pool Header List';
    PageType = List;
    SourceTable = "VTM Pool Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number; Number)
                {
                }
                field("Batch Name"; "Batch Name")
                {
                }
                field("Initiated By User ID"; "Initiated By User ID")
                {
                }
                field("Started At"; "Started At")
                {
                }
                field("Finished At"; "Finished At")
                {
                }
                field("Winner Movie Number"; "Winner Movie Number")
                {
                }
                field("Current Round"; "Current Round")
                {
                }
            }
        }
    }

    actions
    {
    }
}

