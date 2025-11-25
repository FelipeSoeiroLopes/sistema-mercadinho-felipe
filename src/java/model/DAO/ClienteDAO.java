/*
 * Mercadinho do Felipe
 * DAO - Clientes com Transações
 * Java 24
 * 
 * Desenvolvedores:
 * - Felipe Soeiro Lopes
 * - Giovanna de Paula Lopes Santos
 * - Kauã da Silveira Nascimento Machado
 * - Victor Guimarães Felipe
 */
package model.DAO;
import model.Clientes;
import Config.ConectaBanco;

import java.sql.*;
import java.util.*;

/**
 * @author Mercadinho do Felipe - Equipe de Desenvolvimento
 * DAO para operações CRUD de Clientes com transações
 */
public class ClienteDAO {
    
    /**
     * Cadastra um novo cliente com transação
     * @param cliente Cliente a ser cadastrado
     * @return boolean true se cadastrado com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean cadastrar(Clientes cliente) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO clientes(nome, cpf, telefone, email, endereco) VALUES(?, ?, ?, ?, ?)"
            );
            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getCpf());
            stmt.setString(3, cliente.getTelefone());
            stmt.setString(4, cliente.getEmail());
            stmt.setString(5, cliente.getEndereco());
            
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
     * Consulta todos os clientes
     * @return List de Clientes
     * @throws ClassNotFoundException 
     */
    public List<Clientes> consultar_geral() throws ClassNotFoundException{
        List<Clientes> lista = new ArrayList<>();
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM clientes ORDER BY pk_id ASC";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()){
                Clientes cliente = new Clientes();
                cliente.setId(rs.getInt("pk_id"));
                cliente.setNome(rs.getString("nome"));
                cliente.setCpf(rs.getString("cpf"));
                cliente.setTelefone(rs.getString("telefone"));
                cliente.setEmail(rs.getString("email"));
                cliente.setEndereco(rs.getString("endereco"));
                lista.add(cliente);
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
    
    /**
     * Consulta cliente por ID
     * @param p_cliente Cliente com ID preenchido
     * @return Cliente encontrado ou null
     * @throws ClassNotFoundException 
     */
    public Clientes consultar_id(Clientes p_cliente) throws ClassNotFoundException{
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM clientes WHERE pk_id = ?");
            stmt.setInt(1, p_cliente.getId());
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){ 
                Clientes cliente = new Clientes();
                cliente.setId(rs.getInt("pk_id"));
                cliente.setNome(rs.getString("nome"));
                cliente.setCpf(rs.getString("cpf"));
                cliente.setTelefone(rs.getString("telefone"));
                cliente.setEmail(rs.getString("email"));
                cliente.setEndereco(rs.getString("endereco"));
                ConectaBanco.commit(conn);
                rs.close();
                stmt.close();
                ConectaBanco.fechar(conn);
                return cliente;
            } else {
                ConectaBanco.commit(conn);
                rs.close();
                stmt.close();
                ConectaBanco.fechar(conn);
                return null;                               
            }
        }catch(SQLException ex){
            System.out.println("Erro SQL ao consultar por ID: " + ex);
            ConectaBanco.rollback(conn);
            ConectaBanco.fechar(conn);
            return null;
        }        
    }
    
    /**
     * Exclui um cliente com transação
     * @param cliente Cliente a ser excluído
     * @return boolean true se excluído com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean excluir(Clientes cliente) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM clientes WHERE pk_id = ?");
            stmt.setInt(1, cliente.getId());
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
            System.out.println("Erro SQL ao excluir: " + ex);
            ConectaBanco.rollback(conn);
            ConectaBanco.fechar(conn);
            return false;
        } 
    }

    /**
     * Altera um cliente com transação
     * @param cliente Cliente a ser alterado
     * @return boolean true se alterado com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean alterar(Clientes cliente) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE clientes SET nome=?, cpf=?, telefone=?, email=?, endereco=? WHERE pk_id = ?"
            );
            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getCpf());
            stmt.setString(3, cliente.getTelefone());
            stmt.setString(4, cliente.getEmail());
            stmt.setString(5, cliente.getEndereco());
            stmt.setInt(6, cliente.getId());
            
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
            System.out.println("Erro SQL ao alterar: " + ex);
            ConectaBanco.rollback(conn);
            ConectaBanco.fechar(conn);
            return false;
        }
    }
}

