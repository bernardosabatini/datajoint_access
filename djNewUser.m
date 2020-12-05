function success=djNewUser
% djNewUser : enter a user into the database
%           : assumes database is open

    success=0;
    newUser=[];
    newUser.username=lower(input('Enter username (ecommons id): ', 's'));
    if isempty(newUser.username) error('Must enter a ecommons id'); end

    queryString=strcat(...
        getenv('use_database'), ...
        '.User&''USERNAME=''''', ...
        newUser.username, ...
        '''''''' ...
        );
%    disp(queryString)
    query=eval(queryString);
    if query.count~=0
        error('username is already in use');
    end
    
    newUser.first_name=formatFirst(input('Enter first name: ', 's'));
    if isempty(newUser.first_name) error('Must enter a first name'); end
    
    newUser.last_name=formatFirst(input('Enter last name: ', 's'));
    if isempty(newUser.last_name) error('Must enter a last name'); end
    
    newUser.start_date=input('Enter start date (YYYY-MM-DD) (return for today): ', 's');
    if isempty(newUser.start_date)
        disp('Using today')
        d=char(datetime);
        newUser.start_date=d(1:strfind(d, ' ')-1);
    end

    disp(newUser)

    yn=input('Is the information correct? Confirm entry to database (y/n): ','s');
    yn=lower(yn);
    if ~isempty(yn)
        if yn(1)=='y'
        insertString=strcat('insert(', ...
            getenv('use_database'), ...
            '.User, newUser)' ...
            );
%        disp(insertString)
        eval(insertString);
        success=1;
        end
    end

    if success==0
        disp('User not entered')
    end
end

function ss=formatFirst(s)
    ss='';
    if ~isempty(s)
        ss=lower(s);
        ss(1)=upper(ss(1));
    end
end