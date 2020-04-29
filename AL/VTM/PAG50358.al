page 50358 "Batch History Entity"
{
    Caption = 'Batch History Entity';
    DelayedInsert = true;
    EntityName = 'batchHistoryEntity';
    EntitySetName = 'batchHistoryEntity';
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
                field(BatchName; "Batch Name")
                {
                    Caption = 'BatchName';
                }
                field(MovieNumber; "Winner Movie Number")
                {
                    Caption = 'MovieNumber';
                }
                field(FinishedAt; "Finished At")
                {
                    Caption = 'FinishedAt';
                }
                field(Poster; VTMMovie.Poster)
                {
                    Caption = 'Poster';
                }
                field(WIKI; VTMMovie.WIKI)
                {
                    Caption = 'WIKI';
                }
                field(Trailer; VTMMovie.Trailer)
                {
                    Caption = 'Trailer';
                }
                field(NameENU; VTMMovie."Name ENU")
                {
                    Caption = 'NameENU';
                }
                field(NameRU; VTMMovie."Name RU")
                {
                    Caption = 'NameRU';
                }
                field(RelationNumber; VTMMovie."Relation Number")
                {
                    Caption = 'RelationNumber';
                }
                field("Part"; VTMMovie.Part)
                {
                    Caption = 'Part';
                }
                field(Series; VTMMovie.Series)
                {
                    Caption = 'Series';
                }
                field(IMDB; VTMMovie.IMDB)
                {
                    Caption = 'IMDB';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF "Winner Movie Number" <> 0 THEN
            VTMMovie.GET("Winner Movie Number")
        ELSE
            CLEAR(VTMMovie);
    end;

    trigger OnInit()
    begin
        SETFILTER("Winner Movie Number", '<>%1', 0);
    end;

    var
        VTMMovie: Record "VTM Movie";
}

