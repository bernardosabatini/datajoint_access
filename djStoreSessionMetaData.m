function djStoreSessionMetaData
% djStoreSessionsMetaData attempt to store session meta data
    global state
        
    if ~state.database.useDatabase || ~state.database.connected
        disp('*** No database connection.  No uiSession lookup possible');
    end
    
%% get the maximum session ID so far  
    queryString=strcat(...
        getenv('use_database'), ...
        '.Session' ...
        );
    disp(queryString);
    query=eval(queryString);
    
    if query.count==0
        disp('No entries in session table');
        uiSession=1;
    else
        uisRaw=query.fetch;
        uisMax=max(struct2array(uisRaw));
        uiSession=uisMax+1;
    end
    
%% store the data in the new uiSession    
    disp(['   Will store as uiSession ' num2str(uiSession)]);
    outData=[];
    outData.experiment_id=uiSession;
    outData.user=state.session.user;
    dt=char(datetime);
    state.session.date=dt(1:strfind(dt, ' ')-1);
    state.session.time=dt(strfind(dt, ' ')+1:end);
    
    outData.date=state.session.date;
    outData.experiment_purpose=state.session.description;
    
    insertString=strcat(...
        'insert(',...
        getenv('use_database'), ...
        '.Session', ...
        ', outData)');
    disp(insertString)
    eval(insertString)

    state.session.uiSession=uiSession;
    updateGuiByGlobal('state.session.uiSession')
end
    

    