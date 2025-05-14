```mermaid
erDiagram
    DEPT {
        NUMBER(2) DEPTNO PK
        VARCHAR2(14) DNAME
        VARCHAR2(13) LOC
    }
    EMP {
        NUMBER(4) EMPNO PK
        VARCHAR2(10) ENAME
        VARCHAR2(9) JOB
        NUMBER(4) MGR
        DATE HIREDATE
        NUMBER(7,2) SAL
        NUMBER(7,2) COMM
        NUMBER(2) DEPTNO FK
    }
    BONUS {
        VARCHAR2(10) ENAME
        VARCHAR2(9) JOB
        NUMBER SAL
        NUMBER COMM
    }
    SALGRADE {
        NUMBER GRADE
        NUMBER LOSAL
        NUMBER HISAL
    }

    DEPT ||--o{ EMP : "has"
    EMP }o--|| EMP : "manages"
    EMP }o--|| DEPT : "belongs to"
```