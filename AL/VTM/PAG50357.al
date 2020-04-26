page 50357 "Pool Line Entity"
{
    Caption = 'Pool Line Entity';
    DelayedInsert = true;
    EntityName = 'poolLineEntity';
    EntitySetName = 'poolLineEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Pool Line";
    SourceTableView = SORTING("Header Number", "Line No.");

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
                field(HeaderNumber; "Header Number")
                {
                    Caption = 'HeaderNumber';
                }
                field(LineNo; "Line No.")
                {
                    Caption = 'LineNo';
                }
                field(RoundNo; "Round No.")
                {
                    Caption = 'RoundNo';
                }
                field(LineType; "Line Type")
                {
                    Caption = 'LineType';
                }
                field(MovieNumber; "Movie Number")
                {
                    Caption = 'MovieNumber';
                }
                field(UserID; "User ID")
                {
                    Caption = 'UserID';
                }
                field(PromotionalAction; "Promotional Action")
                {
                    Caption = 'PromotionalAction';
                }
                field(PromotionalState; "Promotional State")
                {
                    Caption = 'PromotionalState';
                }
                field(PromotionalLineNumber; "Promotional Line Number")
                {
                    Caption = 'PromotionalLineNumber';
                }
            }
        }
    }

    actions
    {
    }
}

