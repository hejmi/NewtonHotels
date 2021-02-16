package MarcusMicke;

/*

Projektarbete Databashantering, Systemutvecklare Java
Code: Michael Hejl

 */

import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;

import java.io.FileInputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.time.LocalDate;
import java.util.Properties;

public class Controller {

    public static Controller controller;
    public Controller(){
        controller = this;
    }

    @FXML DatePicker dateSearch;
    @FXML DatePicker dateSearchReservation;
    @FXML TextField numNightsText;
    @FXML TextField txtLastName;
    @FXML TextField loginUsernameField;
    @FXML PasswordField loginPasswordField;
    @FXML ListView<String> lw_SearchResults;
    @FXML ListView<String> lw_ReservationResult;
    @FXML GridPane availableRoomsSearch;
    @FXML GridPane searchReservation;
    @FXML GridPane loginGrid;
    @FXML MenuItem menuItemSearchReservation;
    @FXML MenuItem menuItemSearchAvailableRooms;
    @FXML Label labelLoginInfo;


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
        Connection conn;
        Properties props = getConnectionData();
        String url = props.getProperty("db.url");
        String username = props.getProperty("db.user");
        String password = props.getProperty("db.pass");
        String myDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        Class.forName(myDriver);
        conn = DriverManager.getConnection(url, username, password);
        return conn;
    }

    public void doLogin() throws NoSuchAlgorithmException {
        if(loginUsernameField.getText().isEmpty() || loginPasswordField.getText().isEmpty()){
            Alert alert = new Alert(Alert.AlertType.WARNING, "Fel!\n\nAnvändarnamn/Lösenord måste anges.", ButtonType.OK);
            alert.setTitle("*** Newton Hotels ***");
            alert.setHeaderText("Inloggning till systemet");
            alert.showAndWait();
        } else {
            String username = loginUsernameField.getText();
            StringBuilder password = md5Pass(loginPasswordField.getText());
            int loginID=0;
            int staffID=0;
            Connection conn = null;
            try {
                conn = SQLConnection();
                if (conn != null) {
                    PreparedStatement pstmt = conn.prepareStatement("SELECT loginID, staffID FROM Hotels.StaffLogin WHERE username=? AND password=?");
                    pstmt.setString(1, username);
                    pstmt.setString(2, password.toString());
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                        loginID = rs.getInt("loginID");
                        staffID = rs.getInt("staffID");
                    }
                    pstmt = conn.prepareStatement("EXEC FetchStaffData @staffid=?");
                    pstmt.setInt(1, staffID);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        labelLoginInfo.setText("Inloggad:   " + rs.getString("name") + ", " + rs.getString("pos"));
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
            if(staffID>0 && loginID>0) {
                Alert alert = new Alert(Alert.AlertType.CONFIRMATION, "Välkommen!\n\nVar vänlig och använd menyn för att navigera bland systemets funktioner.", ButtonType.OK);
                alert.setTitle("*** Newton Hotels ***");
                alert.setHeaderText("Inloggning till systemet");
                alert.showAndWait();

                menuItemSearchAvailableRooms.setDisable(false);
                menuItemSearchReservation.setDisable(false);
                loginGrid.setVisible(false);
            } else {
                Alert alert = new Alert(Alert.AlertType.WARNING, "Fel!\n\nFel användarnamn eller lösenord har angivits.\nVänligen försök igen.", ButtonType.OK);
                alert.setTitle("*** Newton Hotels ***");
                alert.setHeaderText("Inloggning till systemet");
                alert.showAndWait();
            }
        }
    }
    public void doSearchAvailableRooms() {
        searchReservation.setVisible(false);
        availableRoomsSearch.setVisible(true);
        lw_SearchResults.getItems().clear();
        lw_SearchResults.setVisible(false);
        numNightsText.clear();
    }

    public void doSearchReservation () {
        availableRoomsSearch.setVisible(false);
        searchReservation.setVisible(true);
        lw_ReservationResult.getItems().clear();
        lw_ReservationResult.setVisible(false);
        txtLastName.clear();
    }

    public void checkValidDate () {
        if (dateSearch.getValue().isBefore(LocalDate.now())) dateSearch.setValue(LocalDate.now());
    }

    public void searchReservationClicked() {
        if (dateSearchReservation.getValue() != null && txtLastName.getText() != null) {
            Connection conn = null;
            Statement stmt;
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

    /**
     * Builds a md5-hash of password
     * @author Michael
     * @param text input string
     * @return md5 password
     * @throws NoSuchAlgorithmException error output
     */
    private static StringBuilder md5Pass(String text) throws NoSuchAlgorithmException {
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        md5.update(text.getBytes());
        byte[] md5Password = md5.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : md5Password) {
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb;
    }

    public void searchAvailableRooms() {
        if (dateSearch.getValue() != null && numNightsText.getText() != null) {
            Connection conn = null;
            int numofnights = 0;
            Statement stmt;
            try {
                numofnights = Integer.parseInt(numNightsText.getText());
            } catch (NumberFormatException e) {
                Alert alert = new Alert(Alert.AlertType.WARNING, "Fältet med antal nätter får endast innehålla ett numeriskt värde", ButtonType.OK);
                alert.setTitle("*** Newton Hotels ***");
                alert.setHeaderText("Sök lediga rum");
                alert.showAndWait();
                numNightsText.clear();
            }
            if (numofnights>0) {
                try {
                    conn = SQLConnection();
                    if (conn != null) {
                        stmt = conn.createStatement();
                        String sql;
                        sql = "EXEC CheckAvailableRooms @from='" + dateSearch.getValue() + "', @nights=" + numNightsText.getText();
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
}
