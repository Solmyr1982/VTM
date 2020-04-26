page 50354 "User Batch Entity"
{
    Caption = 'User Batch Entity';
    DelayedInsert = true;
    EntityName = 'userBatchEntity';
    EntitySetName = 'userBatchEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM User Batch";
    SourceTableView = SORTING("User ID", "Batch Name");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; ID)
                {
                    Caption = 'id';
                }
                field(UserID; "User ID")
                {
                    Caption = 'UserID';
                }
                field(Name; "Batch Name")
                {
                    Caption = 'Name';
                }
            }
        }
    }

    actions
    {
    }
}

