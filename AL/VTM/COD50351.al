codeunit 50351 "New Movie"
{

    trigger OnRun()
    var
        VTMMovie: Record "VTM Movie";
        VTMMovieCard: Page "VTM Movie Card";
        NewNumber: Integer;
    begin
        VTMMovie.FINDLAST;
        NewNumber := VTMMovie.Number + 1;
        VTMMovie.INIT;
        VTMMovie.Number := NewNumber;
        VTMMovie.INSERT;
        COMMIT;

        VTMMovieCard.SETRECORD(VTMMovie);
        VTMMovieCard.RUNMODAL;
    end;
}

