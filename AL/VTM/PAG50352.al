page 50352 "Movie Batch Entity"
{
    Caption = 'Movie Batch Entity';
    DelayedInsert = true;
    EntityName = 'movieBatchEntity';
    EntitySetName = 'movieBatchEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Movie Batch";
    SourceTableView = SORTING("Movie Number", "Batch Name");

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
                field(MovieNumber; "Movie Number")
                {
                    Caption = 'MovieNumber';
                }
                field(BatchName; "Batch Name")
                {
                    Caption = 'BatchName';
                }
            }
        }
    }

    actions
    {
    }
}

