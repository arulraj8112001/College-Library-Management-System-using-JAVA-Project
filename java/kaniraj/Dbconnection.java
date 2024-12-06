package kaniraj;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Dbconnection {
	private static final String url="jdbc:postgresql://localhost:5432/project";
	private static final String user="postgres";
	private static final String password="postgresql";
	public static Connection getConnection() throws SQLException
	{
		return DriverManager.getConnection(url,user,password);
	}

}
