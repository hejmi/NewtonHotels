package MarcusMicke;

import javafx.fxml.FXML;
import javafx.scene.control.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.Properties;

public class Controller {

    @FXML DatePicker dateSearch;
    @FXML TextField numNightsText;
    @FXML ListView lw_SearchResults;

    public static Properties getConnectionData() {
        Properties props = new Properties();
        String fileName = "src/MarcusMicke/db.properties";
        try (FileInputStream in = new FileInputStream(fileName)) {
            props.load(in);
        } catch (IOException ex) {

        }
        return props;
    }

    public void searchAvailableRooms() {
        if (dateSearch.getValue() != null && Integer.parseInt(numNightsText.getText()) > 0) {
            if (dateSearch.getValue().isBefore(LocalDate.now())) dateSearch.setValue(LocalDate.now());
            Connection conn = null;
            Statement stmt = null;
            try {
                Properties props = getConnectionData();
                String url = props.getProperty("db.url");
                String username = props.getProperty("db.user");
                String password = props.getProperty("db.pass");
                String myDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
                Class.forName(myDriver);

                conn = DriverManager.getConnection(url, username, password);
                if (conn != null) {
                    stmt = conn.createStatement();
                    String sql;
                    sql = "EXEC CheckAvailableRooms @from='"+dateSearch.getValue()+"', @nights="+numNightsText.getText();
                    ResultSet rs = stmt.executeQuery(sql);
                    lw_SearchResults.getItems().clear();
                    lw_SearchResults.setVisible(true);
                    while (rs.next()) {
                        lw_SearchResults.getItems().add(rs.getString("Rum") + " \t" + rs.getInt("Pris") + ":- \t\t" + rs.getString("Rumstyp"));
                    }
                }

            } catch (SQLException | ClassNotFoundException ex) {
                ex.printStackTrace();
            } finally {
                try {
                    if (conn != null && !conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
