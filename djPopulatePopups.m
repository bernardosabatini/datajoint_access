function djPopulatePopups

    global gh state
    
    keys=djGetTableKeys('User', 1, '', 1, 1);
    set(gh.sessionMetaData.uiUserSelection, 'String', keys);
    state.session.uiUserSelection=1;
    updateGuiByGlobal('state.session.uiUserSelection');
    
    keys=djGetTableKeys('Project', 1, 'project_name', 1, 1);
    set(gh.sessionMetaData.uiProjectSelection, 'String', keys);
    state.session.uiProjectSelection=1;
    updateGuiByGlobal('state.session.uiProjectSelection');
    
    keys=djGetTableKeys('Material', 1, '', 1, 1);
    set(gh.sessionMetaData.uiMaterialSelection, 'String', keys);
    state.session.uiMaterialSelection=1;
    updateGuiByGlobal('state.session.uiMaterialSelection');
    