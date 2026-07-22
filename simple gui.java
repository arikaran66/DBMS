[24bcsl03@mepcolinux sql]$cat gui.txt
package test11;

import java.awt.*;
import java.sql.*;
import javax.swing.*;
import javax.swing.table.*;

public class MedicineGUI extends JFrame {
    static final String URL = "jdbc:oracle:thin:@//localhost:1521/XEPDB1";
    static final String USER = "system";
    static final String PASS = "cscorner";
    JTable table;
    JTextField id, cat, name, brand, unit, mrp, gst, price;
    JComboBox<String> pres;
    JLabel statusLabel;
    boolean isUpdateMode = false;

    Connection con;
    public MedicineGUI() {
        setTitle("Medicine Management System");
        setSize(1200, 700);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        try {
            Class.forName("oracle.jdbc.OracleDriver");
            con = DriverManager.getConnection(URL, USER, PASS);
            con.setAutoCommit(false);
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "DB Connection Failed");
        }
        createUI();
    }

    void createUI() {
        Container c = getContentPane();
        c.setLayout(new BorderLayout(10, 10));
        JPanel inputPanel = new JPanel(new GridLayout(3, 6, 10, 10));
        inputPanel.setBorder(BorderFactory.createTitledBorder("Medicine Details"));


        inputPanel.add(new JLabel("Medicine ID"));
        id = new JTextField();
        inputPanel.add(id);

        inputPanel.add(new JLabel("Category ID"));
        cat = new JTextField();
        inputPanel.add(cat);

        inputPanel.add(new JLabel("Medicine Name"));
        name = new JTextField();
        inputPanel.add(name);


        inputPanel.add(new JLabel("Brand"));
        brand = new JTextField();
        inputPanel.add(brand);

        inputPanel.add(new JLabel("Unit Size"));
        unit = new JTextField();
        inputPanel.add(unit);

        inputPanel.add(new JLabel("MRP"));
        mrp = new JTextField();
        inputPanel.add(mrp);


        inputPanel.add(new JLabel("GST"));
        gst = new JTextField();
        inputPanel.add(gst);

        inputPanel.add(new JLabel("Selling Price"));
        price = new JTextField();
        inputPanel.add(price);

        inputPanel.add(new JLabel("Prescription"));
        pres = new JComboBox<>(new String[]{"YES", "NO"});
        inputPanel.add(pres);

        c.add(inputPanel, BorderLayout.NORTH);

        table = new JTable();
        table.setRowHeight(25);
        c.add(new JScrollPane(table), BorderLayout.CENTER);

        JPanel btnPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 15, 10));

        JButton view = new JButton("VIEW");
        JButton insert = new JButton("INSERT");
        JButton update = new JButton("UPDATE");
        JButton delete = new JButton("DELETE");
        JButton search = new JButton("SEARCH");
        JButton clear = new JButton("CLEAR");
        JButton exit = new JButton("EXIT");

        view.setBackground(Color.CYAN);
        insert.setBackground(Color.GREEN);
        update.setBackground(Color.ORANGE);
        delete.setBackground(Color.RED);
        search.setBackground(Color.YELLOW);
        clear.setBackground(Color.LIGHT_GRAY);

        btnPanel.add(view);
        btnPanel.add(insert);
        btnPanel.add(update);
        btnPanel.add(delete);
        btnPanel.add(search);
        btnPanel.add(clear);
        btnPanel.add(exit);
        statusLabel = new JLabel("Ready");
        JPanel footerPanel = new JPanel(new BorderLayout());
        footerPanel.add(btnPanel, BorderLayout.CENTER);
        footerPanel.add(statusLabel, BorderLayout.SOUTH);
        c.add(footerPanel, BorderLayout.SOUTH);
        view.addActionListener(e -> view());
        insert.addActionListener(e -> insert());
        update.addActionListener(e -> update());
        delete.addActionListener(e -> delete());
        search.addActionListener(e -> search());
        clear.addActionListener(e -> clearFields());
        exit.addActionListener(e -> System.exit(0));
        view();
    }
    void view() {
        try {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM MEDICINE");

            DefaultTableModel m = new DefaultTableModel(
                    new String[]{"ID","CAT","NAME","BRAND","UNIT","MRP","GST","PRICE","PRES"},0);
            while (rs.next()) {
                m.addRow(new Object[]{
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getString(9)
                });
            }
            table.setModel(m);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "View Error");
        }
    }
    boolean isInteger(String value, String fieldName) {

        if (value == null || value.trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, fieldName + " cannot be empty");
            return false;
        }

        try {
            Integer.parseInt(value.trim());
            return true;
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, fieldName + " must be a valid number");
            return false;
        }
    }
    void insert() {

        if (!isInteger(id.getText(), "Medicine ID")) return;
        if (!isInteger(cat.getText(), "Category ID")) return;
        if (!isInteger(unit.getText(), "Unit Size")) return;
        if (!isInteger(mrp.getText(), "MRP")) return;
        if (!isInteger(gst.getText(), "GST")) return;
        if (!isInteger(price.getText(), "Selling Price")) return;

        if (name.getText().isEmpty() || brand.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Fill all fields");
            return;
        }

        try {

            PreparedStatement checkName = con.prepareStatement(
                "SELECT COUNT(*) FROM MEDICINE WHERE MEDICINE_NAME = ?"
            );

            checkName.setString(1, name.getText().trim());
            ResultSet rs = checkName.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                JOptionPane.showMessageDialog(this, "Medicine Name already exists!");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO MEDICINE " +
                "(MEDICINE_ID, CAT_ID, MEDICINE_NAME, MEDICINE_BRAND, " +
                "UNITSIZE, MRP, GST, SELLING_PRICE, PRESCRIPTION_REQUIRED) " +
                "VALUES (?,?,?,?,?,?,?,?,?)"
            );

            ps.setInt(1, Integer.parseInt(id.getText()));
            ps.setInt(2, Integer.parseInt(cat.getText()));
            ps.setString(3, name.getText());
            ps.setString(4, brand.getText());
            ps.setInt(5, Integer.parseInt(unit.getText()));
            ps.setInt(6, Integer.parseInt(mrp.getText()));
            ps.setInt(7, Integer.parseInt(gst.getText()));
            ps.setInt(8, Integer.parseInt(price.getText()));
            ps.setString(9, pres.getSelectedItem().toString());

            ps.executeUpdate();
            con.commit();

            JOptionPane.showMessageDialog(this, "Inserted Successfully");

            view();
            clearFields();

        } catch (SQLException e) {

            if (e.getErrorCode() == 1) {
                JOptionPane.showMessageDialog(this,
                        "Medicine ID already exists!");
            } else {
                JOptionPane.showMessageDialog(this,
                        "Insert Failed: " + e.getMessage());
            }
        }
    }
    void update() {

        if (id.getText().trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Enter Medicine ID");
            return;
        }

        try {
            int medId = Integer.parseInt(id.getText());


            if (!isUpdateMode) {

                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM MEDICINE WHERE MEDICINE_ID=?"
                );

                ps.setInt(1, medId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    cat.setText(rs.getString("CAT_ID"));
                    name.setText(rs.getString("MEDICINE_NAME"));
                    brand.setText(rs.getString("MEDICINE_BRAND"));
                    unit.setText(rs.getString("UNITSIZE"));
                    mrp.setText(rs.getString("MRP"));
                    gst.setText(rs.getString("GST"));
                    price.setText(rs.getString("SELLING_PRICE"));
                    pres.setSelectedItem(rs.getString("PRESCRIPTION_REQUIRED"));

                    isUpdateMode = true;
                    statusLabel.setText("Edit values and click UPDATE again");

                } else {
                    JOptionPane.showMessageDialog(this, "Medicine ID not found");
                }

            }

            else {

                PreparedStatement ps = con.prepareStatement(
                    "UPDATE MEDICINE SET CAT_ID=?, MEDICINE_NAME=?, MEDICINE_BRAND=?, UNITSIZE=?, MRP=?, GST=?, SELLING_PRICE=?, PRESCRIPTION_REQUIRED=? WHERE MEDICINE_ID=?"
                );

                ps.setInt(1, Integer.parseInt(cat.getText()));
                ps.setString(2, name.getText());
                ps.setString(3, brand.getText());
                ps.setInt(4, Integer.parseInt(unit.getText()));
                ps.setInt(5, Integer.parseInt(mrp.getText()));
                ps.setInt(6, Integer.parseInt(gst.getText()));
                ps.setInt(7, Integer.parseInt(price.getText()));
                ps.setString(8, pres.getSelectedItem().toString());
                ps.setInt(9, medId);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    con.commit();
                    JOptionPane.showMessageDialog(this, "Updated Successfully");
                    statusLabel.setText("Update Successful");
                } else {
                    JOptionPane.showMessageDialog(this, "Update Failed");
                }

                isUpdateMode = false;
                view();
                clearFields();
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        }
    }
    void delete() {
        if (id.getText().trim().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Enter Medicine ID");
            return;
        }
        int medId;
        try {
            medId = Integer.parseInt(id.getText());
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Invalid ID");
            return;
        }

        try {

            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM MEDICINE WHERE MEDICINE_ID=?");

            ps.setInt(1, medId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                con.commit();
                JOptionPane.showMessageDialog(this, "Deleted Successfully");
            } else {
                JOptionPane.showMessageDialog(this, "Invalid ID");
            }

            view();
            clearFields();

        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Delete Error");
        }
    }
    void search() {
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM MEDICINE WHERE MEDICINE_ID=?"
            );

            ps.setInt(1, Integer.parseInt(id.getText()));

            ResultSet rs = ps.executeQuery();

            DefaultTableModel m = new DefaultTableModel(
                new String[]{"ID","CAT","NAME","BRAND","UNIT","MRP","GST","PRICE","PRES"}, 0
            );

            boolean found = false;

            while (rs.next()) {
                found = true;

                m.addRow(new Object[]{
                    rs.getInt("MEDICINE_ID"),
                    rs.getInt("CAT_ID"),
                    rs.getString("MEDICINE_NAME"),
                    rs.getString("MEDICINE_BRAND"),
                    rs.getInt("UNITSIZE"),
                    rs.getInt("MRP"),
                    rs.getInt("GST"),
                    rs.getInt("SELLING_PRICE"),
                    rs.getString("PRESCRIPTION_REQUIRED")
                });
            }

            if (!found) {
                JOptionPane.showMessageDialog(this, "Medicine not found!");
            }

            table.setModel(m);

        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Search Error");
        }
    }
    void clearFields() {
        id.setText("");
        cat.setText("");
        name.setText("");
        brand.setText("");
        unit.setText("");
        mrp.setText("");
        gst.setText("");
        price.setText("");
        pres.setSelectedIndex(0);

        isUpdateMode = false;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new MedicineGUI().setVisible(true));
    }
}
