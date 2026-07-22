package test11;
import java.awt.*;
import java.sql.*;
import java.util.regex.*;
import javax.swing.*;
import javax.swing.table.*;
public class hack extends JFrame {
    static final String DB_URL = "jdbc:oracle:thin:@//localhost:1521/XE";
    static final String DB_USER = "system";
    static final String DB_PASS = "cscorner";

    static final String[] CATEGORIES = {
        "-- Select Category --",
        "Pain Relief", "Cold & Cough", "Antibiotics", "Antihistamines",
        "Digestive Health", "Vitamins & Supplements", "Heart & Blood Pressure",
        "Diabetes Care", "Skin Care", "Eye Care", "First Aid & Bandages",
        "Respiratory", "Women's Health", "Men's Health", "Other"
    };

    // Admin credentials (hardcoded for demo - use DB in production)
    static final String ADMIN_ID = "admin";
    static final String ADMIN_PASS = "admin123";

    Connection con;
    int loggedInCustomerId = -1;
    String loggedInCustomerName = "";
    String loggedInUserType = ""; // "ADMIN" or "CUSTOMER"
    JLabel statusLabel;
    CardLayout cardLayout;
    JPanel cardPanel;

    public hack() {
        setTitle("Online Pharmacy Medicine System - Multi-Role");
        setSize(1200, 750);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        try {
            Class.forName("oracle.jdbc.OracleDriver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            con.setAutoCommit(false);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "DB Connection Failed!\n" + e.getMessage());
            System.exit(0);
        }

        createUI();
    }

    boolean isValidName(String v) { return v.matches("^[A-Za-z ]{2,50}$"); }
    boolean isValidEmail(String v) { return Pattern.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", v); }
    boolean isValidPhone(String v) { return v.matches("\\d{10}"); }
    boolean isValidPassword(String v) {
        if (v.length() < 8) return false;
        if (!v.matches(".*[A-Z].*")) return false;
        if (!v.matches(".*[0-9].*")) return false;
        if (!v.matches(".*[!@#$%^&()_+\\-=\\[\\]{};':\",./<>?|].*")) return false;
        return true;
    }
    boolean isValidPrice(String v) {
        try { return Double.parseDouble(v) > 0; } catch (NumberFormatException e) { return false; }
    }
    boolean isValidStock(String v) {
        try { return Integer.parseInt(v) >= 0; } catch (NumberFormatException e) { return false; }
    }
    boolean isValidCategory(String v) { return v != null && !v.startsWith("-- Select"); }
    boolean isValidPrescription(String v) { return v != null && (v.equalsIgnoreCase("Yes") || v.equalsIgnoreCase("No")); }

    void showError(String msg) { JOptionPane.showMessageDialog(this, msg, "Validation Error", JOptionPane.WARNING_MESSAGE); }
    void showDBError(Exception e) { JOptionPane.showMessageDialog(this, "DB Error: " + e.getMessage(), "Database Error", JOptionPane.ERROR_MESSAGE); }
    void showSuccess(String msg) { JOptionPane.showMessageDialog(this, msg, "Success", JOptionPane.INFORMATION_MESSAGE); }
    JComboBox<String> makeCatBox() { return new JComboBox<>(CATEGORIES); }
    void createUI() {
        cardLayout = new CardLayout();
        cardPanel = new JPanel(cardLayout);
        cardPanel.add(createRoleSelectionScreen(), "ROLE_SELECTION");
        cardPanel.add(createCustomerDashboard(), "CUSTOMER_DASHBOARD");
        cardPanel.add(createCustomerRegisterTab(), "CUSTOMER_REGISTER");
        cardPanel.add(createCustomerLoginTab(), "CUSTOMER_LOGIN");
        cardPanel.add(createAdminLoginTab(), "ADMIN_LOGIN");
        cardPanel.add(createAdminDashboard(), "ADMIN_DASHBOARD");
        add(cardPanel, BorderLayout.CENTER);

        statusLabel = new JLabel("   System Ready - Select Role");
        statusLabel.setFont(new Font("SansSerif", Font.BOLD, 13));
        add(statusLabel, BorderLayout.SOUTH);
    }
    JPanel createRoleSelectionScreen() {
        JPanel p = new JPanel(new GridBagLayout());
        p.setBackground(new Color(245, 245, 245));
        GridBagConstraints g = new GridBagConstraints();

        JLabel title = new JLabel("Online Pharmacy System");
        title.setFont(new Font("SansSerif", Font.BOLD, 32));
        g.gridx = 0; g.gridy = 0; g.insets = new Insets(20, 20, 20, 20);
        p.add(title, g);

        JLabel subtitle = new JLabel("Select Your Role to Continue");
        subtitle.setFont(new Font("SansSerif", Font.PLAIN, 16));
        g.gridy = 1; g.insets = new Insets(0, 20, 40, 20);
        p.add(subtitle, g);

        JButton customerBtn = new JButton("Customer");
        customerBtn.setFont(new Font("SansSerif", Font.BOLD, 16));
        customerBtn.setPreferredSize(new Dimension(200, 60));
        customerBtn.setBackground(new Color(52, 152, 219));
        customerBtn.setForeground(Color.WHITE);
        customerBtn.setBorder(BorderFactory.createEmptyBorder(10, 30, 10, 30));

        JButton adminBtn = new JButton("Admin");
        adminBtn.setFont(new Font("SansSerif", Font.BOLD, 16));
        adminBtn.setPreferredSize(new Dimension(200, 60));
        adminBtn.setBackground(new Color(231, 76, 60));
        adminBtn.setForeground(Color.WHITE);
        adminBtn.setBorder(BorderFactory.createEmptyBorder(10, 30, 10, 30));

        JPanel btnPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 30, 20));
        btnPanel.setBackground(new Color(245, 245, 245));
        btnPanel.add(customerBtn);
        btnPanel.add(adminBtn);

        g.gridy = 2; g.insets = new Insets(20, 20, 20, 20);
        p.add(btnPanel, g);

        customerBtn.addActionListener(e -> cardLayout.show(cardPanel, "CUSTOMER_LOGIN"));
        adminBtn.addActionListener(e -> cardLayout.show(cardPanel, "ADMIN_LOGIN"));

        return p;
    }
    JPanel createCustomerLoginTab() {
        JPanel p = new JPanel(new GridBagLayout());
        p.setBackground(new Color(245, 245, 245));
        p.setBorder(BorderFactory.createTitledBorder("Customer Login"));
        GridBagConstraints g = new GridBagConstraints();
        g.insets = new Insets(10, 15, 10, 15);
        g.fill = GridBagConstraints.HORIZONTAL;

        JTextField tfEmail = new JTextField(25);
        JPasswordField pfPass = new JPasswordField(25);
        JButton loginBtn = new JButton("Login");
        JButton regBtn = new JButton("New User? Register");
        JButton backBtn = new JButton("Back to Role Selection");

        loginBtn.setBackground(new Color(52, 152, 219));
        loginBtn.setForeground(Color.WHITE);

        g.gridx = 0; g.gridy = 0; p.add(new JLabel("Email *"), g);
        g.gridx = 1; p.add(tfEmail, g);
        g.gridx = 0; g.gridy = 1; p.add(new JLabel("Password *"), g);
        g.gridx = 1; p.add(pfPass, g);
        g.gridx = 1; g.gridy = 2; p.add(loginBtn, g);
        g.gridx = 1; g.gridy = 3; p.add(regBtn, g);
        g.gridx = 1; g.gridy = 4; p.add(backBtn, g);

        loginBtn.addActionListener(e -> {
            String em = tfEmail.getText().trim();
            String pw = new String(pfPass.getPassword());

            if (em.isEmpty() || pw.isEmpty()) {
                showError("Email and password are required.");
                return;
            }
            if (!isValidEmail(em)) {
                showError("Enter a valid email address.");
                return;
            }

            try {
                PreparedStatement ps = con.prepareStatement(
                        "SELECT CUSTOMER_ID,NAME FROM CUSTOMERS WHERE UPPER(EMAIL)=UPPER(?) AND PASSWORD=?");
                ps.setString(1, em);
                ps.setString(2, pw);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    loggedInCustomerId = rs.getInt(1);
                    loggedInCustomerName = rs.getString(2);
                    loggedInUserType = "CUSTOMER";
                    statusLabel.setText("   Logged in: " + loggedInCustomerName + " (Customer)");
                    showSuccess("Welcome, " + loggedInCustomerName + "!");
                    cardLayout.show(cardPanel, "CUSTOMER_DASHBOARD");
                    tfEmail.setText("");
                    pfPass.setText("");
                } else {
                    showError("Invalid email or password.");
                }
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        regBtn.addActionListener(e -> cardLayout.show(cardPanel, "CUSTOMER_REGISTER"));
        backBtn.addActionListener(e -> {
            loggedInUserType = "";
            cardLayout.show(cardPanel, "ROLE_SELECTION");
        });

        return p;
    }

    JPanel createCustomerRegisterTab() {
        JPanel p = new JPanel(new GridBagLayout());
        p.setBackground(new Color(245, 245, 245));
        p.setBorder(BorderFactory.createTitledBorder("Customer Registration"));
        GridBagConstraints g = new GridBagConstraints();
        g.insets = new Insets(8, 12, 8, 12);
        g.fill = GridBagConstraints.HORIZONTAL;

        JTextField tfName = new JTextField(25);
        JTextField tfEmail = new JTextField(25);
        JTextField tfPhone = new JTextField(25);
        JPasswordField pfPass = new JPasswordField(25);
        JPasswordField pfConf = new JPasswordField(25);
        JTextField tfAddr = new JTextField(25);
        JButton regBtn = new JButton("Register");
        JButton backBtn = new JButton("Back to Login");

        regBtn.setBackground(new Color(52, 152, 219));
        regBtn.setForeground(Color.WHITE);

        g.gridx = 0; g.gridy = 0; p.add(new JLabel("Full Name *"), g);
        g.gridx = 1; p.add(tfName, g);
        g.gridx = 0; g.gridy = 1; p.add(new JLabel("Email *"), g);
        g.gridx = 1; p.add(tfEmail, g);
        g.gridx = 0; g.gridy = 2; p.add(new JLabel("Phone (10 digits) *"), g);
        g.gridx = 1; p.add(tfPhone, g);
        g.gridx = 0; g.gridy = 3; p.add(new JLabel("Password *"), g);
        g.gridx = 1; p.add(pfPass, g);
        g.gridx = 0; g.gridy = 4; p.add(new JLabel("Confirm Password *"), g);
        g.gridx = 1; p.add(pfConf, g);
        g.gridx = 0; g.gridy = 5; p.add(new JLabel("Address"), g);
        g.gridx = 1; p.add(tfAddr, g);
        g.gridx = 1; g.gridy = 6; p.add(regBtn, g);
        g.gridx = 1; g.gridy = 7; p.add(backBtn, g);

        regBtn.addActionListener(e -> {
            String n = tfName.getText().trim();
            String em = tfEmail.getText().trim();
            String ph = tfPhone.getText().trim();
            String pw = new String(pfPass.getPassword());
            String cf = new String(pfConf.getPassword());
            String ad = tfAddr.getText().trim();

            if (n.isEmpty() || em.isEmpty() || ph.isEmpty() || pw.isEmpty() || cf.isEmpty()) {
                showError("Fields marked * are required.");
                return;
            }
            if (!isValidName(n)) {
                showError("Name must be 2-50 letters and spaces only.");
                return;
            }
            if (!isValidEmail(em)) {
                showError("Enter a valid email.\nExample: name@example.com");
                return;
            }
            if (!isValidPhone(ph)) {
                showError("Phone must be exactly 10 digits.");
                return;
            }
            if (!isValidPassword(pw)) {
                showError("Password must be 8+ chars with:\n• 1 uppercase\n• 1 digit\n• 1 special char");
                return;
            }
            if (!pw.equals(cf)) {
                showError("Passwords do not match!");
                return;
            }

            try {
                PreparedStatement chk = con.prepareStatement(
                        "SELECT COUNT(*) FROM CUSTOMERS WHERE UPPER(EMAIL)=UPPER(?)");
                chk.setString(1, em);
                ResultSet rc = chk.executeQuery();
                rc.next();
                if (rc.getInt(1) > 0) {
                    showError("This email is already registered.");
                    return;
                }

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO CUSTOMERS(CUSTOMER_ID,NAME,EMAIL,PHONE,PASSWORD,ADDRESS,CREATED_DATE)"
                                + " VALUES(customer_seq.NEXTVAL,?,?,?,?,?,SYSDATE)");
                ps.setString(1, n);
                ps.setString(2, em);
                ps.setString(3, ph);
                ps.setString(4, pw);
                ps.setString(5, ad.isEmpty() ? null : ad);
                ps.executeUpdate();
                con.commit();
                showSuccess("Registered successfully! You may now log in.");
                cardLayout.show(cardPanel, "CUSTOMER_LOGIN");
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        backBtn.addActionListener(e -> cardLayout.show(cardPanel, "CUSTOMER_LOGIN"));

        return p;
    }

    JPanel createCustomerDashboard() {
        JPanel p = new JPanel(new BorderLayout());
        JTabbedPane tab = new JTabbedPane();
        tab.addTab("Browse Medicines", createCustomerBrowseTab());
        tab.addTab("Shopping Cart", createCustomerCartTab());
        tab.addTab("Checkout", createCustomerCheckoutTab());
        tab.addTab("Order History", createCustomerOrderHistoryTab());
        tab.addTab("My Profile", createCustomerProfileTab());
        tab.addTab("Logout", new JPanel());

        tab.addChangeListener(e -> {
            if (tab.getSelectedIndex() == 5) { // Logout tab
                int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to logout?", "Confirm Logout", JOptionPane.YES_NO_OPTION);
                if (confirm == JOptionPane.YES_OPTION) {
                    loggedInCustomerId = -1;
                    loggedInCustomerName = "";
                    loggedInUserType = "";
                    statusLabel.setText("   Logged Out");
                    cardLayout.show(cardPanel, "ROLE_SELECTION");
                }
                tab.setSelectedIndex(0);
            }
        });

        p.add(tab, BorderLayout.CENTER);
        return p;
    }

    JPanel createCustomerBrowseTab() {
        JPanel p = new JPanel(new BorderLayout(5, 5));
        p.setBorder(BorderFactory.createTitledBorder("Browse Available Medicines"));

        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 6));
        JTextField tfSearch = new JTextField(15);
        JComboBox<String> categoryBox = makeCatBox();
        JButton searchBtn = new JButton("Search");
        JButton refreshBtn = new JButton("Show All");

        searchPanel.add(new JLabel("Search:"));
        searchPanel.add(tfSearch);
        searchPanel.add(new JLabel("Category:"));
        searchPanel.add(categoryBox);
        searchPanel.add(searchBtn);
        searchPanel.add(refreshBtn);

        JTable medicineTable = new JTable();
        medicineTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

        Runnable loadMedicines = () -> {
            try {
                String query = "SELECT MEDICINE_ID,MEDICINE_NAME,MEDICINE_BRAND,UNITSIZE,MRP,GST,SELLING_PRICE,CATEGORY,PRESCRIPTION_REQUIRED\r\n"
                                + "FROM MEDICINE\r\n"
                                + "ORDER BY MEDICINE_ID";
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(query);

                DefaultTableModel m = new DefaultTableModel(
                                new String[]{
                                "ID","Medicine Name","Brand","Unit Size",
                                "MRP","GST %","Selling Price","Category","Rx Required"
                                },0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };
                while (rs.next()) {
                    m.addRow(new Object[]{
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        String.format("%.2f", rs.getDouble(5)),
                        String.format("%.2f", rs.getDouble(6)),
                        String.format("%.2f", rs.getDouble(7)),
                        rs.getString(8),
                        rs.getString(9)
                    });
                }
                medicineTable.setModel(m);
            } catch (Exception ex) {
                showDBError(ex);
            }
        };

        searchBtn.addActionListener(e -> {
            String keyword = tfSearch.getText().trim();
            String category = (String) categoryBox.getSelectedItem();

            try {
                StringBuilder query = new StringBuilder("SELECT MEDICINE_ID,MEDICINE_NAME,MEDICINE_BRAND,SELLING_PRICE,PRESCRIPTION_REQUIRED FROM MEDICINE WHERE 1=1");

                if (!keyword.isEmpty()) {
                    query.append(" AND (UPPER(MEDICINE_NAME) LIKE ? OR UPPER(MEDICINE_BRAND) LIKE ?)");
                }

                query.append(" ORDER BY MEDICINE_ID");

                PreparedStatement ps = con.prepareStatement(query.toString());
                if (!keyword.isEmpty()) {
                    String kw = "%" + keyword.toUpperCase() + "%";
                    ps.setString(1, kw);
                    ps.setString(2, kw);
                }

                ResultSet rs = ps.executeQuery();
                DefaultTableModel m = new DefaultTableModel(
                                new String[]{
                                                "ID",
                                                "Medicine Name",
                                                "Brand",
                                                "Unit Size",
                                                "MRP",
                                                "GST %",
                                                "Selling Price",
                                                "Category",
                                                "Rx Required"
                                                }, 0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };
                while (rs.next()) {
                        m.addRow(new Object[]{
                                        rs.getInt(1),
                                        rs.getString(2),
                                        rs.getString(3),
                                        rs.getInt(4),
                                        String.format("%.2f", rs.getDouble(5)),
                                        String.format("%.2f", rs.getDouble(6)),
                                        String.format("%.2f", rs.getDouble(7)),
                                        rs.getString(8),
                                        rs.getString(9)
                                        });
                }
                medicineTable.setModel(m);
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        refreshBtn.addActionListener(e -> loadMedicines.run());

        p.add(searchPanel, BorderLayout.NORTH);
        p.add(new JScrollPane(medicineTable), BorderLayout.CENTER);

        loadMedicines.run();
        return p;
    }

    JPanel createCustomerCartTab() {
        JPanel p = new JPanel(new BorderLayout(5, 5));
        p.setBorder(BorderFactory.createTitledBorder("Shopping Cart"));

        JPanel inputPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 6));
        JTextField tfMedId = new JTextField(6);
        JTextField tfQty = new JTextField(4);
        JButton addBtn = new JButton("Add to Cart");
        JButton viewBtn = new JButton("View Cart");
        JButton removeBtn = new JButton("Remove Item");
        JButton clearBtn = new JButton("Clear Cart");

        inputPanel.add(new JLabel("Medicine ID:"));
        inputPanel.add(tfMedId);
        inputPanel.add(new JLabel("Quantity:"));
        inputPanel.add(tfQty);
        inputPanel.add(addBtn);
        inputPanel.add(viewBtn);
        inputPanel.add(removeBtn);
        inputPanel.add(clearBtn);

        JTable cartTable = new JTable();
        JLabel totalLabel = new JLabel("  Cart Total: INR 0.00");
        totalLabel.setFont(new Font("SansSerif", Font.BOLD, 14));

        addBtn.addActionListener(e -> {
            String midStr = tfMedId.getText().trim();
            String qtyStr = tfQty.getText().trim();

            if (midStr.isEmpty() || qtyStr.isEmpty()) {
                showError("Enter both Medicine ID and Quantity.");
                return;
            }

            try {
                int mid = Integer.parseInt(midStr);
                int qty = Integer.parseInt(qtyStr);

                if (mid <= 0 || qty <= 0) {
                    showError("Medicine ID and Quantity must be positive.");
                    return;
                }
                PreparedStatement chk = con.prepareStatement(
                        "SELECT MEDICINE_NAME, UNITSIZE FROM MEDICINE WHERE MEDICINE_ID=?");

                chk.setInt(1, mid);
                ResultSet rc = chk.executeQuery();

                if (!rc.next()) {
                    showError("No medicine found with ID " + mid);
                    return;
                }

                String medName = rc.getString(1);
                int stock = rc.getInt(2);

                if (qty > stock) {
                    JOptionPane.showMessageDialog(this,
                            "Not Stock Available\nOnly " + stock + " units available.",
                            "Stock Error",
                            JOptionPane.WARNING_MESSAGE);
                    return;
                }

                int cartId = getOrCreateCustomerCart();
                PreparedStatement exChk = con.prepareStatement(
                        "SELECT QUANTITY FROM CART_ITEMS WHERE CART_ID=? AND MEDICINE_ID=?");
                exChk.setInt(1, cartId);
                exChk.setInt(2, mid);
                ResultSet er = exChk.executeQuery();

                if (er.next()) {
                    int existQty = er.getInt(1);
                    PreparedStatement up = con.prepareStatement(
                            "UPDATE CART_ITEMS SET QUANTITY=? WHERE CART_ID=? AND MEDICINE_ID=?");
                    up.setInt(1, existQty + qty);
                    up.setInt(2, cartId);
                    up.setInt(3, mid);
                    up.executeUpdate();
                } else {
                    PreparedStatement ins = con.prepareStatement(
                            "INSERT INTO CART_ITEMS(CART_ITEM_ID,CART_ID,MEDICINE_ID,QUANTITY) VALUES(cart_item_seq.NEXTVAL,?,?,?)");
                    ins.setInt(1, cartId);
                    ins.setInt(2, mid);
                    ins.setInt(3, qty);
                    ins.executeUpdate();
                }
                con.commit();
                showSuccess("Added to cart!");
                tfMedId.setText("");
                tfQty.setText("");
                viewBtn.doClick();
            } catch (NumberFormatException ex) {
                showError("Medicine ID and Quantity must be numbers.");
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        viewBtn.addActionListener(e -> {
            try {
                int cartId = getOrCreateCustomerCart();
                PreparedStatement ps = con.prepareStatement(
                        "SELECT CI.CART_ITEM_ID,M.MEDICINE_ID,M.MEDICINE_NAME,M.SELLING_PRICE,CI.QUANTITY,(M.SELLING_PRICE*CI.QUANTITY) SUB"
                                + " FROM CART_ITEMS CI JOIN MEDICINE M ON CI.MEDICINE_ID=M.MEDICINE_ID WHERE CI.CART_ID=?");
                ps.setInt(1, cartId);
                ResultSet rs = ps.executeQuery();

                DefaultTableModel m = new DefaultTableModel(
                        new String[]{"Item ID", "Med ID", "Medicine", "Unit Price", "Qty", "Subtotal"}, 0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };

                double total = 0;
                while (rs.next()) {
                    total += rs.getDouble(6);
                    m.addRow(new Object[]{rs.getInt(1), rs.getInt(2), rs.getString(3),
                            String.format("%.2f", rs.getDouble(4)), rs.getInt(5),
                            String.format("%.2f", rs.getDouble(6))});
                }
                cartTable.setModel(m);
                totalLabel.setText("  Cart Total: INR " + String.format("%.2f", total));
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        removeBtn.addActionListener(e -> {
            int row = cartTable.getSelectedRow();
            if (row < 0) {
                showError("Select an item to remove.");
                return;
            }

            try {
                int itemId = Integer.parseInt(cartTable.getValueAt(row, 0).toString());
                PreparedStatement ps = con.prepareStatement("DELETE FROM CART_ITEMS WHERE CART_ITEM_ID=?");
                ps.setInt(1, itemId);
                ps.executeUpdate();
                con.commit();
                viewBtn.doClick();
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        clearBtn.addActionListener(e -> {
            int confirm = JOptionPane.showConfirmDialog(this, "Clear all items from cart?", "Confirm", JOptionPane.YES_NO_OPTION);
            if (confirm == JOptionPane.YES_OPTION) {
                try {
                    int cartId = getOrCreateCustomerCart();
                    PreparedStatement ps = con.prepareStatement("DELETE FROM CART_ITEMS WHERE CART_ID=?");
                    ps.setInt(1, cartId);
                    ps.executeUpdate();
                    con.commit();
                    cartTable.setModel(new DefaultTableModel());
                    totalLabel.setText("  Cart Total: INR 0.00");
                } catch (Exception ex) {
                    showDBError(ex);
                }
            }
        });

        p.add(inputPanel, BorderLayout.NORTH);
        p.add(new JScrollPane(cartTable), BorderLayout.CENTER);
        p.add(totalLabel, BorderLayout.SOUTH);
        return p;
    }

    JPanel createCustomerCheckoutTab() {
        JPanel p = new JPanel(new BorderLayout(5, 5));
        p.setBorder(BorderFactory.createTitledBorder("Checkout"));

        JTable preview = new JTable();
        JLabel addrLabel = new JLabel("  Delivery Address: (not loaded)");
        JLabel totalLabel = new JLabel("  Cart Total: INR 0.00");
        totalLabel.setFont(new Font("SansSerif", Font.BOLD, 14));
        JButton loadBtn = new JButton("Load Cart & Address");
        JButton placeBtn = new JButton("Place Order");
        placeBtn.setEnabled(false);

        final double[] total = {0.0};

        loadBtn.addActionListener(e -> {
            try {
                PreparedStatement ps2 = con.prepareStatement("SELECT ADDRESS FROM CUSTOMERS WHERE CUSTOMER_ID=?");
                ps2.setInt(1, loggedInCustomerId);
                ResultSet r2 = ps2.executeQuery();
                String addr = "(No address saved)";
                if (r2.next() && r2.getString(1) != null) {
                    addr = r2.getString(1);
                }
                addrLabel.setText("<html>  <b>Delivery Address:</b> " + addr + "</html>");

                int cartId = getOrCreateCustomerCart();
                PreparedStatement ps = con.prepareStatement(
SELECT M.MEDICINE_NAME,M.SELLING_PRICE,CI.QUANTITY,(M.SELLING_PRICE*CI.QUANTITY) SUB"
                                + " FROM CART_ITEMS CI JOIN MEDICINE M ON CI.MEDICINE_ID=M.MEDICINE_ID WHERE CI.CART_ID=?");
                ps.setInt(1, cartId);
                ResultSet rs = ps.executeQuery();

                DefaultTableModel m = new DefaultTableModel(
                        new String[]{"Medicine", "Unit Price", "Qty", "Subtotal"}, 0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };

                double t = 0;
                while (rs.next()) {
                    t += rs.getDouble(4);
                    m.addRow(new Object[]{rs.getString(1),
                            String.format("%.2f", rs.getDouble(2)),
                            rs.getInt(3),
                            String.format("%.2f", rs.getDouble(4))});
                }

                preview.setModel(m);
                total[0] = t;
                totalLabel.setText("  Cart Total: INR " + String.format("%.2f", t));
                placeBtn.setEnabled(t > 0);
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        placeBtn.addActionListener(e -> {
            int confirm = JOptionPane.showConfirmDialog(this,
                    "Confirm order for INR " + String.format("%.2f", total[0]) + "?",
                    "Confirm Order", JOptionPane.YES_NO_OPTION);
            if (confirm == JOptionPane.YES_OPTION) {
                placeCustomerOrder(() -> {
                    preview.setModel(new DefaultTableModel());
                    totalLabel.setText("  Cart Total: INR 0.00");
                    placeBtn.setEnabled(false);
                });
            }
        });

        JPanel south = new JPanel(new GridLayout(3, 1, 3, 3));
        south.add(addrLabel);
        south.add(totalLabel);
        south.add(placeBtn);

        p.add(loadBtn, BorderLayout.NORTH);
        p.add(new JScrollPane(preview), BorderLayout.CENTER);
        p.add(south, BorderLayout.SOUTH);
        return p;
    }

    JPanel createCustomerOrderHistoryTab() {
        JPanel p = new JPanel(new BorderLayout(5, 5));
        p.setBorder(BorderFactory.createTitledBorder("My Order History"));

        JTable ordersTable = new JTable();
        JTable itemsTable = new JTable();
        JButton loadBtn = new JButton("Load My Orders");

        loadBtn.addActionListener(e -> {
            try {
                PreparedStatement ps = con.prepareStatement(
                        "SELECT ORDER_ID,ORDER_DATE,TOTAL_AMOUNT,ORDER_STATUS FROM ORDERS WHERE CUSTOMER_ID=? ORDER BY ORDER_DATE DESC");
                ps.setInt(1, loggedInCustomerId);
                ResultSet rs = ps.executeQuery();

                DefaultTableModel m = new DefaultTableModel(
                        new String[]{"Order ID", "Date", "Total (INR)", "Status"}, 0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };

                while (rs.next()) {
                    m.addRow(new Object[]{rs.getInt(1), rs.getTimestamp(2),
                            String.format("%.2f", rs.getDouble(3)), rs.getString(4)});
                }
                ordersTable.setModel(m);
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        ordersTable.getSelectionModel().addListSelectionListener(ev -> {
            if (ev.getValueIsAdjusting()) return;
            int row = ordersTable.getSelectedRow();
            if (row < 0) return;

            try {
                int orderId = Integer.parseInt(ordersTable.getValueAt(row, 0).toString());
                PreparedStatement ps = con.prepareStatement(
                        "SELECT M.MEDICINE_NAME,OI.QUANTITY,OI.PRICE,(OI.QUANTITY*OI.PRICE) SUB"
                                + " FROM ORDER_ITEMS OI JOIN MEDICINE M ON OI.MEDICINE_ID=M.MEDICINE_ID WHERE OI.ORDER_ID=?");
                ps.setInt(1, orderId);
                ResultSet rs = ps.executeQuery();

                DefaultTableModel m = new DefaultTableModel(
                        new String[]{"Medicine", "Qty", "Unit Price", "Subtotal"}, 0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };

                while (rs.next()) {
                    m.addRow(new Object[]{rs.getString(1), rs.getInt(2),
                            String.format("%.2f", rs.getDouble(3)),
                            String.format("%.2f", rs.getDouble(4))});
                }
                itemsTable.setModel(m);
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        JSplitPane split = new JSplitPane(JSplitPane.VERTICAL_SPLIT,
                new JScrollPane(ordersTable), new JScrollPane(itemsTable));
        split.setDividerLocation(200);

        p.add(loadBtn, BorderLayout.NORTH);
        p.add(split, BorderLayout.CENTER);
        return p;
    }

    JPanel createCustomerProfileTab() {
        JPanel p = new JPanel(new GridBagLayout());
        p.setBorder(BorderFactory.createTitledBorder("Update My Profile"));
        GridBagConstraints g = new GridBagConstraints();
        g.insets = new Insets(8, 10, 8, 10);
        g.fill = GridBagConstraints.HORIZONTAL;
        JTextField tfName = new JTextField(25);
        JTextField tfPhone = new JTextField(25);
        JPasswordField pfPass = new JPasswordField(25);
        JPasswordField pfConf = new JPasswordField(25);
        JTextArea taAddr = new JTextArea(3, 25);
        taAddr.setLineWrap(true);
        JButton loadBtn = new JButton("Load My Data");
        JButton saveBtn = new JButton("Save Changes");
        g.gridx = 0; g.gridy = 0; p.add(new JLabel("Name *"), g);
        g.gridx = 1; p.add(tfName, g);
        g.gridx = 0; g.gridy = 1; p.add(new JLabel("Phone (10 digits) *"), g);
        g.gridx = 1; p.add(tfPhone, g);
        g.gridx = 0; g.gridy = 2; p.add(new JLabel("New Password"), g);
        g.gridx = 1; p.add(pfPass, g);
        g.gridx = 0; g.gridy = 3; p.add(new JLabel("Confirm Password"), g);
        g.gridx = 1; p.add(pfConf, g);
        g.gridx = 0; g.gridy = 4; p.add(new JLabel("Address"), g);
        g.gridx = 1; p.add(new JScrollPane(taAddr), g);
        g.gridx = 1; g.gridy = 5; p.add(loadBtn, g);
        g.gridx = 1; g.gridy = 6; p.add(saveBtn, g);

        loadBtn.addActionListener(e -> {
            try {
                PreparedStatement ps = con.prepareStatement(
                        "SELECT NAME,PHONE,ADDRESS FROM CUSTOMERS WHERE CUSTOMER_ID=?");
                ps.setInt(1, loggedInCustomerId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    tfName.setText(rs.getString(1));
                    tfPhone.setText(rs.getString(2) == null ? "" : rs.getString(2));
                    taAddr.setText(rs.getString(3) == null ? "" : rs.getString(3));
                }
            } catch (Exception ex) {
                showDBError(ex);
            }
        });
        saveBtn.addActionListener(e -> {
            String n = tfName.getText().trim();
            String ph = tfPhone.getText().trim();
            String pw = new String(pfPass.getPassword());
            String cf = new String(pfConf.getPassword());
            String ad = taAddr.getText().trim();

            if (n.isEmpty() || ph.isEmpty()) {
                showError("Name and Phone are required.");
                return;
            }
            if (!isValidName(n)) {
                showError("Name must be 2-50 letters and spaces only.");
                return;
            }
            if (!isValidPhone(ph)) {
                showError("Phone must be exactly 10 digits.");
                return;
            }
            if (!pw.isEmpty()) {
                if (!isValidPassword(pw)) {
                    showError("Password must be 8+ chars with uppercase, digit, special char.");
                    return;
                }
                if (!pw.equals(cf)) {
                    showError("Passwords do not match!");
                    return;
                }
            }
            try {
                String sql = pw.isEmpty()
                        ? "UPDATE CUSTOMERS SET NAME=?,PHONE=?,ADDRESS=? WHERE CUSTOMER_ID=?"
                        : "UPDATE CUSTOMERS SET NAME=?,PHONE=?,ADDRESS=?,PASSWORD=? WHERE CUSTOMER_ID=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, n);
                ps.setString(2, ph);
                ps.setString(3, ad.isEmpty() ? null : ad);
                if (!pw.isEmpty()) {
                    ps.setString(4, pw);
                    ps.setInt(5, loggedInCustomerId);
                } else {
                    ps.setInt(4, loggedInCustomerId);
                }
                ps.executeUpdate();
                con.commit();
                loggedInCustomerName = n;
                statusLabel.setText("   Logged in: " + n + " (Customer)");
                showSuccess("Profile updated!");
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        return p;
    }
    JPanel createAdminLoginTab() {
        JPanel p = new JPanel(new GridBagLayout());
        p.setBackground(new Color(245, 245, 245));
        p.setBorder(BorderFactory.createTitledBorder("Admin Login"));
        GridBagConstraints g = new GridBagConstraints();
        g.insets = new Insets(10, 15, 10, 15);
        g.fill = GridBagConstraints.HORIZONTAL;

        JTextField tfUser = new JTextField(25);
        JPasswordField pfPass = new JPasswordField(25);
        JButton loginBtn = new JButton("Login");
        JButton backBtn = new JButton("Back to Role Selection");

        loginBtn.setBackground(new Color(231, 76, 60));
        loginBtn.setForeground(Color.WHITE);
        g.gridx = 0; g.gridy = 0; p.add(new JLabel("Username *"), g);
        g.gridx = 1; p.add(tfUser, g);
        g.gridx = 0; g.gridy = 1; p.add(new JLabel("Password *"), g);
        g.gridx = 1; p.add(pfPass, g);
        g.gridx = 1; g.gridy = 2; p.add(loginBtn, g);
        g.gridx = 1; g.gridy = 3; p.add(backBtn, g);
        loginBtn.addActionListener(e -> {
            String user = tfUser.getText().trim();
            String pass = new String(pfPass.getPassword());
            if (user.isEmpty() || pass.isEmpty()) {
                showError("Username and password are required.");
                return;
            }
            if (user.equals(ADMIN_ID) && pass.equals(ADMIN_PASS)) {
                loggedInUserType = "ADMIN";
                statusLabel.setText("   Logged in: Admin");
                showSuccess("Welcome Admin!");
                cardLayout.show(cardPanel, "ADMIN_DASHBOARD");
                tfUser.setText("");
                pfPass.setText("");
            } else {
                showError("Invalid admin credentials.");
            }
        });
        backBtn.addActionListener(e -> {
            loggedInUserType = "";
            cardLayout.show(cardPanel, "ROLE_SELECTION");
        });

        return p;
    }
    JPanel createAdminDashboard() {
        JPanel p = new JPanel(new BorderLayout());
        JTabbedPane tab = new JTabbedPane();
        tab.addTab("Add Medicine", createAdminAddMedicineTab());
        tab.addTab("Manage Medicines", createAdminManageMedicinesTab());
        tab.addTab("View All Orders", createAdminViewOrdersTab());
        tab.addTab("Update Order Status", createAdminUpdateOrderStatusTab());
        tab.addTab("Logout", new JPanel());
        tab.addChangeListener(e -> {
            if (tab.getSelectedIndex() == 4) { // Logout tab
                int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to logout?", "Confirm Logout", JOptionPane.YES_NO_OPTION);
                if (confirm == JOptionPane.YES_OPTION) {
                    loggedInUserType = "";
                    statusLabel.setText("   Logged Out");
                    cardLayout.show(cardPanel, "ROLE_SELECTION");
                }
                tab.setSelectedIndex(0);
            }
        });
        p.add(tab, BorderLayout.CENTER);
        return p;
    }
    JPanel createAdminAddMedicineTab() {
        JPanel p = new JPanel(new GridBagLayout());
        p.setBorder(BorderFactory.createTitledBorder("Add New Medicine"));
        GridBagConstraints g = new GridBagConstraints();
        g.insets = new Insets(8, 10, 8, 10);
        g.fill = GridBagConstraints.HORIZONTAL;
        JTextField tfName = new JTextField(25);
        JTextField tfBrand = new JTextField(25);
        JTextField tfUnitSize = new JTextField(25);
        JTextField tfMRP = new JTextField(25);
        JTextField tfGST = new JTextField(25);
        JTextField tfSelling = new JTextField(25);
        JComboBox<String> catBox = makeCatBox();
        JComboBox<String> prescBox = new JComboBox<>(new String[]{"Yes", "No"});
        JButton addBtn = new JButton("Add Medicine");
        JButton clearBtn = new JButton("Clear Form");
        addBtn.setBackground(new Color(46, 204, 113));
        addBtn.setForeground(Color.WHITE);
        g.gridx = 0; g.gridy = 0; p.add(new JLabel("Medicine Name *"), g);
        g.gridx = 1; p.add(tfName, g);
        g.gridx = 0; g.gridy = 1; p.add(new JLabel("Brand *"), g);
        g.gridx = 1; p.add(tfBrand, g);
        g.gridx = 0; g.gridy = 2; p.add(new JLabel("Unit Size *"), g);
        g.gridx = 1; p.add(tfUnitSize, g);
        g.gridx = 0; g.gridy = 3; p.add(new JLabel("MRP (INR) *"), g);
        g.gridx = 1; p.add(tfMRP, g);
        g.gridx = 0; g.gridy = 4; p.add(new JLabel("GST (%) *"), g);
        g.gridx = 1; p.add(tfGST, g);
        g.gridx = 0; g.gridy = 5; p.add(new JLabel("Selling Price (INR) *"), g);
        g.gridx = 1; p.add(tfSelling, g);
        g.gridx = 0; g.gridy = 6; p.add(new JLabel("Category *"), g);
        g.gridx = 1; p.add(catBox, g);
        g.gridx = 0; g.gridy = 7; p.add(new JLabel("Prescription Required *"), g);
        g.gridx = 1; p.add(prescBox, g);
        g.gridx = 1; g.gridy = 8; p.add(addBtn, g);
        g.gridx = 1; g.gridy = 9; p.add(clearBtn, g);

        addBtn.addActionListener(e -> {
            String n = tfName.getText().trim();
            String b = tfBrand.getText().trim();
            String us = tfUnitSize.getText().trim();
            String mr = tfMRP.getText().trim();
            String gs = tfGST.getText().trim();
            String sp = tfSelling.getText().trim();
            String c = (String) catBox.getSelectedItem();
            String pr = (String) prescBox.getSelectedItem();

            if (n.isEmpty() || b.isEmpty() || us.isEmpty() || mr.isEmpty() || gs.isEmpty() || sp.isEmpty()) {
                showError("All fields marked * are required.");
                return;
            }
            if (n.length() < 2 || n.length() > 100) {
                showError("Medicine name must be 2-100 characters.");
                return;
            }
            if (!isValidCategory(c)) {
                showError("Please select a valid category.");
                return;
            }
            if (!isValidPrice(mr)) {
                showError("MRP must be a positive number.");
                return;
            }
            if (!isValidPrice(gs) || Double.parseDouble(gs) > 100) {
                showError("GST must be between 0 and 100.");
                return;
            }
            if (!isValidPrice(sp)) {
                showError("Selling Price must be a positive number.");
                return;
            }

            try {
                PreparedStatement ps = con.prepareStatement(
                                "INSERT INTO MEDICINE(MEDICINE_ID,MEDICINE_NAME,MEDICINE_BRAND,UNITSIZE,MRP,GST,SELLING_PRICE,CATEGORY,PRESCRIPTION_REQUIRED)"
                                + " VALUES(medicine_seq.NEXTVAL,?,?,?,?,?,?,?,?)");
                ps.setString(1, n);
                ps.setString(2, b);
                ps.setInt(3, Integer.parseInt(us));
                ps.setDouble(4, Double.parseDouble(mr));
                ps.setDouble(5, Double.parseDouble(gs));
                ps.setDouble(6, Double.parseDouble(sp));
                ps.setString(7, pr);
                ps.setString(8, c);
                ps.executeUpdate();
                con.commit();
                showSuccess("Medicine \"" + n + "\" added successfully!");
                tfName.setText("");
                tfBrand.setText("");
                tfUnitSize.setText("");
                tfMRP.setText("");
                tfGST.setText("");
                tfSelling.setText("");
                catBox.setSelectedIndex(0);
                prescBox.setSelectedIndex(0);
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        clearBtn.addActionListener(e -> {
            tfName.setText("");
            tfBrand.setText("");
            tfUnitSize.setText("");
            tfMRP.setText("");
            tfGST.setText("");
            tfSelling.setText("");
            catBox.setSelectedIndex(0);
            prescBox.setSelectedIndex(0);
        });

        return p;
    }

    JPanel createAdminManageMedicinesTab() {
        JPanel p = new JPanel(new BorderLayout(5, 5));
        p.setBorder(BorderFactory.createTitledBorder("Manage Medicines"));
        JTable medicineTable = new JTable();
        JButton refreshBtn = new JButton("Refresh");
        JButton editBtn = new JButton("Edit Selected");
        JButton deleteBtn = new JButton("Delete Selected");
        JPanel editPanel = new JPanel(new GridBagLayout());
        editPanel.setBorder(BorderFactory.createTitledBorder("Edit Medicine"));
        GridBagConstraints g = new GridBagConstraints();
        g.insets = new Insets(6, 8, 6, 8);
        g.fill = GridBagConstraints.HORIZONTAL;
        JTextField eName = new JTextField(20);
        JTextField eBrand = new JTextField(20);
        JTextField eUnitSize = new JTextField(20);
        JTextField eMRP = new JTextField(20);
        JTextField eGST = new JTextField(20);
        JTextField eSelling = new JTextField(20);
        JComboBox<String> ePres = new JComboBox<>(new String[]{"Yes", "No"});
        JButton updateBtn = new JButton("Save Changes");
        updateBtn.setBackground(new Color(46, 204, 113));
        updateBtn.setForeground(Color.WHITE);
        g.gridx = 0; g.gridy = 0; editPanel.add(new JLabel("Medicine Name *"), g);
        g.gridx = 1; editPanel.add(eName, g);
        g.gridx = 0; g.gridy = 1; editPanel.add(new JLabel("Brand *"), g);
        g.gridx = 1; editPanel.add(eBrand, g);
        g.gridx = 0; g.gridy = 2; editPanel.add(new JLabel("Unit Size *"), g);
        g.gridx = 1; editPanel.add(eUnitSize, g);
        g.gridx = 0; g.gridy = 3; editPanel.add(new JLabel("MRP (INR) *"), g);
        g.gridx = 1; editPanel.add(eMRP, g);
        g.gridx = 0; g.gridy = 4; editPanel.add(new JLabel("GST (%) *"), g);
        g.gridx = 1; editPanel.add(eGST, g);
        g.gridx = 0; g.gridy = 5; editPanel.add(new JLabel("Selling Price (INR) *"), g);
        g.gridx = 1; editPanel.add(eSelling, g);
        g.gridx = 0; g.gridy = 6; editPanel.add(new JLabel("Prescription Required *"), g);
        g.gridx = 1; editPanel.add(ePres, g);
        g.gridx = 1; g.gridy = 7; editPanel.add(updateBtn, g);

        Runnable loadMedicines = () -> {
            try {
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(
                                "SELECT MEDICINE_ID,MEDICINE_NAME,MEDICINE_BRAND,UNITSIZE,MRP,GST,SELLING_PRICE,CATEGORY,PRESCRIPTION_REQUIRED FROM MEDICINE ORDER BY MEDICINE_ID");
                DefaultTableModel m = new DefaultTableModel(
                                new String[]{
                                "ID","Medicine Name","Brand","Unit Size",
                                "MRP","GST %","Selling Price","Category","Rx Required"
                                },0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };
                while (rs.next()) {
                        m.addRow(new Object[]{
                                        rs.getInt(1),
                                        rs.getString(2),
                                        rs.getString(3),
                                        rs.getInt(4),
                                        rs.getDouble(5),
                                        rs.getDouble(6),
                                        rs.getDouble(7),
                                        rs.getString(8),
                                        rs.getString(9)
                                        });
                }
                medicineTable.setModel(m);
            } catch (Exception ex) {
                showDBError(ex);
            }
        };

        refreshBtn.addActionListener(e -> loadMedicines.run());

        medicineTable.getSelectionModel().addListSelectionListener(ev -> {
            if (ev.getValueIsAdjusting()) return;
            int row = medicineTable.getSelectedRow();
            if (row < 0) return;
            eName.setText(medicineTable.getValueAt(row, 1).toString());
            eBrand.setText(medicineTable.getValueAt(row, 2).toString());
            eUnitSize.setText(medicineTable.getValueAt(row, 3).toString());
            eMRP.setText(medicineTable.getValueAt(row, 4).toString());
            eGST.setText(medicineTable.getValueAt(row, 5).toString());
            eSelling.setText(medicineTable.getValueAt(row, 6).toString());
            ePres.setSelectedItem(medicineTable.getValueAt(row, 7).toString());
        });

        editBtn.addActionListener(e -> {
            int row = medicineTable.getSelectedRow();
            if (row < 0) {
                showError("Select a medicine to edit.");
                return;
            }
            // Load into edit fields (already done by listener)
            showSuccess("Edit the fields below and click 'Save Changes'");
        });

        updateBtn.addActionListener(e -> {
            int row = medicineTable.getSelectedRow();
            if (row < 0) {
                showError("Select a medicine to update.");
                return;
            }
            int mid = Integer.parseInt(medicineTable.getValueAt(row, 0).toString());
            String n = eName.getText().trim();
            String b = eBrand.getText().trim();
            String us = eUnitSize.getText().trim();
            String mr = eMRP.getText().trim();
            String gs = eGST.getText().trim();
            String sp = eSelling.getText().trim();
            String pr = (String) ePres.getSelectedItem();

            if (n.isEmpty() || b.isEmpty() || us.isEmpty() || mr.isEmpty() || gs.isEmpty() || sp.isEmpty()) {
                showError("All required fields must be filled.");
                return;
            }
            if (!isValidPrice(mr)) {
                showError("MRP must be a positive number.");
                return;
            }
            if (!isValidPrice(gs) || Double.parseDouble(gs) > 100) {
                showError("GST must be between 0 and 100.");
                return;
            }
            if (!isValidPrice(sp)) {
                showError("Selling Price must be a positive number.");
                return;
            }
            try {
                PreparedStatement ps = con.prepareStatement(
                        "UPDATE MEDICINE SET MEDICINE_NAME=?,MEDICINE_BRAND=?,UNITSIZE=?,MRP=?,GST=?,SELLING_PRICE=?,PRESCRIPTION_REQUIRED=? WHERE MEDICINE_ID=?");
                ps.setString(1, n);
                ps.setString(2, b);
                ps.setInt(3, Integer.parseInt(us));
                ps.setDouble(4, Double.parseDouble(mr));
                ps.setDouble(5, Double.parseDouble(gs));
                ps.setDouble(6, Double.parseDouble(sp));
                ps.setString(7, pr);
                ps.setInt(8, mid);
                ps.executeUpdate();
                con.commit();
                showSuccess("Medicine updated successfully!");
                loadMedicines.run();
            } catch (Exception ex) {
                showDBError(ex);
            }
        });
        deleteBtn.addActionListener(e -> {
            int row = medicineTable.getSelectedRow();
            if (row < 0) {
                showError("Select a medicine to delete.");
                return;
            }
        }
int mid = Integer.parseInt(medicineTable.getValueAt(row, 0).toString());
            String mn = medicineTable.getValueAt(row, 1).toString();
            int confirm = JOptionPane.showConfirmDialog(this,
                    "Delete medicine \"" + mn + "\" (ID=" + mid + ")? This action cannot be undone.",
                    "Confirm Delete", JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE);
            if (confirm == JOptionPane.YES_OPTION) {
                try {
                    PreparedStatement ps = con.prepareStatement("DELETE FROM MEDICINE WHERE MEDICINE_ID=?");
                    ps.setInt(1, mid);
                    ps.executeUpdate();
                    con.commit();
                    showSuccess("Medicine deleted successfully!");
                    loadMedicines.run();
                } catch (Exception ex) {
                    showDBError(ex);
                }
            }
        });
        JPanel btnPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 6));
        btnPanel.add(refreshBtn);
        btnPanel.add(editBtn);
        btnPanel.add(deleteBtn);
        JSplitPane split = new JSplitPane(JSplitPane.VERTICAL_SPLIT,
                new JScrollPane(medicineTable), editPanel);
        split.setDividerLocation(250);
        p.add(btnPanel, BorderLayout.NORTH);
        p.add(split, BorderLayout.CENTER);

        loadMedicines.run();
        return p;
    }
    JPanel createAdminViewOrdersTab() {
        JPanel p = new JPanel(new BorderLayout(5, 5));
        p.setBorder(BorderFactory.createTitledBorder("All Orders"));

        JTable ordersTable = new JTable();
        JTable itemsTable = new JTable();
        JButton loadBtn = new JButton("Load All Orders");

        loadBtn.addActionListener(e -> {
            try {
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(
                        "SELECT O.ORDER_ID,C.NAME,O.ORDER_DATE,O.TOTAL_AMOUNT,O.ORDER_STATUS"
                                + " FROM ORDERS O JOIN CUSTOMERS C ON O.CUSTOMER_ID=C.CUSTOMER_ID"
                                + " ORDER BY O.ORDER_DATE DESC");
                DefaultTableModel m = new DefaultTableModel(
                        new String[]{"Order ID", "Customer", "Date", "Total (INR)", "Status"}, 0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };
                while (rs.next()) {
                    m.addRow(new Object[]{rs.getInt(1), rs.getString(2),
                            rs.getTimestamp(3),
                            String.format("%.2f", rs.getDouble(4)), rs.getString(5)});
                }
                ordersTable.setModel(m);
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        ordersTable.getSelectionModel().addListSelectionListener(ev -> {
            if (ev.getValueIsAdjusting()) return;
            int row = ordersTable.getSelectedRow();
            if (row < 0) return;

            try {
                int orderId = Integer.parseInt(ordersTable.getValueAt(row, 0).toString());
                PreparedStatement ps = con.prepareStatement(
                        "SELECT M.MEDICINE_NAME,OI.QUANTITY,OI.PRICE,(OI.QUANTITY*OI.PRICE) SUB"
                                + " FROM ORDER_ITEMS OI JOIN MEDICINE M ON OI.MEDICINE_ID=M.MEDICINE_ID"
                                + " WHERE OI.ORDER_ID=?");
                ps.setInt(1, orderId);
                ResultSet rs = ps.executeQuery();

                DefaultTableModel m = new DefaultTableModel(
                        new String[]{"Medicine", "Qty", "Unit Price", "Subtotal"}, 0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };

                while (rs.next()) {
                    m.addRow(new Object[]{rs.getString(1), rs.getInt(2),
                            String.format("%.2f", rs.getDouble(3)),
                            String.format("%.2f", rs.getDouble(4))});
                }
                itemsTable.setModel(m);
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        JSplitPane split = new JSplitPane(JSplitPane.VERTICAL_SPLIT,
                new JScrollPane(ordersTable), new JScrollPane(itemsTable));
        split.setDividerLocation(250);

        p.add(loadBtn, BorderLayout.NORTH);
        p.add(split, BorderLayout.CENTER);
        return p;
    }

    JPanel createAdminUpdateOrderStatusTab() {
        JPanel p = new JPanel(new BorderLayout(5, 5));
        p.setBorder(BorderFactory.createTitledBorder("Update Order Status"));

        JTable ordersTable = new JTable();
        JComboBox<String> statusBox = new JComboBox<>(new String[]{"Pending", "Processing", "Shipped", "Delivered", "Cancelled"});
        JButton loadBtn = new JButton("Load All Orders");
        JButton updateBtn = new JButton("Update Status");

        loadBtn.addActionListener(e -> {
            try {
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(
                        "SELECT O.ORDER_ID,C.NAME,O.ORDER_DATE,O.TOTAL_AMOUNT,O.ORDER_STATUS"
                                + " FROM ORDERS O JOIN CUSTOMERS C ON O.CUSTOMER_ID=C.CUSTOMER_ID"
                                + " ORDER BY O.ORDER_DATE DESC");
                DefaultTableModel m = new DefaultTableModel(
                        new String[]{"Order ID", "Customer", "Date", "Total (INR)", "Status"}, 0) {
                    public boolean isCellEditable(int r, int c) { return false; }
                };
                while (rs.next()) {
                    m.addRow(new Object[]{rs.getInt(1), rs.getString(2),
                            rs.getTimestamp(3),
                            String.format("%.2f", rs.getDouble(4)), rs.getString(5)});
                }
                ordersTable.setModel(m);
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        updateBtn.addActionListener(e -> {
            int row = ordersTable.getSelectedRow();
            if (row < 0) {
                showError("Select an order to update.");
                return;
            }

            try {
                int orderId = Integer.parseInt(ordersTable.getValueAt(row, 0).toString());
                String newStatus = (String) statusBox.getSelectedItem();

                PreparedStatement ps = con.prepareStatement("UPDATE ORDERS SET ORDER_STATUS=? WHERE ORDER_ID=?");
                ps.setString(1, newStatus);
                ps.setInt(2, orderId);
                ps.executeUpdate();
                con.commit();

                showSuccess("Order #" + orderId + " status updated to: " + newStatus);
                loadBtn.doClick();
            } catch (Exception ex) {
                showDBError(ex);
            }
        });

        JPanel controlPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 6));
        controlPanel.add(loadBtn);
        controlPanel.add(new JLabel("New Status:"));
        controlPanel.add(statusBox);
        controlPanel.add(updateBtn);

        p.add(controlPanel, BorderLayout.NORTH);
        p.add(new JScrollPane(ordersTable), BorderLayout.CENTER);
        return p;
    }
    int getOrCreateCustomerCart() throws SQLException {
        PreparedStatement s1 = con.prepareStatement(
                "SELECT CART_ID FROM CART WHERE CUSTOMER_ID=? AND ROWNUM=1");
        s1.setInt(1, loggedInCustomerId);
        ResultSet r1 = s1.executeQuery();
        if (r1.next()) return r1.getInt(1);
        PreparedStatement ins = con.prepareStatement(
                "INSERT INTO CART(CART_ID,CUSTOMER_ID,CREATED_DATE) VALUES(cart_seq.NEXTVAL,?,SYSDATE)");
        ins.setInt(1, loggedInCustomerId);
        ins.executeUpdate();

        PreparedStatement s2 = con.prepareStatement(
                "SELECT MAX(CART_ID) FROM CART WHERE CUSTOMER_ID=?");
        s2.setInt(1, loggedInCustomerId);
        ResultSet r2 = s2.executeQuery();
        r2.next();
        return r2.getInt(1);
    }
    void placeCustomerOrder(Runnable afterSuccess) {
        try {
            int cartId = getOrCreateCustomerCart();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT CI.MEDICINE_ID,CI.QUANTITY,M.SELLING_PRICE FROM CART_ITEMS CI"
                            + " JOIN MEDICINE M ON CI.MEDICINE_ID=M.MEDICINE_ID WHERE CI.CART_ID=?");
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            java.util.List<int[]> items = new java.util.ArrayList<>();
            java.util.List<Double> prices = new java.util.ArrayList<>();
            double total = 0;
            while (rs.next()) {
                int mid = rs.getInt(1);
                int qty = rs.getInt(2);
                double price = rs.getDouble(3);
                items.add(new int[]{mid, qty});
                prices.add(price);
                total += price * qty;
            }
            if (items.isEmpty()) {
                showError("Your cart is empty!");
                return;
            }
            PreparedStatement oi = con.prepareStatement(
                    "INSERT INTO ORDERS(ORDER_ID,CUSTOMER_ID,ORDER_DATE,TOTAL_AMOUNT,ORDER_STATUS)"
                            + " VALUES(order_seq.NEXTVAL,?,SYSDATE,?,'Pending')");
            oi.setInt(1, loggedInCustomerId);
            oi.setDouble(2, total);
            oi.executeUpdate();
            PreparedStatement osel = con.prepareStatement(
                    "SELECT MAX(ORDER_ID) FROM ORDERS WHERE CUSTOMER_ID=?");
            osel.setInt(1, loggedInCustomerId);
            ResultSet or2 = osel.executeQuery();
            or2.next();
            int orderId = or2.getInt(1);
            for (int i = 0; i < items.size(); i++) {
                int mid = items.get(i)[0];
                int qty = items.get(i)[1];
                double pr = prices.get(i);
                PreparedStatement oii = con.prepareStatement(
                    "INSERT INTO ORDER_ITEMS(ORDER_ITEM_ID,ORDER_ID,MEDICINE_ID,QUANTITY,PRICE)"
                    + " VALUES(order_item_seq.NEXTVAL,?,?,?,?)");
                oii.setInt(1, orderId);
                oii.setInt(2, mid);
                oii.setInt(3, qty);
                oii.setDouble(4, pr);
                oii.executeUpdate();
                PreparedStatement stockUp = con.prepareStatement(
                    "UPDATE MEDICINE SET UNITSIZE = UNITSIZE - ? WHERE MEDICINE_ID=?");

                stockUp.setInt(1, qty);
                stockUp.setInt(2, mid);
                stockUp.executeUpdate();
            }
            PreparedStatement clr = con.prepareStatement("DELETE FROM CART_ITEMS WHERE CART_ID=?");
            clr.setInt(1, cartId);
            clr.executeUpdate();
            con.commit();

            showSuccess("Order #" + orderId + " placed successfully!\nTotal: INR " + String.format("%.2f", total));
            if (afterSuccess != null) afterSuccess.run();
        } catch (Exception ex) {
            showDBError(ex);
        }
    }
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new hack().setVisible(true));
    }
}
