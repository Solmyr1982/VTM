page 50353 "User Entity"
{
    Caption = 'User Entity';
    DelayedInsert = true;
    EntityName = 'userEntity';
    EntitySetName = 'userEntity';
    ODataKeyFields = ID;
    PageType = API;
    APIPublisher = 'VTM';
    APIGroup = 'VTM';
    SourceTable = "VTM User";
    SourceTableView = SORTING("User ID");
    APIVersion = 'beta';

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
                field(UserID; "User ID")
                {
                    Caption = 'UserID';
                }
                field(Administrator; Administrator)
                {
                    Caption = 'Administrator';
                }
                field(adminURL; AdminURL)
                {
                    Caption = 'adminURL';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        VTMSetup: Record "VTM Setup";
    begin
        CLEAR(AdminURL);
        IF Administrator THEN BEGIN
            VTMSetup.GET;
            AdminURL := VTMSetup."Admin URL";
        END;
    end;

    var
        AdminURL: Text;
}

