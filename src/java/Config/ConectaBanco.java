/*
 * Mercadinho do Felipe
 * Conexão com Banco de Dados com Suporte a Transações
 * Java 24
 * 
 * Desenvolvedores:
 * - Felipe Soeiro Lopes
 * - Giovanna de Paula Lopes Santos
 * - Kauã da Silveira Nascimento Machado
 * - Victor Guimarães Felipe
 */
package Config;
import java.sql.*;

/** 
 * @author Mercadinho do Felipe - Equipe de Desenvolvimento
 * Data: 2025
 * Classe para gerenciar conexão com banco de dados e transações
 */
public class ConectaBanco {
    // Configurações do banco de dados
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/mercadinho_felipe?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    /**
     * Abre uma conexão com o banco de dados
     * @return Connection objeto de conexão
     * @throws ClassNotFoundException 
     */
    public static Connection conectar() throws ClassNotFoundException {
        Connection conn = null; 
        try{
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            // Desabilita auto-commit para permitir transações
            conn.setAutoCommit(false);
            // Garante que o encoding seja UTF-8
            if (conn != null) {
                conn.createStatement().execute("SET NAMES 'utf8mb4'");
                conn.createStatement().execute("SET CHARACTER SET utf8mb4");
            }
        }catch(SQLException ex){
            System.out.println("Erro - SQL: " + ex);
        }
        return conn;
    }
    
    /**
     * Confirma uma transação
     * @param conn Conexão ativa
     * @return true se commit foi realizado com sucesso
     */
    public static boolean commit(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.commit();
                return true;
            }
        } catch (SQLException ex) {
            System.out.println("Erro ao fazer commit: " + ex);
        }
        return false;
    }
    
    /**
     * Desfaz uma transação (rollback)
     * @param conn Conexão ativa
     * @return true se rollback foi realizado com sucesso
     */
    public static boolean rollback(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.rollback();
                return true;
            }
        } catch (SQLException ex) {
            System.out.println("Erro ao fazer rollback: " + ex);
        }
        return false;
    }
    
    /**
     * Fecha a conexão com o banco de dados
     * @param conn Conexão a ser fechada
     */
    public static void fechar(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException ex) {
            System.out.println("Erro ao fechar conexão: " + ex);
        }
    }
}
