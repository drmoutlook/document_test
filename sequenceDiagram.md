sequenceDiagram
    participant User
    participant pythian_exec_proc
    participant TargetProcedure

    User->>pythian_exec_proc: Call with @sp_name, @v_debug
    pythian_exec_proc->>pythian_exec_proc: Log start message (@msg)
    alt Debug enabled (@v_debug = 1)
        pythian_exec_proc->>pythian_exec_proc: Print debug message (@msg)
    end
    pythian_exec_proc->>TargetProcedure: Execute procedure by @sp_name
    TargetProcedure-->>pythian_exec_proc: Return status code (@proc_exec_status)
    alt Debug enabled (@v_debug = 1)
        pythian_exec_proc->>pythian_exec_proc: Print return code debug message
    end
    pythian_exec_proc->>pythian_exec_proc: Check @proc_exec_status
    alt Success (@proc_exec_status = 0)
        alt Debug enabled
            pythian_exec_proc->>pythian_exec_proc: Print success debug message
        end
        pythian_exec_proc->>pythian_exec_proc: Log completion message
    else Error (@proc_exec_status != 0)
        alt Debug enabled
            pythian_exec_proc->>pythian_exec_proc: Print error debug message
        end
        pythian_exec_proc->>pythian_exec_proc: Handle error, return 9999
    end