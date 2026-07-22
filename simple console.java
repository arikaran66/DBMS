package test1;

import java.sql.*;
import java.util.Scanner;

public class MedicineSystem {

    static final String URL = "jdbc:oracle:thin:@//localhost:1521/XEPDB1";
    static final String USER = "system";
    static final String PASS = "cscorner";

    Connection con = null;
    Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        new MedicineSystem().start();
    }

    public void start() {

        try {
            Class.forName("oracle.jdbc.OracleDriver");
            con = DriverManager.getConnection(URL, USER, PASS);
            con.setAutoCommit(false);
            System.out.println("\n Connected to Oracle Database Successfully!");
        } catch (Exception e) {
            System.out.println("\n Database Connection Failed: " + e.getMessage());
            return;
        }

        while (true) {
            System.out.println(" MEDICINE MANAGEMENT SYSTEM");
            System.out.println("=========================================");
            System.out.println("1. View All Records");
            System.out.println("2. Insert New Record");
            System.out.println("3. Update Existing Record");
            System.out.println("4. Delete Record");
            System.out.println("5. Search by Medicine Name");
            System.out.println("6. Exit");
            System.out.print("Enter choice: ");

            String choice = scanner.nextLine();

            switch (choice) {
                case "1": viewRecords(); break;
                case "2": insertRecord(); break;
                case "3": updateRecord(); break;
                case "4": deleteRecord(); break;
                case "5": searchRecord(); break;
                case "6":
                    System.out.println("Exiting...");
                    return;
                default:
                    System.out.println(" Invalid choice!");
            }
        }
    }

    private void viewRecords() {

        try {

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(
                "SELECT MEDICINE_ID, CAT_ID, MEDICINE_NAME, MEDICINE_BRAND, " +
                "UNITSIZE, MRP, GST, SELLING_PRICE, PRESCRIPTION_REQUIRED " +
                "FROM MEDICINE ORDER BY MEDICINE_ID");

            System.out.printf(
                "%-6s %-6s %-20s %-15s %-8s %-8s %-6s %-12s %-8s\n",
                "ID", "CatID", "Medicine Name", "Brand", "Size", "MRP", "GST", "Sell Price", "pre Req");

            System.out.println("==================================================================================");

            while (rs.next()) {

                System.out.printf(
                    "%-6d %-6d %-20s %-15s %-8d %-8.2f %-6.2f %-12.2f %-8s\n",
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getInt(5),
                    rs.getDouble(6),
                    rs.getDouble(7),
                    rs.getDouble(8),
                    rs.getString(9));
            }

        } catch (SQLException e) {
            System.out.println("\n ERROR loading records!\n");
        }
    }

    private void insertRecord() {

        try {

            System.out.print("Medicine ID: ");
            int id = Integer.parseInt(scanner.nextLine());

            System.out.print("Category ID: ");
            int catId = Integer.parseInt(scanner.nextLine());

            System.out.print("Medicine Name: ");
            String medName = scanner.nextLine();

            System.out.print("Medicine Brand: ");
            String brand = scanner.nextLine();

            System.out.print("Unit Size: ");
            int unitSize = Integer.parseInt(scanner.nextLine());

            System.out.print("MRP");
            double mrp = Double.parseDouble(scanner.nextLine());

            System.out.print("GST (%): ");
            double gst = Double.parseDouble(scanner.nextLine());

            System.out.print("Selling Price: ");
            double sellingPrice = Double.parseDouble(scanner.nextLine());

            System.out.print("Prescription Required (YES/NO): ");
            String prescReq = scanner.nextLine().toUpperCase();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO MEDICINE VALUES(?,?,?,?,?,?,?,?,?)");

            ps.setInt(1, id);
            ps.setInt(2, catId);
            ps.setString(3, medName);
            ps.setString(4, brand);
            ps.setInt(5, unitSize);
            ps.setDouble(6, mrp);
            ps.setDouble(7, gst);
            ps.setDouble(8, sellingPrice);
            ps.setString(9, prescReq);

            ps.executeUpdate();
            con.commit();

            System.out.println("\n Inserted Successfully!\n");

        } catch (NumberFormatException e) {
            System.out.println("\n ERROR: Integer/Number expected!\n");

        } catch (SQLException e) {

            if (e.getErrorCode() == 1) {
                System.out.println("\n ERROR: Duplicate Entry!");
                System.out.println("-> Medicine ID already exists.\n");
            }
            else {
                System.out.println("\n Database Error: " + e.getMessage() + "\n");
            }
        }
    }

    private void updateRecord() {

        try {

            System.out.print("Enter Medicine ID: ");
            int id = Integer.parseInt(scanner.nextLine());

            String sql = "UPDATE MEDICINE SET ";
            boolean hasField = false;

            System.out.print("New Category ID (Enter to skip): ");
            String catId = scanner.nextLine();
            if (!catId.isEmpty()) {
                Integer.parseInt(catId);
                sql += "CAT_ID=" + catId + ",";
                hasField = true;
            }

            System.out.print("New Medicine Name (Enter to skip): ");
            String medName = scanner.nextLine();
            if (!medName.isEmpty()) {
                sql += "MEDICINE_NAME='" + medName + "',";
                hasField = true;
            }

            System.out.print("New Medicine Brand (Enter to skip): ");
            String brand = scanner.nextLine();
            if (!brand.isEmpty()) {
                sql += "MEDICINE_BRAND='" + brand + "',";
                hasField = true;
            }

            System.out.print("New Unit Size (Enter to skip): ");
            String unitSize = scanner.nextLine();
            if (!unitSize.isEmpty()) {
                Integer.parseInt(unitSize);
                sql += "UNITSIZE=" + unitSize + ",";
                hasField = true;
            }

            System.out.print("New MRP (Enter to skip): ");
            String mrp = scanner.nextLine();
            if (!mrp.isEmpty()) {
                Double.parseDouble(mrp);
                sql += "MRP=" + mrp + ",";
                hasField = true;
            }

            System.out.print("New GST (Enter to skip): ");
            String gst = scanner.nextLine();
            if (!gst.isEmpty()) {
                Double.parseDouble(gst);
                sql += "GST=" + gst + ",";
                hasField = true;
            }

            System.out.print("New Selling Price (Enter to skip): ");
            String sellingPrice = scanner.nextLine();
            if (!sellingPrice.isEmpty()) {
                Double.parseDouble(sellingPrice);
                sql += "SELLING_PRICE=" + sellingPrice + ",";
                hasField = true;
            }

            System.out.print("New Prescription Required (YES/NO) (Enter to skip): ");
            String prescReq = scanner.nextLine();
            if (!prescReq.isEmpty()) {
                sql += "PRESCRIPTION_REQUIRED='" + prescReq.toUpperCase() + "',";
                hasField = true;
            }

            if (!hasField) {
                System.out.println("\n Nothing to update.\n");
                return;
            }

            sql = sql.substring(0, sql.length() - 1);
            sql += " WHERE MEDICINE_ID=" + id;

            Statement stmt = con.createStatement();
            int rows = stmt.executeUpdate(sql);

            if (rows > 0) {
                con.commit();
                System.out.println("\n Updated Successfully!\n");
            } else {
                System.out.println("\n No record found with that ID!\n");
            }

        } catch (NumberFormatException e) {
            System.out.println("\n ERROR: Integer/Number expected!\n");

        } catch (SQLException e) {

            if (e.getErrorCode() == 1) {
                System.out.println("\n ERROR: Duplicate value!");
                System.out.println("-> Medicine ID already exists. Use UNIQUE value.\n");
            }
            else {
                System.out.println("\n Update Error: " + e.getMessage() + "\n");
            }
        }
    }

    private void deleteRecord() {

        try {

            System.out.print("Enter Medicine ID: ");
            int id = Integer.parseInt(scanner.nextLine());

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM MEDICINE WHERE MEDICINE_ID=?");

            ps.setInt(1, id);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                con.commit();
                System.out.println("\n Deleted Successfully!\n");
            } else {
                System.out.println("\n ID not found!\n");
            }

        } catch (NumberFormatException e) {
            System.out.println("\n ERROR: ID must be integer!\n");

        } catch (SQLException e) {
            System.out.println("\n Database Error while deleting!\n");
        }
    }
    private void searchRecord() {

        System.out.print("Enter Medicine Name: ");
        String medName = scanner.nextLine();

        try {

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM MEDICINE WHERE UPPER(MEDICINE_NAME) LIKE UPPER(?)");

            ps.setString(1, "%" + medName + "%");

            ResultSet rs = ps.executeQuery();

            int count = 0;

            System.out.printf(
                "%-6s %-20s %-15s %-12s %-8s\n",
                "ID", "Medicine Name", "Brand", "Sell Price", "Pre Req");
            System.out.println("=================================================");

            while (rs.next()) {
                System.out.printf(
                    "%-6d %-20s %-15s %-12.2f %-8s\n",
                    rs.getInt(1),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getDouble(8),
                    rs.getString(9));
                count++;
            }

            if (count == 0)
                System.out.println("\n No records found.\n");
            else
                System.out.println("\n Found " + count + " record(s).\n");

        } catch (SQLException e) {
            System.out.println("\n Database Error during search!\n");
        }
    }
}

