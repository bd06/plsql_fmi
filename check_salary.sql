CREATE OR REPLACE PROCEDURE check_salary
(p_job_id IN jobs.job_id%type)
IS
	v_min_salary_bound jobs.min_salary%type;
	v_max_salary_bound jobs.max_salary%type;
    v_job_title jobs.job_title%type;
BEGIN
	SELECT min_salary, max_salary INTO v_min_salary_bound, v_max_salary_bound
	FROM jobs WHERE job_id = p_job_id;

	FOR curs in (SELECT first_name, last_name, job_id, salary FROM employees)
	LOOP
        DBMS_OUTPUT.PUT_LINE(v_min_salary_bound || ' ' || v_max_salary_bound || ' ' || curs.salary);
		if curs.salary >= v_min_salary_bound AND curs.salary <= v_max_salary_bound THEN
            DBMS_OUTPUT.PUT_LINE(curs.first_name || ' ' || curs.last_name || ', salary: ' || curs.salary);
        ELSE
            SELECT job_title INTO v_job_title
            FROM jobs WHERE JOB_ID = curs.job_id;
            DBMS_OUTPUT.PUT_LINE(curs.first_name || ' ' || curs.last_name || ', job title: ' || v_job_title);
        END IF;
	END LOOP;
END check_salary;
/
