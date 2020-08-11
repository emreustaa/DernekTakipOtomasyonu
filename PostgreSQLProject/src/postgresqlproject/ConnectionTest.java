/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package postgresqlproject;

import java.sql.*;

/**
 *
 * @author emreu
 */
public class ConnectionTest {

  

    public static Connection getConnection() {
        Connection conn = null;
        try {
            /*Bağlantı kurulumu *****/
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project",
                    "postgres", "mysqlserver");
            if (conn != null) {
                System.out.println("Veritabanına bağlandı!");
            } else {
                System.out.println("Bağlantı girişimi başarısız!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }

}
