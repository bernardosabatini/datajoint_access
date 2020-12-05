%{
connectServer.m
Author MM893
6/24/2020 HMS RC

Description:
    will set secrets for logging into database.

Presumes DataJoint is already loaded / configured

%}
function success=djConnectServer()
    global state

    % Define login and connect to server
    setenv('DJ_HOST', state.database.dj_host)
    setenv('DJ_USER', state.database.dj_user)
    setenv('DJ_PASS', state.database.dj_pass)
    setenv('use_database', state.database.dj_useDatabase)

    %     setenv('DJ_HOST', 'sabatini-dj-prd01-instance-1.cjvmzxer50q5.us-east-1.rds.amazonaws.com'); %Host IP // Hostname
    %     setenv('DJ_USER', 'rcadmin'); %Username
    %     setenv('DJ_PASS', 'Zna2jEz4u2tJXqZAvwbL'); %Password-based Authentication

    success=0;
    state.database.connected=0;
    try
        disp("*** Connecting to database server...");
        dj.conn; %Initiate connection
    catch
        error("    Connection Error. Check network and connection settings.");
    end
    disp("      Connected.");
    state.database.connected=1;

    success=state.database.connected;
end
    