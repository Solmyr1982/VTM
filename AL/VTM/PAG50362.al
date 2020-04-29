page 50362 "Request Processor Entity"
{
    Caption = 'Request Processor Entity';
    DelayedInsert = true;
    EntityName = 'RequestProcessor';
    EntitySetName = 'RequestProcessor';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Request Processor";
    SourceTableView = SORTING(ID);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; ID)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Text001: Label 'You need to select %1 card(s).';
        Text002: Label 'You can not select the same movie as you selected in the first round.';
        Text003: Label 'You must select not less and not more than %1 movies.';
        Text004: Label 'There is already active pool: %1.';

    [ServiceEnabled]
    [Scope('Personalization')]
    procedure voteForMovie(poolNumber: Integer; movie1: Integer; movie2: Integer; movie3: Integer; movie4: Integer; movie5: Integer) outParam: Text
    var
        VTMPoolHeader: Record "VTM Pool Header";
        VTMUserBatch: Record "VTM User Batch";
        VTMPoolLine: Record "VTM Pool Line";
        NextLineNo: Integer;
        MoviesArray: array[6] of Integer;
        i: Integer;
    begin
        MoviesArray[1] := movie1;
        MoviesArray[2] := movie2;
        MoviesArray[3] := movie3;
        MoviesArray[4] := movie4;
        MoviesArray[5] := movie5;

        VTMPoolHeader.GET(poolNumber);
        VTMUserBatch.GET(USERID, VTMPoolHeader."Batch Name");

        VTMPoolLine.SETRANGE("Header Number", VTMPoolHeader.Number);
        IF VTMPoolLine.FINDLAST THEN
            NextLineNo := VTMPoolLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;

        ValidateMovies(poolNumber, MoviesArray, VTMPoolHeader."Current Round");
        CASE VTMPoolHeader."Current Round" OF
            1:
                AddPoolLine(5, NextLineNo, MoviesArray, VTMPoolHeader);
            2:
                AddPoolLine(2, NextLineNo, MoviesArray, VTMPoolHeader);
            3:
                AddPoolLine(1, NextLineNo, MoviesArray, VTMPoolHeader);
        END;

        outParam := NextRound(VTMPoolHeader);
    end;

    [ServiceEnabled]
    [Scope('Personalization')]
    procedure startNewPool(batchName: Text)
    var
        VTMPoolHeader: Record "VTM Pool Header";
        NewNo: Integer;
    begin
        VTMPoolHeader.SETRANGE("Batch Name", batchName);
        VTMPoolHeader.SETFILTER("Current Round", '<>%1', 0);
        IF VTMPoolHeader.FINDFIRST THEN
            ERROR(Text004, VTMPoolHeader.Number);

        VTMPoolHeader.RESET;
        IF VTMPoolHeader.FINDLAST THEN
            NewNo := VTMPoolHeader.Number + 1
        ELSE
            NewNo := 1;

        VTMPoolHeader.INIT;
        VTMPoolHeader.Number := NewNo;
        VTMPoolHeader."Batch Name" := batchName;
        VTMPoolHeader."Initiated By User ID" := USERID;
        VTMPoolHeader."Started At" := CREATEDATETIME(TODAY, TIME);
        VTMPoolHeader."Current Round" := 1;
        VTMPoolHeader.INSERT;
    end;


    [ServiceEnabled]
    [Scope('Personalization')]
    procedure setIMDB(movieNumber: Integer; imdbID: Text) outParam: Text
    var
        VTMMovie: Record "VTM Movie";

    begin
        VTMMovie.get(movieNumber);
        VTMMovie.IMDB := imdbID;
        VTMMovie.Modify();

        outParam := 'success';
    end;

    local procedure ValidateMovies(PoolNumber: Integer; MoviesArray: array[6] of Integer; CurrentRound: Integer)
    var
        VTMPoolLine: Record "VTM Pool Line";
        i: Integer;
        VTMPoolHeader: Record "VTM Pool Header";
        VTMUserBatch: Record "VTM User Batch";
        VTMUserBatchCount: Integer;
    begin
        CASE CurrentRound OF
            1:
                IF (MoviesArray[1] = 0) OR (MoviesArray[2] = 0) OR (MoviesArray[3] = 0) OR (MoviesArray[4] = 0) OR (MoviesArray[5] = 0) THEN
                    ERROR(Text003, 5);
            2:
                BEGIN
                    VTMPoolHeader.GET(PoolNumber);
                    VTMUserBatch.SETRANGE("Batch Name", VTMPoolHeader."Batch Name");
                    VTMUserBatch.SETRANGE("Read Only", FALSE);
                    VTMUserBatchCount := VTMUserBatch.COUNT;

                    IF (MoviesArray[1] = 0) OR (MoviesArray[2] = 0) OR (MoviesArray[3] <> 0) OR (MoviesArray[4] <> 0) OR (MoviesArray[5] <> 0) THEN
                        ERROR(Text003, 2);
                    FOR i := 1 TO 2 DO BEGIN
                        VTMPoolLine.SETRANGE("Header Number", PoolNumber);
                        VTMPoolLine.SETRANGE("Round No.", 1);
                        VTMPoolLine.SETRANGE("Movie Number", MoviesArray[i]);
                        IF VTMPoolLine.COUNT > 1 THEN
                            EXIT;
                        VTMPoolLine.FINDFIRST;
                        IF VTMUserBatchCount > 1 THEN
                            IF VTMPoolLine."User ID" = USERID THEN
                                ERROR(Text002);
                    END;
                END;
            3:
                IF (MoviesArray[1] = 0) OR (MoviesArray[2] <> 0) OR (MoviesArray[3] <> 0) OR (MoviesArray[4] <> 0) OR (MoviesArray[5] <> 0) THEN
                    ERROR(Text003, 1);
        END;
    end;

    procedure NextRound(VTMPoolHeader: Record "VTM Pool Header"): Text
    var
        VTMPoolLine: Record "VTM Pool Line";
        VTMUserBatch: Record "VTM User Batch";
    begin
        VTMUserBatch.SETRANGE("Batch Name", VTMPoolHeader."Batch Name");
        VTMUserBatch.SETRANGE("Read Only", FALSE);
        IF VTMUserBatch.FINDSET THEN
            REPEAT
                VTMPoolLine.SETRANGE("Header Number", VTMPoolHeader.Number);
                VTMPoolLine.SETRANGE("Round No.", VTMPoolHeader."Current Round");
                VTMPoolLine.SETRANGE("User ID", VTMUserBatch."User ID");
                IF VTMPoolLine.ISEMPTY THEN
                    EXIT('same');
            UNTIL VTMUserBatch.NEXT = 0;

        IF VTMPoolHeader."Current Round" = 3 THEN BEGIN
            FinalizePool(VTMPoolHeader);
            EXIT('finished');
        END ELSE BEGIN
            VTMPoolHeader."Current Round" += 1;
            VTMPoolHeader.MODIFY;
            EXIT('next');
        END;
    end;

    local procedure AddPoolLine(MoviesCount: Integer; NextLineNo: Integer; MoviesArray: array[6] of Integer; VTMPoolHeader: Record "VTM Pool Header")
    var
        VTMPoolLine: Record "VTM Pool Line";
        i: Integer;
    begin
        FOR i := 1 TO MoviesCount DO BEGIN
            IF MoviesArray[i] = 0 THEN
                ERROR(Text001, MoviesCount);
            VTMPoolLine.INIT;
            VTMPoolLine."Header Number" := VTMPoolHeader.Number;
            VTMPoolLine."Line No." := NextLineNo;
            VTMPoolLine."Round No." := VTMPoolHeader."Current Round";
            VTMPoolLine."Movie Number" := MoviesArray[i];
            VTMPoolLine."User ID" := USERID;
            VTMPoolLine."Created At" := CREATEDATETIME(TODAY, TIME);
            VTMPoolLine.INSERT;
            NextLineNo += 10000;
        END;
    end;

    local procedure FinalizePool(VTMPoolHeader: Record "VTM Pool Header")
    begin
        VTMPoolHeader."Current Round" := 0;
        VTMPoolHeader."Winner Movie Number" := DetermineWinner(VTMPoolHeader);
        VTMPoolHeader."Finished At" := CREATEDATETIME(TODAY, TIME);
        VTMPoolHeader.MODIFY;
    end;

    local procedure DetermineWinner(VTMPoolHeader: Record "VTM Pool Header"): Integer
    var
        VTMPoolLine: Record "VTM Pool Line";
        VTMMovieTemp: Record "VTM Movie" temporary;
        MaxSelected: Integer;
    begin
        VTMPoolLine.SETRANGE("Header Number", VTMPoolHeader.Number);
        VTMPoolLine.SETRANGE("Round No.", 3);
        MaxSelected := 1;
        IF VTMPoolLine.FINDSET THEN
            REPEAT
                IF VTMMovieTemp.GET(VTMPoolLine."Movie Number") THEN BEGIN
                    VTMMovieTemp.Selected += 1;
                    VTMMovieTemp.MODIFY;
                    IF MaxSelected < VTMMovieTemp.Selected THEN
                        MaxSelected := VTMMovieTemp.Selected;
                END ELSE BEGIN
                    VTMMovieTemp.INIT;
                    VTMMovieTemp.Number := VTMPoolLine."Movie Number";
                    VTMMovieTemp.Selected := 1;
                    VTMMovieTemp.INSERT;
                END;
            UNTIL VTMPoolLine.NEXT = 0;

        IF VTMMovieTemp.COUNT = 1 THEN
            EXIT(VTMMovieTemp.Number);

        VTMMovieTemp.SETFILTER(Selected, '<%1', MaxSelected);
        VTMMovieTemp.DELETEALL;
        VTMMovieTemp.RESET;
        VTMMovieTemp.FINDSET;
        REPEAT
            VTMMovieTemp."Random Number" := RANDOM(1000);
            VTMMovieTemp.MODIFY;
        UNTIL VTMMovieTemp.NEXT = 0;

        VTMMovieTemp.SETCURRENTKEY("Random Number");
        VTMMovieTemp.FINDLAST;
        EXIT(VTMMovieTemp.Number);
    end;
}

