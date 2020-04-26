page 50387 "VTM Batch Subpage"
{
    Caption = 'VTM Batch Subpage';
    PageType = ListPart;
    SourceTable = "VTM Batch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Name)
                {
                }
                field(Selected; Selected)
                {
                    Caption = 'Selected';

                    trigger OnValidate()
                    begin
                        ValidateSelected;
                    end;
                }
                field(WatchedAtDate; WatchedDate)
                {
                    Caption = 'Watched At Date';

                    trigger OnValidate()
                    begin
                        ValidateDate;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        VTMMovieBatch: Record "VTM Movie Batch";
        VTMPoolHeader: Record "VTM Pool Header";
    begin
        CLEAR(Selected);
        CLEAR(WatchedDate);
        IF VTMMovieBatch.GET(MovieNumber, Name) THEN
            Selected := TRUE;

        VTMPoolHeader.SETRANGE("Batch Name", Name);
        VTMPoolHeader.SETRANGE("Winner Movie Number", MovieNumber);
        IF VTMPoolHeader.FINDFIRST THEN
            WatchedDate := DT2DATE(VTMPoolHeader."Finished At");
    end;

    var
        Selected: Boolean;
        WatchedDate: Date;
        MovieNumber: Integer;
        Text001: Label 'Do you want to delete existing Pool %1?';

    procedure UpdateRecordSet(InMovieNumber: Integer)
    begin
        MovieNumber := InMovieNumber;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ValidateSelected()
    var
        VTMMovieBatch: Record "VTM Movie Batch";
    begin
        IF MovieNumber = 0 THEN
            EXIT;

        IF NOT Selected THEN BEGIN
            IF VTMMovieBatch.GET(MovieNumber, Name) THEN
                VTMMovieBatch.DELETE;
        END ELSE
            IF NOT VTMMovieBatch.GET(MovieNumber, Name) THEN BEGIN
                VTMMovieBatch.INIT;
                VTMMovieBatch."Batch Name" := Name;
                VTMMovieBatch."Movie Number" := MovieNumber;
                VTMMovieBatch.INSERT;
            END;

        CurrPage.UPDATE(FALSE);
    end;

    local procedure ValidateDate()
    var
        VTMPoolHeader: Record "VTM Pool Header";
        NextNo: Integer;
    begin
        IF MovieNumber = 0 THEN
            EXIT;

        VTMPoolHeader.SETRANGE("Batch Name", Name);
        VTMPoolHeader.SETRANGE("Winner Movie Number", MovieNumber);
        IF WatchedDate = 0D THEN BEGIN
            IF VTMPoolHeader.FINDFIRST THEN
                IF CONFIRM(STRSUBSTNO(Text001, VTMPoolHeader.Number), FALSE) THEN
                    VTMPoolHeader.DELETE;
        END ELSE BEGIN
            IF VTMPoolHeader.FINDFIRST THEN BEGIN
                VTMPoolHeader."Finished At" := CREATEDATETIME(WatchedDate, 0T);
                VTMPoolHeader.MODIFY;
            END ELSE BEGIN
                VTMPoolHeader.RESET;
                IF VTMPoolHeader.FINDLAST THEN
                    NextNo := VTMPoolHeader.Number + 1
                ELSE
                    NextNo := 1;

                VTMPoolHeader.INIT;
                VTMPoolHeader.Number := NextNo;
                VTMPoolHeader."Batch Name" := Name;
                VTMPoolHeader."Initiated By User ID" := USERID;
                VTMPoolHeader."Started At" := CREATEDATETIME(TODAY, 0T);
                VTMPoolHeader."Finished At" := CREATEDATETIME(WatchedDate, 0T);
                VTMPoolHeader."Winner Movie Number" := MovieNumber;
                VTMPoolHeader.INSERT;
            END;
        END;
        CurrPage.UPDATE(FALSE);
    end;
}

