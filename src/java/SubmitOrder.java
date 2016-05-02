/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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

/**
 *
 * @author Kevin
 */
@WebServlet(urlPatterns = {"/SubmitOrder"})
public class SubmitOrder extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

            ResultSet result = statement.executeQuery("SELECT * from form");
            result.last();
            int new_id = Integer.parseInt(result.getString(1)) + 1;
            int userid = Integer.parseInt(request.getParameter("userid"));

            String query = "INSERT INTO form  values ("+new_id+"," + userid + ", NOW())";
            statement.addBatch(query);
            for (int i = 0; i < count; i++) {
                int temp_id = Integer.parseInt(request.getParameter("id"+i));
                int temp_count = Integer.parseInt(request.getParameter("jumlah"+i));
                String temp_keterangan = request.getParameter("keterangan"+i);
                String tempQuery = "INSERT INTO pesanan  values (0,"+temp_id+"," + new_id + ","+temp_count+",'"+temp_keterangan+"',0)";
                statement.addBatch(tempQuery);
            }
            statement.executeBatch();
            response.sendRedirect("statuspesanan.jsp");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
