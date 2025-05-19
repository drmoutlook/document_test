@workspace /explain
create a class diagram using mermaid js for the #pythan_exec_proc.sql
Add comment to the #pythan_exec_proc.sql
generate a mermaid entity relationship diagram for the schema defined in #file
generate a mermaid js user journey diagram for the file#pythian_exec_proc.sql

classDiagram
    class pythian_exec_proc {
        +varchar(64) @sp_name
        +int @v_debug = 0
        +int @proc_exec_status
        +varchar(200) @msg
        +executeProcedure()
        +printDebugMessages()
        +handleError()
    }

    class TargetProcedure {
        <<dynamic>>
        +int return_code
    }

    pythian_exec_proc "1" --> "1" TargetProcedure : executes dynamically










