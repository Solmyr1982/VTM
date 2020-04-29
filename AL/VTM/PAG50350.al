page 50350 "Movie Entity"
{
    Caption = 'Movie Entity';
    DelayedInsert = true;
    EntityName = 'movieEntity';
    EntitySetName = 'movieEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Movie";
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
                field(MovieNumber; Number)
                {
                    Caption = 'MovieNumber';
                }
                field(Poster; Poster)
                {
                    Caption = 'Poster';
                }
                field(WIKI; WIKI)
                {
                    Caption = 'WIKI';
                }
                field(Trailer; Trailer)
                {
                    Caption = 'Trailer';
                }
                field(NameENU; "Name ENU")
                {
                    Caption = 'NameENU';
                }
                field(NameRU; "Name RU")
                {
                    Caption = 'NameRU';
                }
                field(RelationNumber; "Relation Number")
                {
                    Caption = 'RelationNumber';
                }
                field("Part"; Part)
                {
                    Caption = 'Part';
                }
                field(Series; Series)
                {
                    Caption = 'Series';
                }
                field(IMDB; IMDB)
                {
                    Caption = 'IMDB';
                }
            }
        }
    }

    actions
    {
    }
}

