page 50390 "VTM Role Center Values"
{
    Caption = 'VTM Role Center Values';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "VTM Role Center Cue";

    layout
    {
        area(content)
        {
            cuegroup(SalesCueContainer)
            {
                field(Movies; Movies)
                {
                }
                field(Batches; Batches)
                {
                }
                field(Relations; Relations)
                {
                }
                field(Users; Users)
                {
                }
                field("User Batches"; "User Batches")
                {
                }
                field(Pools; Pools)
                {
                }
                field(Setup; Setup)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF NOT GET THEN
            INSERT;
    end;
}

