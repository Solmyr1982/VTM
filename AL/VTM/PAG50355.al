page 50355 "Relation Entity"
{
    Caption = 'Relation Entity';
    DelayedInsert = true;
    EntityName = 'relationEntity';
    EntitySetName = 'relationEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM Relation";
    SourceTableView = SORTING(Number);

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
                field(Number; Number)
                {
                    Caption = 'Number';
                }
                field(Description; Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }

    actions
    {
    }
}

