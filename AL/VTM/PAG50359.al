page 50359 "Batch Pool Entity"
{
    Caption = 'Batch Pool Entity';
    DelayedInsert = true;
    EntityName = 'batchPoolEntity';
    EntitySetName = 'batchPoolEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Batch";
    SourceTableTemporary = true;
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
                field(PoolNumber; VTMPoolHeader.Number)
                {
                    Caption = 'PoolNumber';
                }
                field(InitiatedByUserID; VTMPoolHeader."Initiated By User ID")
                {
                    Caption = 'InitiatedByUserID';
                }
                field(StartedAt; VTMPoolHeader."Started At")
                {
                    Caption = 'StartedAt';
                }
                field(FinishedAt; VTMPoolHeader."Finished At")
                {
                    Caption = 'FinishedAt';
                }
                field(WinnerMovieNumber; VTMPoolHeader."Winner Movie Number")
                {
                    Caption = 'WinnerMovieNumber';
                }
                field(CurrentRound; VTMPoolHeader."Current Round")
                {
                    Caption = 'CurrentRound';
                }
                field(UserID; "User ID")
                {
                    Caption = 'UserID';
                }
                field(Admin; Admin)
                {
                    Caption = 'Admin';
                }
                field(Movie1; Movie1)
                {
                    Caption = 'Movie1';
                }
                field(Movie2; Movie2)
                {
                    Caption = 'Movie2';
                }
                field(Movie3; Movie3)
                {
                    Caption = 'Movie3';
                }
                field(Movie4; Movie4)
                {
                    Caption = 'Movie4';
                }
                field(Movie5; Movie5)
                {
                    Caption = 'Movie5';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        VTMUser: Record "VTM User";
        VTMPoolLine: Record "VTM Pool Line";
        i: Integer;
    begin
        CLEAR(VTMPoolHeader);
        CLEAR(Movie1);
        CLEAR(Movie2);
        CLEAR(Movie3);
        CLEAR(Movie4);
        CLEAR(Movie5);
        CLEAR(Admin);
        VTMPoolHeader.SETRANGE("Batch Name", Name);
        VTMPoolHeader.SETRANGE("Winner Movie Number", 0);
        IF NOT VTMPoolHeader.FINDLAST THEN BEGIN
            VTMPoolHeader.SETRANGE("Winner Movie Number");
            VTMPoolHeader.SetCurrentKey("Finished At");
            IF VTMPoolHeader.FINDLAST THEN;
        END ELSE BEGIN
            VTMPoolLine.SETRANGE("Header Number", VTMPoolHeader.Number);
            VTMPoolLine.SETRANGE("User ID", USERID);
            VTMPoolLine.SETRANGE("Round No.", VTMPoolHeader."Current Round");
            i := 1;
            IF VTMPoolLine.FINDSET THEN
                REPEAT
                    CASE i OF
                        1:
                            Movie1 := VTMPoolLine."Movie Number";
                        2:
                            Movie2 := VTMPoolLine."Movie Number";
                        3:
                            Movie3 := VTMPoolLine."Movie Number";
                        4:
                            Movie4 := VTMPoolLine."Movie Number";
                        5:
                            Movie5 := VTMPoolLine."Movie Number";
                    END;
                    i += 1;
                UNTIL VTMPoolLine.NEXT = 0;
        END;

        IF VTMUser.GET("User ID") THEN
            Admin := VTMUser.Administrator;
    end;

    trigger OnOpenPage()
    begin
        FillRecordSet;
    end;

    var
        VTMPoolHeader: Record "VTM Pool Header";
        Admin: Boolean;
        Movie1: Integer;
        Movie2: Integer;
        Movie3: Integer;
        Movie4: Integer;
        Movie5: Integer;

    local procedure FillRecordSet()
    var
        UserFilter: Text;
        VTMUserBatch: Record "VTM User Batch";
        VTMBatch: Record "VTM Batch";
    begin
        UserFilter := GETFILTER("User ID");
        IF UserFilter <> '' THEN BEGIN
            VTMUserBatch.SETRANGE("User ID", UserFilter);
            IF VTMUserBatch.FINDSET THEN
                REPEAT
                    VTMBatch.GET(VTMUserBatch."Batch Name");
                    INIT;
                    TRANSFERFIELDS(VTMBatch);
                    "User ID" := UserFilter;
                    INSERT;
                UNTIL VTMUserBatch.NEXT = 0;
        END ELSE
            IF VTMBatch.FINDSET THEN
                REPEAT
                    INIT;
                    TRANSFERFIELDS(VTMBatch);
                    INSERT;
                UNTIL VTMBatch.NEXT = 0;
    end;
}

