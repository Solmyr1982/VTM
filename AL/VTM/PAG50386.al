page 50386 "VTM Movie Card"
{
    Caption = 'VTM Movie Card';
    PageType = Card;
    SourceTable = "VTM Movie";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Number; Number)
                {
                    Editable = false;
                }
                field("Name ENU"; "Name ENU")
                {
                }
                field("Name RU"; "Name RU")
                {
                }
                field(WIKI; WIKI)
                {
                }
                field(IMDB; IMDB)
                {
                }
                field(Trailer; Trailer)
                {
                }
                field(Source; Source)
                {

                }
                field("Added On"; "Added On")
                {

                }
                field(Poster; Poster)
                {

                    trigger OnValidate()
                    begin
                        ValidatePoster;
                    end;
                }
                field("Relation Number"; "Relation Number")
                {
                }
                field("Part"; Part)
                {
                }
                field(Series; Series)
                {
                }
                field("Poster Blob"; "Poster Blob")
                {
                    ShowCaption = false;
                }
            }
            part(VTMBatchSubpage; 50387)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.VTMBatchSubpage.PAGE.UpdateRecordSet(Number);
        GetImage;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        VTMMovie: Record "VTM Movie";
    begin
        IF Number = 0 THEN BEGIN
            VTMMovie.FINDLAST;
            Number := VTMMovie.Number + 1;
            CurrPage.VTMBatchSubpage.PAGE.UpdateRecordSet(Number);
            CurrPage.UPDATE(FALSE);
        END;
    end;

    var
        Text001: Label 'File not created.';

    local procedure GetImage()
    var
        VTMSetup: Record "VTM Setup";
    begin
        VTMSetup.GET;
        IF VTMSetup."Posters Path" <> '' THEN
            IF FILE.EXISTS(VTMSetup."Posters Path" + FORMAT(Number) + '.jpg') THEN BEGIN
                "Poster Blob".IMPORT(VTMSetup."Posters Path" + FORMAT(Number) + '.jpg');
                CALCFIELDS("Poster Blob");
            END;
    end;

    local procedure ValidatePoster()
    var
        DownloadAndResize: DotNet DownloadAndResize;
        VTMSetup: Record "VTM Setup";
    begin
        IF Poster = '' THEN
            EXIT;

        VTMSetup.GET;
        VTMSetup.TESTFIELD("Posters Path");
        VTMSetup.TESTFIELD("Site URL");
        VTMSetup.TESTFIELD("Resize Poster X");
        VTMSetup.TESTFIELD("Resize Poster Y");
        IF FILE.EXISTS(VTMSetup."Posters Path" + FORMAT(Number) + '.jpg') THEN
            FILE.ERASE(VTMSetup."Posters Path" + FORMAT(Number) + '.jpg');
        DownloadAndResize := DownloadAndResize.DownloadAndResize;
        DownloadAndResize.DownloadImage(
          Poster,
          VTMSetup."Posters Path",
          FORMAT(Number),
          VTMSetup."Resize Poster X",
          VTMSetup."Resize Poster Y");

        IF FILE.EXISTS(VTMSetup."Posters Path" + FORMAT(Number) + '.jpg') THEN BEGIN
            Poster := VTMSetup."Site URL" + 'posters/' + FORMAT(Number) + '.jpg';
            MODIFY;
            CurrPage.UPDATE(FALSE);
        END ELSE
            ERROR(Text001);
    end;
}

