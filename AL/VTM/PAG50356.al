page 50356 "Pool Header Entity"
{
    Caption = 'Pool Header Entity';
    DelayedInsert = true;
    EntityName = 'poolHeaderEntity';
    EntitySetName = 'poolHeaderEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Pool Header";
    SourceTableView = SORTING(Number);

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
                field(Number; Number)
                {
                    Caption = 'Number';
                }
                field(BatchName; "Batch Name")
                {
                    Caption = 'BatchName';
                }
                field(InitiatedByUserID; "Initiated By User ID")
                {
                    Caption = 'InitiatedByUserID';
                }
                field(StartedAt; "Started At")
                {
                    Caption = 'StartedAt';
                }
                field(FinishedAt; "Finished At")
                {
                    Caption = 'FinishedAt';
                }
                field(WinnerMovieNumber; "Winner Movie Number")
                {
                    Caption = 'WinnerMovieNumber';
                }
                field(CurrentRound; "Current Round")
                {
                    Caption = 'CurrentRound';
                }
            }
        }
    }

    actions
    {
    }
}

