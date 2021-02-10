package MarcusMicke;

import javafx.application.Application;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

import java.time.LocalDate;

public class Main extends Application {


    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("newtonhotels.fxml"));
        primaryStage.setTitle("Newton Hotels");
        primaryStage.setScene(new Scene(root, 1312, 738));
        primaryStage.show();
        Controller.controller.dateSearch.setValue(LocalDate.now());
        Controller.controller.availableRoomsSearch.setVisible(false);
        Controller.controller.searchReservation.setVisible(false);
    }

    public static void main(String[] args) {
        launch(args);
    }
}
