function success=djMakeInactive(tableName, inactiveEntry, keyName)
% djNewUser : enter a user into the database
%           : assumes database is open

    success=0;

    if nargin<1
        error('must provice a table name');
    end
    

    if nargin<3
        additionalKeys=[];
    end
    
    if nargin<2
        error('must select an entry to inactive or enter [] to offer choices');
    end

    if isempty(inactiveEntry)
        if nargin<3 || isempty(keyName)
            error('must provide a key name to use for selections')
        else
            inactiveEntry=djInputValidChoice(tableName, keyName); 
            if isempty(inactiveEntry)
                error('Must select an entry to make inactive'); 
            end
        end
    end
    if isnumeric(inactiveEntry)
        inactiveEntry=num2str(inactiveEntry);
    else
        inactiveEntry=['''' inactiveEntry ''''];
    end
    
    insertString=strcat('insert(', ...
        getenv('use_database'), ...
        '.Inactive', ...
        tableName, ...
        ', {', ...
        inactiveEntry, ...
        '})' ...
        );
   
    disp(insertString)
    eval(insertString)
    success=1;
    
    