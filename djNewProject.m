function success=djNewProject
% djNewUser : enter a user into the database
%           : assumes database is open

    success=0;
    newProject=[];
    disp('NEW PROJECT ENTRY')
    disp('Who created the project?')
    
    newProject.project_creator=djInputValidChoice('User', 'username'); 
    if isempty(newProject.project_creator)
        error('Must select a valid user'); 
    end
    
    newProject.project_name=input('Enter the project name: ', 's');
    
    if isempty(newProject.project_name) 
        error('Must enter a project name'); 
    end
    
    newProject.project_description=input('Enter a decription: ', 's');
    if isempty(newProject.project_description) 
        error('Must enter a description'); 
    end
    
    newProject.project_date=input('Enter start date (YYYY-MM-DD) (return for today): ', 's');
    if isempty(newProject.project_date)
        disp('Using today')
        d=char(datetime);
        newProject.project_date=d(1:strfind(d, ' ')-1);
    end

    disp(newProject)

    yn=input('Is the information correct? Confirm entry to database (y/n): ','s');
    yn=lower(yn);
    if ~isempty(yn)
        if yn(1)=='y'
            insert(sabatini_prod.Project, newProject);
            success=1;
        end
    end

    if success==0
        disp('User not entered')
    end
end
