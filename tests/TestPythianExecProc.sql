CREATE PROCEDURE test_pythian_exec_proc
AS
BEGIN
    -- Arrange
    EXEC tSQLt.NewTestClass 'TestPythianExecProc';

    -- Act
    EXEC pythian_exec_proc;

    -- Assert
    EXEC tSQLt.AssertEquals 'ExpectedResult', 'ActualResult';
END;

EXEC tSQLt.CreateTest 'TestPythianExecProc.TestCase1', 'test_pythian_exec_proc';
EXEC tSQLt.CreateTest 'TestPythianExecProc.TestCase2', 'test_pythian_exec_proc';