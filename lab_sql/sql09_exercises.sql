/*
 * 연습문제
 * - hr 계정으로 접속
 * - hr.sql 스크립트를 실행
 * - hr 계정의 테이블 내용을 파악
 * - 연습문제들에서 직원의 이름은 이름(first_name)과 성(last_name)을 붙여서 하나의 컬럼으로 출력.
 *   (예) Steven King
 */

-- 1. 직원의 이름과 부서 이름을 출력. (inner join)
select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    d.department_name
from employees e
    join departments d on e.department_id = d.department_id
;

select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- 2. 직원의 이름과 부서 이름을 출력. 부서 번호가 없는 직원도 출력.
select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    d.department_name
from employees e
    left join departments d on e.department_id = d.department_id
;

select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- 3. 직원의 이름과 직무 이름(job title)을 출력.
select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    j.job_title
from employees e
    join jobs j on e.job_id = j.job_id;

select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    j.job_title
from employees e, jobs j
where e.job_id = j.job_id
order by e.employee_id;

-- 4. 직원의 이름과 직원이 근무하는 도시 이름(city)를 출력.
select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    l.city
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
order by e.employee_id;

select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
    and d.location_id = l.location_id
order by e.employee_id;

-- 5. 직원의 이름과 직원이 근무하는 도시 이름(city)를 출력. 근무 도시를 알 수 없는 직원도 출력.
select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    l.city
from employees e
    left join departments d on e.department_id = d.department_id
    left join locations l on d.location_id = l.location_id
order by e.employee_id;

select 
    e.first_name || ' ' || e.last_name as "EMP_NAME",
    l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
    and d.location_id = l.location_id(+)
order by e.employee_id;

-- 6. 2008년에 입사한 직원들의 이름을 출력.
select 
    e.first_name || ' ' || e.last_name as "EMP_NAME", 
    e.hire_date
from employees e
where e.hire_date between to_date('2008/01/01', 'YYYY/MM/DD') and 
                        to_date('2008/12/31', 'YYYY/MM/DD');

select 
    e.first_name || ' ' || e.last_name as "EMP_NAME", 
    e.hire_date, e.department_id
from employees e
where to_char(e.hire_date, 'YYYY') = '2008';

-- 7. 2008년에 입사한 직원들의 부서 이름과 부서별 인원수 출력.
select
    d.department_name, count(e.employee_id) as "COUNT"
from employees e
    join departments d on e.department_id = d.department_id
where to_char(e.hire_date, 'YYYY') = '2008'
group by d.department_name;

select
    d.department_name, count(e.employee_id) as "COUNT"
from employees e, departments d
where e.department_id = d.department_id
    and to_char(e.hire_date, 'YYYY') = '2008'
group by d.department_name;

-- 8. 2008년에 입사한 직원들의 부서 이름과 부서별 인원수 출력. 
--    단, 부서별 인원수가 5명 이상인 경우만 출력.
select
    d.department_name, count(e.employee_id) as "COUNT"
from employees e
    join departments d on e.department_id = d.department_id
where to_char(e.hire_date, 'YYYY') = '2008'
group by d.department_name
having count(e.employee_id) >= 5;

-- 9. 부서번호, 부서별 급여 평균을 검색. 소숫점 한자리까지 반올림 출력.
select
    department_id, round(avg(salary), 1) as "AVG_SAL"
from employees
group by department_id
order by department_id;

-- 10. 부서별 급여 평균이 최대인 부서의 부서번호, 급여 평균을 출력.
-- (1) having 절과 서브쿼리 사용
select
    department_id, round(avg(salary), 1) as "AVG_SAL"
from employees
group by department_id
having avg(salary) = (
    select max(avg(salary))
    from employees
    group by department_id
);

-- (2) from 절에서의 서브쿼리 사용
select
    max(t.AVG_SAL)
from (
    select department_id, round(avg(salary), 1) as "AVG_SAL"
    from employees
    group by department_id
) t;

-- (3) with 식별자 as (서브쿼리) 사용
with t as (
    select department_id, round(avg(salary), 1) as "AVG_SAL"
    from employees
    group by department_id
)
select t.department_id, t."AVG_SAL" 
from t
where t."AVG_SAL" = (
    select max(t."AVG_SAL") from t
);

-- 11. 사번, 직원 이름, 국가 이름, 급여 출력.
-- 12. 국가이름, 국가별 급여 합계 출력.
-- 13. 사번, 직원이름, 직무 이름, 급여를 출력.
-- 14. 직무 이름, 직무별 급여 평균, 최솟값, 최댓값을 출력.
-- 15. 국가 이름, 직무 이름, 국가별 직무별 급여 평균을 출력.
-- 16. 국가 이름, 직무 이름, 국가별 직무별 급여 합계을 출력.
--     미국에서, 국가별 직무별 급여 합계가 50,000 이상인 레코드만 출력.
