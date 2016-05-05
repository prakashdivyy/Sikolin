
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(urlPatterns = {"/SubmitOrder"})
public class SubmitOrder extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            int count = Integer.parseInt(request.getParameter("itemCount"));
            Class.forName("com.mysql.jdbc.Driver");
            String userName = "root";
            String password = "root";
            String url = "jdbc:mysql://localhost/sikolin";
            Connection connection = DriverManager.getConnection(url, userName, password);
            Statement statement = connection.createStatement();
            String query = "INSERT INTO form  values (0, 1, NOW())";
            statement.addBatch(query);
            for (int i = 0; i < count; i++) {
                String tempQuery = "INSERT INTO pesanan  values (0,1,1,1,1,1)";
                statement.addBatch(tempQuery);
            }
            statement.executeBatch();
            response.sendRedirect("statuspesanan.jsp");
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SubmitOrder.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SubmitOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SubmitOrder.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SubmitOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
