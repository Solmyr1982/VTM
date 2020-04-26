page 50385 "VTM Movie List"
{
    Caption = 'VTM Movie List';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "VTM Movie";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Name ENU"; "Name ENU")
                {
                }
                field("Name RU"; "Name RU")
                {
                }
                field(Poster; Poster)
                {
                }
                field(WIKI; WIKI)
                {
                }
                field(Trailer; Trailer)
                {
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
                field(Number; Number)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Card)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    RunCardAction;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETCURRENTKEY("Name ENU");
    end;

    local procedure RunCardAction()
    var
        VTMMovieCard: Page "VTM Movie Card";
    begin
        VTMMovieCard.SETRECORD(Rec);
        VTMMovieCard.RUNMODAL;
    end;
}

