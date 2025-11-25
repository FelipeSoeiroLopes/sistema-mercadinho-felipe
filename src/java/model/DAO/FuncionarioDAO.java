/*
 * Mercadinho do Felipe
 * DAO - Funcionários com Transações
 * Java 24
 * 
 * Desenvolvedores:
 * - Felipe Soeiro Lopes
 * - Giovanna de Paula Lopes Santos
 * - Kauã da Silveira Nascimento Machado
 * - Victor Guimarães Felipe
 */
package model.DAO;
import model.Funcionario;
import Config.ConectaBanco;

import java.sql.*;
import java.util.*;

/**
 * @author Mercadinho do Felipe - Equipe de Desenvolvimento
 * DAO para operações CRUD de Funcionários com transações
 */
public class FuncionarioDAO {
    
    /**
     * Autentica um funcionário pelo login e senha
     * @param login Login do funcionário
     * @param senha Senha do funcionário
     * @return Funcionario autenticado ou null
     * @throws ClassNotFoundException 
     */
    public Funcionario autenticar(String login, String senha) throws ClassNotFoundException {
        Connection conn = null;
        try {
            // Remove espaços em branco dos parâmetros
            if (login != null) login = login.trim();
            if (senha != null) senha = senha.trim();
            
            conn = ConectaBanco.conectar();
            if (conn == null) {
                System.out.println("Erro: Não foi possível conectar ao banco de dados");
                return null;
            }
            
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM funcionarios WHERE login = ? AND senha = ?"
            );
            stmt.setString(1, login);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Funcionario func = new Funcionario();
                func.setId(rs.getInt("pk_id"));
                func.setNome(rs.getString("nome"));
                func.setCpf(rs.getString("cpf"));
                func.setTelefone(rs.getString("telefone"));
                func.setEmail(rs.getString("email"));
                func.setLogin(rs.getString("login"));
                func.setSenha(rs.getString("senha"));
                func.setTipoAcesso(rs.getString("tipo_acesso"));
                rs.close();
                stmt.close();
                ConectaBanco.commit(conn);
                ConectaBanco.fechar(conn);
                System.out.println("Autenticação bem-sucedida para: " + login);
                return func;
            } else {
                rs.close();
                stmt.close();
                ConectaBanco.commit(conn);
                ConectaBanco.fechar(conn);
                System.out.println("Autenticação falhou - login ou senha incorretos: " + login);
                return null;
            }
        } catch (SQLException ex) {
            System.out.println("Erro SQL ao autenticar: " + ex.getMessage());
            ex.printStackTrace();
            if (conn != null) {
                ConectaBanco.rollback(conn);
                ConectaBanco.fechar(conn);
            }
            return null;
        }
    }
    
    /**
     * Cadastra um novo funcionário (apenas ADMIN pode fazer isso)
     * @param func Funcionário a ser cadastrado
     * @return boolean true se cadastrado com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean cadastrar(Funcionario func) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO funcionarios(nome, cpf, telefone, email, login, senha, tipo_acesso) VALUES(?, ?, ?, ?, ?, ?, ?)"
            );
            stmt.setString(1, func.getNome());
            stmt.setString(2, func.getCpf());
            stmt.setString(3, func.getTelefone());
            stmt.setString(4, func.getEmail());
            stmt.setString(5, func.getLogin());
            stmt.setString(6, func.getSenha());
            stmt.setString(7, func.getTipoAcesso());
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                ConectaBanco.commit(conn);
                stmt.close();
                ConectaBanco.fechar(conn);
                return true;
            } else {
                ConectaBanco.rollback(conn);
                stmt.close();
                ConectaBanco.fechar(conn);
                return false;
            }
        }catch(SQLException ex){
            System.out.println("Erro SQL ao cadastrar: " + ex);
            ConectaBanco.rollback(conn);
            ConectaBanco.fechar(conn);
            return false;
        }
    }
    
    /**
     * Consulta todos os funcionários
     * @return List de Funcionários
     * @throws ClassNotFoundException 
     */
    public List<Funcionario> consultar_geral() throws ClassNotFoundException{
        List<Funcionario> lista = new ArrayList<>();
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM funcionarios ORDER BY pk_id ASC";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()){
                Funcionario func = new Funcionario();
                func.setId(rs.getInt("pk_id"));
                func.setNome(rs.getString("nome"));
                func.setCpf(rs.getString("cpf"));
                func.setTelefone(rs.getString("telefone"));
                func.setEmail(rs.getString("email"));
                func.setLogin(rs.getString("login"));
                func.setTipoAcesso(rs.getString("tipo_acesso"));
                lista.add(func);
            }
            ConectaBanco.commit(conn);
            rs.close();
            stmt.close();
            ConectaBanco.fechar(conn);
            return lista;
        }catch(SQLException ex){
            System.out.println("Erro SQL ao consultar geral: " + ex);
            ConectaBanco.rollback(conn);
            ConectaBanco.fechar(conn);
            return null;
        }        
    }
}

