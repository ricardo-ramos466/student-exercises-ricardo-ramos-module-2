package com.techelevator.projects.dao;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.projects.model.Department;

public class JdbcDepartmentDao implements DepartmentDao {
	
	private final JdbcTemplate jdbcTemplate;

	public JdbcDepartmentDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public Department getDepartment(int id) {
		Department department = null;
		String sql = "Select department_id, name from department where department_id = ? ;";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql,id);
		if (results.next()) {
			department = mapRowToDepartment(results);
		}
		return department;
	}

	@Override
	public List<Department> getAllDepartments() {
		List<Department> departments =new ArrayList<>();
		String sql = "select * from department";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
		while(results.next()){
			departments.add(mapRowToDepartment(results));
		}
		return departments;
	}

	@Override
	public void updateDepartment(Department updatedDepartment) {
		String sql = "update department set name = ? where department_id = ? ;";
		jdbcTemplate.update(sql,updatedDepartment.getName(),updatedDepartment.getId());
	}
 	private Department mapRowToDepartment(SqlRowSet rowSet){
		Department department = new Department();
		department.setId(rowSet.getInt("department_id"));
		department.setName(rowSet.getString("name"));
		return department;
	}
}
