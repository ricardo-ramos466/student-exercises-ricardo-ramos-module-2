package com.techelevator.projects.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import com.techelevator.projects.model.Employee;
import org.springframework.jdbc.support.rowset.SqlRowSet;

public class JdbcEmployeeDao implements EmployeeDao {

	private final JdbcTemplate jdbcTemplate;

	public JdbcEmployeeDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public List<Employee> getAllEmployees() {
		List<Employee> employees = new ArrayList<>();
		String sql = "select * from employee ;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
		while (results.next()){
			employees.add(mapRowToEmployee(results));
		}
		return employees;
	}

	@Override
	public List<Employee> searchEmployeesByName(String firstNameSearch, String lastNameSearch) {
		List<Employee> employees = new ArrayList<>();
		String sql = "select * from employee where lower (first_name) like ? and lower (last_name) like ? ;";
		firstNameSearch= "%"+firstNameSearch.toLowerCase()+"%";
		lastNameSearch = "%"+lastNameSearch.toLowerCase()+"%";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql,firstNameSearch,lastNameSearch);
		while(results.next()){
			employees.add(mapRowToEmployee(results));
		}
		return employees;
	}

	@Override
	public List<Employee> getEmployeesByProjectId(int projectId) {
		List<Employee> employees = new ArrayList<>();
		String sql = "select * from employee e" +
				" join project_employee pe on pe.employee_id = e.employee_id" +
				" where pe.project_id = ? ;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql,projectId);
		while(results.next()){
			employees.add(mapRowToEmployee(results));
		}

		return employees;
	}

	@Override
	public void addEmployeeToProject(int projectId, int employeeId) {
		String sql = "INSERT INTO project_employee (project_id, employee_id) VALUES (?,?) ;";
		jdbcTemplate.update(sql,projectId,employeeId);
	}

	@Override
	public void removeEmployeeFromProject(int projectId, int employeeId) {
		String sql = "delete from project_employee where project_id = ? and employee_id = ? ;";
		jdbcTemplate.update(sql,projectId,employeeId);
	}

	@Override
	public List<Employee> getEmployeesWithoutProjects() {
		List<Employee> employees = new ArrayList<>();
		String sql = "select * from employee where employee_id not in (select employee_id from project_employee) ;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
		while (results.next()){
			employees.add(mapRowToEmployee(results));
		}
		return employees;
	}

	private Employee mapRowToEmployee(SqlRowSet rowSet){
		Employee employee = new Employee();
		employee.setId(rowSet.getInt("employee_id"));
		if (rowSet.getInt("department_id") != 0) {
			employee.setDepartmentId(rowSet.getInt("department_id"));
		}
		employee.setFirstName(rowSet.getString("first_name"));
		employee.setLastName(rowSet.getString("last_name"));
		employee.setBirthDate(rowSet.getDate("birth_date").toLocalDate());
		employee.setHireDate(rowSet.getDate("hire_date").toLocalDate());
		return employee;

	}

}
