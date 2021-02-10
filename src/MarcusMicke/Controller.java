package MarcusMicke;

/*

Projektarbete Databashantering, Systemutvecklare Java
Code: Michael Hejl

 */

import javafx.event.Event;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.time.LocalDate;
import java.util.Properties;

public class Controller {

    public static Controller controller;
    public Controller(){
        controller = this;
    }
    Main main;

    @FXML DatePicker dateSearch;
    @FXML DatePicker dateSearchReservation;
    @FXML TextField numNightsText;
    @FXML TextField txtLastName;
    @FXML ListView<String> lw_SearchResults;
    @FXML ListView<String> lw_ReservationResult;
    @FXML GridPane availableRoomsSearch;
    @FXML GridPane searchReservation;

    public static Properties getConnectionData() {
        Properties props = new Properties();
        String fileName = "src/MarcusMicke/db.properties";
        try (FileInputStream in = new FileInputStream(fileName)) {
            props.load(in);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return props;
    }

    public static Connection SQLConnection() throws ClassNotFoundException, SQLException {
        Connection conn = null;
        Properties props = getConnectionData();
        String url = props.getProperty("db.url");
        String username = props.getProperty("db.user");
        String password = props.getProperty("db.pass");
        String myDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        Class.forName(myDriver);
        conn = DriverManager.getConnection(url, username, password);
        return conn;
    }
    public void doSearchReservation (Event e) {
        availableRoomsSearch.setVisible(false);
        searchReservation.setVisible(true);
    }
    public void doSearchAvailableRooms (Event e) {
        searchReservation.setVisible(false);
        availableRoomsSearch.setVisible(true);
    }

    public void checkValidDate (Event e) {
        if (dateSearch.getValue().isBefore(LocalDate.now())) dateSearch.setValue(LocalDate.now());
    }

    public void searchReservationClicked() throws InvocationTargetException {
        if (dateSearchReservation.getValue() != null && txtLastName.getText() != null) {
            Connection conn = null;
            Statement stmt = null;
            try {
                conn = SQLConnection();
                if (conn != null) {
                    stmt = conn.createStatement();
                    String sql;
                    sql = "EXEC GetReservation @date='"+dateSearchReservation.getValue()+"', @lname='"+txtLastName.getText()+"'";
                    ResultSet rs = stmt.executeQuery(sql);
                    lw_ReservationResult.getItems().clear();
                    lw_ReservationResult.setVisible(true);
                    lw_ReservationResult.getItems().add("Incheckning  \tUtcheckning \tRum  \t\tGäst");
                    while (rs.next()) {
                        lw_ReservationResult.getItems().add((rs.getString("Incheckning")).substring(0,10) + " \t" + (rs.getString("Utcheckning")).substring(0,10) + " \t" + rs.getString("Rum") + " \t\t" + rs.getString("Gäst"));
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

    public void searchAvailableRooms() throws NumberFormatException {
        if (dateSearch.getValue() != null && Integer.parseInt(numNightsText.getText()) > 0) {
            Connection conn = null;
            Statement stmt = null;
            try {
                conn = SQLConnection();
                if (conn != null) {
                    stmt = conn.createStatement();
                    String sql;
                    sql = "EXEC CheckAvailableRooms @from='"+dateSearch.getValue()+"', @nights="+numNightsText.getText();
                    ResultSet rs = stmt.executeQuery(sql);
                    lw_SearchResults.getItems().clear();
                    lw_SearchResults.setVisible(true);
                    lw_SearchResults.getItems().add("Rum  \tPris/natt  \tRumstyp");
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
