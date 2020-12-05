function djLookupSessionUI(uiSession)
    global state
    
    if nargin<1
       uiSession=state.session.uiSession;
    end
    
    if isempty(uiSession)
        error('djLookupSessionUI: Need to specific session ID to search for');
    end
    
    if ~state.database.useDatabase || ~state.database.connected
        disp('*** No database connection.  No uiSession lookup possible');
    end
  
    if isnumeric(uiSession)
        uiSession=num2str(uiSession);
    end
    
    queryString=strcat(...
        getenv('use_database'), ...
        '.Session & ''EXPERIMENT_ID=', ...
        uiSession, ...
        '''');
    disp(queryString);
    query=eval(queryString);
    
    if query.count==1
        disp(['Unique session found.  Reloading data of session ' num2str(uiSession)]);
        ff=query.header.names;
        for counter=1:length(ff)
           disp(ff{counter}) 
        end
        qData=query.fetch('*');
        state.session.uiMaterial=qData.mouse_id;
        updateGuiByGlobal('state.session.uiMaterial');
        state.session.description=qData.experiment_purpose;
        updateGuiByGlobal('state.session.description');
        state.session.uiSession=nan;
        updateGuiByGlobal('state.session.uiSession');
        state.session.user=qData.user;
        updateGuiByGlobal('state.session.user');
        state.user=state.session.user;
        updateGuiByGlobal('state.user');
    end
    
    