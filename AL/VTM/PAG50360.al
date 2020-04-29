page 50360 "Pool Movie Entity"
{
    Caption = 'Pool Movie Entity';
    DelayedInsert = true;
    EntityName = 'poolMovieEntity';
    EntitySetName = 'poolMovieEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Movie";
    SourceTableTemporary = true;
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
                field(PoolHeaderNumber; "Pool Header Number")
                {
                    Caption = 'PoolHeaderNumber';
                }
                field(UserID; "User ID")
                {
                    Caption = 'UserID';
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

    trigger OnOpenPage()
    begin
        FillRecordSet;
    end;

    var
        Text001: Label 'Filter for %1 is empty. This API page can only be used for specific Pool.';

    local procedure FillRecordSet()
    var
        PoolHeaderNumberTxt: Text;
        PoolHeaderNumber: Integer;
        VTMPoolHeader: Record "VTM Pool Header";
        VTMMovie: Record "VTM Movie";
        VTMPoolHeader2: Record "VTM Pool Header";
        VTMMovieBatch: Record "VTM Movie Batch";
        VTMPoolLine: Record "VTM Pool Line";
        VTMUserBatch: Record "VTM User Batch";
        VTMUserBatchCount: Integer;
    begin
        PoolHeaderNumberTxt := GETFILTER("Pool Header Number");
        IF PoolHeaderNumberTxt = '' THEN
            ERROR(Text001, FIELDCAPTION("Pool Header Number"));
        EVALUATE(PoolHeaderNumber, PoolHeaderNumberTxt);
        VTMPoolHeader.GET(PoolHeaderNumber);
        RESET;

        VTMUserBatch.SETRANGE("Batch Name", VTMPoolHeader."Batch Name");
        VTMUserBatch.SETRANGE("Read Only", FALSE);
        VTMUserBatchCount := VTMUserBatch.COUNT;

        IF VTMPoolHeader."Current Round" = 1 THEN BEGIN
            IF VTMMovie.FINDSET THEN
                REPEAT
                    IF VTMMovieBatch.GET(VTMMovie.Number, VTMPoolHeader."Batch Name") THEN BEGIN
                        VTMPoolHeader2.SETRANGE("Winner Movie Number", VTMMovie.Number);
                        VTMPoolHeader2.SETRANGE("Batch Name", VTMPoolHeader."Batch Name");
                        IF VTMPoolHeader2.ISEMPTY THEN BEGIN
                            INIT;
                            TRANSFERFIELDS(VTMMovie);
                            INSERT;
                        END;
                    END;
                UNTIL VTMMovie.NEXT = 0
        END ELSE BEGIN
            VTMPoolLine.SETRANGE("Header Number", VTMPoolHeader.Number);
            VTMPoolLine.SETRANGE("Round No.", VTMPoolHeader."Current Round" - 1);
            IF VTMPoolLine.FINDSET THEN
                REPEAT
                    VTMMovie.GET(VTMPoolLine."Movie Number");
                    INIT;
                    TRANSFERFIELDS(VTMMovie);
                    IF VTMUserBatchCount > 1 THEN
                        "User ID" := VTMPoolLine."User ID";
                    IF NOT INSERT THEN BEGIN
                        "User ID" := '';
                        MODIFY;
                    END;
                UNTIL VTMPoolLine.NEXT = 0;
        END;
    end;
}

