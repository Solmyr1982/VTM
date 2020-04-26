page 50380 "VTM Role Center"
{
    Caption = 'VTM Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(RoleCenterValues; 50390)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(New)
            {
                RunObject = Codeunit 50351;
            }
            action(List)
            {
                RunObject = Page 50385;
            }
        }
    }
}

