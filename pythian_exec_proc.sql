/*
    Procedure: dbo.pythian_exec_proc
    Description:
        This stored procedure is designed to execute another stored procedure dynamically by its name.
        It provides debug messages and status updates during the execution process.

    Parameters:
        @sp_name (varchar(64)):
            The name of the stored procedure to be executed.
        @v_debug (INT, default = 0):
            A flag to enable or disable debug messages. 
            Set to 1 to enable debug messages, 0 to disable.

    Behavior:
        - Logs the start of the procedure execution.
        - Executes the specified stored procedure dynamically.
        - Logs debug messages and the return code if debug mode is enabled.
        - Handles success and error scenarios based on the return code:
            - If the return code is 0, logs a success message.
            - If the return code is non-zero, jumps to the error handler and logs an error message.
        - Returns 9999 in case of an error.

    Debugging:
        - When @v_debug is set to 1, additional debug messages are printed to provide insights into the execution flow.

    Example Usage:
        EXEC dbo.pythian_exec_proc @sp_name = 'testdb..example_proc', @v_debug = 1;

    Notes:
        - Ensure the stored procedure name passed in @sp_name is fully qualified (e.g., 'database.schema.proc_name').
        - The procedure assumes the executed stored procedure returns an integer status code.
*/
use testdb
go
drop Proc dbo.pythian_exec_proc
go
Create Proc dbo.pythian_exec_proc(@sp_name varchar(64),@v_debug INT = 0)
As
Begin
    DECLARE @msg varchar(200)
    DECLARE @proc_exec_status int
    --select @sp_name='testdb..print_test'
   
    SELECT @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', INFO, Procedure ' + @sp_name + ' execution started.'
    PRINT @msg
   
    SELECT @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', DEBUG, Procedure ' + @sp_name + ' executing.'
    IF CONVERT(INT,@v_debug) = 1  PRINT @msg
   
    EXECUTE @proc_exec_status=@sp_name
    SELECT @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', DEBUG, Return code: ' + CONVERT(VARCHAR,@proc_exec_status) + ' from executing Procedure ' + @sp_name    
    IF @v_debug = 1  PRINT @msg
   

    SELECT @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', DEBUG, Printing status on basis of the return code'  
    IF @v_debug = 1  PRINT @msg  
   
    IF @proc_exec_status=0
        begin
            SELECT @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', DEBUG, Return code is 0 so printing success messages.'  
            IF @v_debug = 1  PRINT @msg  
           
            SELECT @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', Procedure ' + @sp_name + ' execution completed.'
            PRINT @msg
        end
    else
        begin
            SELECT @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', DEBUG, Return code is non 0 so jump to error handler.  '
            IF @v_debug = 1  PRINT @msg  
            goto error_handler
        end
    return
error_handler:
    SELECT @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', DEBUG, Working on the error handler.'  
    IF @v_debug = 1 PRINT @msg  
    select @msg=CONVERT(VARCHAR, GETDATE(), 116) + ', Procedure ' + @sp_name + ' execution completed with error.'
    PRINT @msg
    return 9999
end
go