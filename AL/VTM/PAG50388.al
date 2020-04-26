page 50388 "VTM Setup"
{
    Caption = 'VTM Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "VTM Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Posters Path"; "Posters Path")
                {
                }
                field("Resize Poster X"; "Resize Poster X")
                {
                }
                field("Resize Poster Y"; "Resize Poster Y")
                {
                }
                field("Site URL"; "Site URL")
                {
                }
                field("Admin URL"; "Admin URL")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TestDLL)
            {
                trigger OnAction()
                var
                    DownloadAndResize: DotNet DownloadAndResize;
                begin
                    DownloadAndResize := DownloadAndResize.DownloadAndResize;
                    DownloadAndResize.DownloadImage(
                      'http://solmyr.ddns.net/xvtm/posters/img/SoundVoice.jpg',
                      'c:\temp\',
                      '5',
                      400,
                      480);
                end;
            }
            action(FixInitialData)
            {
                trigger OnAction()
                var
                    FixVTMData: page 50370;
                begin
                    FixVTMData.FixPoolHeader();
                    FixVTMData.UserUp();
                end;
            }
            action(ResizePosters)
            {
                trigger OnAction()
                var
                    VTMMovie: Record 50350;
                    DownloadAndResize: DotNet DownloadAndResize;
                    VTMSetup: Record "VTM Setup";
                begin
                    // 725
                    // 1009
                    // 1021
                    //VTMMovie.SetFilter(Number, '>%1', 1021);
                    IF VTMMovie.FindSet() then
                        repeat
                            if (StrPos(VTMMovie.Poster, 'xvtm') <> 0) and
                                (VTMMovie.Number <> 725) and (VTMMovie.Number <> 1009)
                                and (VTMMovie.Number <> 1021)

                            then begin

                                VTMSetup.GET;
                                VTMSetup.TESTFIELD("Posters Path");
                                VTMSetup.TESTFIELD("Site URL");
                                VTMSetup.TESTFIELD("Resize Poster X");
                                VTMSetup.TESTFIELD("Resize Poster Y");
                                IF FILE.EXISTS(VTMSetup."Posters Path" + FORMAT(VTMMovie.Number) + '.jpg') THEN
                                    FILE.ERASE(VTMSetup."Posters Path" + FORMAT(VTMMovie.Number) + '.jpg');
                                DownloadAndResize := DownloadAndResize.DownloadAndResize;
                                DownloadAndResize.DownloadImage(
                                  VTMMovie.Poster,
                                  VTMSetup."Posters Path",
                                  FORMAT(VTMMovie.Number),
                                  VTMSetup."Resize Poster X",
                                  VTMSetup."Resize Poster Y");

                                IF FILE.EXISTS(VTMSetup."Posters Path" + FORMAT(VTMMovie.Number) + '.jpg') THEN BEGIN
                                    VTMMovie.Poster := VTMSetup."Site URL" + 'posters/' + FORMAT(VTMMovie.Number) + '.jpg';
                                    VTMMovie.MODIFY;
                                    //CurrPage.UPDATE(FALSE);
                                END ELSE
                                    ERROR('File not found.');

                            end;
                        until VTMMovie.Next() = 0;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        VTMRequestProcessor: Record "VTM Request Processor";
    begin
        IF NOT GET THEN
            INSERT;

        IF NOT VTMRequestProcessor.GET THEN BEGIN
            VTMRequestProcessor.ID := '{00000000-0000-0000-0000-000000000000}';
            VTMRequestProcessor.INSERT;
        END;
    end;
}

