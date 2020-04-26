page 50370 "Fix VTM Data"
{
    Caption = 'Fix VTM Data';
    PageType = Card;

    layout
    {
        area(content)
        {

        }
    }

    actions
    {
        area(creation)
        {
            action("Pool Header")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    FixPoolHeader;
                end;
            }
            action(UserUppercase)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UserUp;
                end;
            }
            action(TestAL)
            {

                trigger OnAction()
                begin
                    PAGE.RUN(50361);
                end;
            }
        }
    }


    procedure FixPoolHeader()
    var
        VTMPoolHeader: Record "VTM Pool Header";
        VTMPoolHeader2: Record "VTM Pool Header";
        VTMPoolLine: Record "VTM Pool Line";
        TotalDuplicates: Integer;
        CandidatesForDeletion: Record "VTM Pool Header" temporary;
        CandidatesForSaving: Record "VTM Pool Header" temporary;
        FinalDeletion: Record "VTM Pool Header" temporary;
        Processed: Record "VTM Pool Header" temporary;
    begin
        IF VTMPoolHeader.FINDSET THEN
            REPEAT
                IF NOT Processed.GET(VTMPoolHeader.Number) THEN BEGIN
                    VTMPoolHeader2.SETRANGE("Batch Name", VTMPoolHeader."Batch Name");
                    VTMPoolHeader2.SETRANGE("Winner Movie Number", VTMPoolHeader."Winner Movie Number");
                    VTMPoolHeader2.SETFILTER(Number, '<>%1', VTMPoolHeader.Number);
                    IF VTMPoolHeader2.FINDSET THEN BEGIN
                        CandidatesForDeletion.DELETEALL;
                        CandidatesForSaving.DELETEALL;
                        //TotalDuplicates := VTMPoolHeader2.COUNT + 1;
                        VTMPoolLine.SETRANGE("Header Number", VTMPoolHeader.Number);
                        IF VTMPoolLine.ISEMPTY THEN BEGIN
                            CandidatesForDeletion.INIT;
                            CandidatesForDeletion.TRANSFERFIELDS(VTMPoolHeader);
                            CandidatesForDeletion.INSERT;
                        END ELSE BEGIN
                            CandidatesForSaving.INIT;
                            CandidatesForSaving.TRANSFERFIELDS(VTMPoolHeader);
                            CandidatesForSaving.INSERT;
                        END;

                        REPEAT
                            Processed.Number := VTMPoolHeader2.Number;
                            Processed.INSERT;
                            VTMPoolLine.SETRANGE("Header Number", VTMPoolHeader2.Number);
                            IF VTMPoolLine.ISEMPTY THEN BEGIN
                                CandidatesForDeletion.INIT;
                                CandidatesForDeletion.TRANSFERFIELDS(VTMPoolHeader2);
                                CandidatesForDeletion.INSERT;
                            END ELSE BEGIN
                                CandidatesForSaving.INIT;
                                CandidatesForSaving.TRANSFERFIELDS(VTMPoolHeader2);
                                CandidatesForSaving.INSERT;
                            END;
                        UNTIL VTMPoolHeader2.NEXT = 0;

                        IF CandidatesForSaving.COUNT > 1 THEN
                            ERROR('>1 ' + FORMAT(VTMPoolHeader."Winner Movie Number"));
                        IF CandidatesForSaving.COUNT = 0 THEN BEGIN
                            //ERROR('=0 ' + FORMAT(VTMPoolHeader."Winner Movie Number"));
                            CandidatesForDeletion.FINDFIRST;
                            CandidatesForDeletion.DELETE;
                        END;

                        IF CandidatesForDeletion.FINDSET THEN
                            REPEAT
                                FinalDeletion.INIT;
                                FinalDeletion.TRANSFERFIELDS(CandidatesForDeletion);
                                FinalDeletion.INSERT;
                            UNTIL CandidatesForDeletion.NEXT = 0;
                    END;
                END;
            UNTIL VTMPoolHeader.NEXT = 0;

        //MESSAGE(FORMAT(FinalDeletion.COUNT));
        IF FinalDeletion.FINDSET THEN
            REPEAT
                VTMPoolHeader.GET(FinalDeletion.Number);
                IF (VTMPoolHeader.Number <> 282) AND (VTMPoolHeader.Number <> 14923) AND
                  (VTMPoolHeader.Number <> 9398) AND (VTMPoolHeader.Number <> 9398)
                THEN
                    VTMPoolHeader.DELETE;
            UNTIL FinalDeletion.NEXT = 0;
    end;

    procedure UserUp()
    var
        VTMPoolHeader: Record "VTM Pool Header";
        VTMPoolLine: Record "VTM Pool Line";
        i: Integer;
        UserName: Text;
        FormatText: Text;
    begin
        FOR i := 1 TO 4 DO BEGIN
            CASE i OF
                1:
                    UserName := 'solmyr';
                2:
                    UserName := 'mifril';
                3:
                    UserName := 'bllondis';
                4:
                    UserName := 'kelmin';
            END;

            FormatText := COPYSTR(UserName, 1, 1);
            FormatText := UPPERCASE(FormatText);
            FormatText := COPYSTR(UserName, 2, STRLEN(UserName));

            VTMPoolHeader.SETRANGE("Initiated By User ID", UserName);
            VTMPoolHeader.MODIFYALL("Initiated By User ID", UPPERCASE(UserName));
            VTMPoolHeader.SETRANGE("Initiated By User ID", FormatText);
            VTMPoolHeader.MODIFYALL("Initiated By User ID", UPPERCASE(UserName));

            VTMPoolLine.SETRANGE("User ID", UserName);
            VTMPoolLine.MODIFYALL("User ID", UPPERCASE(UserName));
            VTMPoolLine.SETRANGE("User ID", FormatText);
            VTMPoolLine.MODIFYALL("User ID", UPPERCASE(UserName));
        END;
    end;
}

