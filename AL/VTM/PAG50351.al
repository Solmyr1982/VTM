page 50351 "Batch Entity"
{
    Caption = 'Batch Entity';
    DelayedInsert = true;
    EntityName = 'batchEntity';
    EntitySetName = 'batchEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Batch";
    SourceTableView = SORTING(Name);

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
                field(Name; Name)
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

