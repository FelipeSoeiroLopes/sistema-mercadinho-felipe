/*
 * Mercadinho do Felipe
 * DAO - Fornecedores com Transações
 * Java 24
 * 
 * Desenvolvedores:
 * - Felipe Soeiro Lopes
 * - Giovanna de Paula Lopes Santos
 * - Kauã da Silveira Nascimento Machado
 * - Victor Guimarães Felipe
 */
package model.DAO;
import model.Fornecedores;
import Config.ConectaBanco;

import java.sql.*;
import java.util.*;

/**
 * @author Mercadinho do Felipe - Equipe de Desenvolvimento
 * DAO para operações CRUD de Fornecedores com transações
 */
public class FornecedorDAO {
    
    /**
     * Cadastra um novo fornecedor com transação
     * @param fornecedor Fornecedor a ser cadastrado
     * @return boolean true se cadastrado com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean cadastrar(Fornecedores fornecedor) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO fornecedores(nome, cnpj, telefone, email, endereco) VALUES(?, ?, ?, ?, ?)"
            );
            stmt.setString(1, fornecedor.getNome());
            stmt.setString(2, fornecedor.getCnpj());
            stmt.setString(3, fornecedor.getTelefone());
            stmt.setString(4, fornecedor.getEmail());
            stmt.setString(5, fornecedor.getEndereco());
            
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
     * Consulta todos os fornecedores
     * @return List de Fornecedores
     * @throws ClassNotFoundException 
     */
    public List<Fornecedores> consultar_geral() throws ClassNotFoundException{
        List<Fornecedores> lista = new ArrayList<>();
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM fornecedores ORDER BY pk_id ASC";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()){
                Fornecedores fornecedor = new Fornecedores();
                fornecedor.setId(rs.getInt("pk_id"));
                fornecedor.setNome(rs.getString("nome"));
                fornecedor.setCnpj(rs.getString("cnpj"));
                fornecedor.setTelefone(rs.getString("telefone"));
                fornecedor.setEmail(rs.getString("email"));
                fornecedor.setEndereco(rs.getString("endereco"));
                lista.add(fornecedor);
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
     * Consulta fornecedor por ID
     * @param p_fornecedor Fornecedor com ID preenchido
     * @return Fornecedor encontrado ou null
     * @throws ClassNotFoundException 
     */
    public Fornecedores consultar_id(Fornecedores p_fornecedor) throws ClassNotFoundException{
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM fornecedores WHERE pk_id = ?");
            stmt.setInt(1, p_fornecedor.getId());
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){ 
                Fornecedores fornecedor = new Fornecedores();
                fornecedor.setId(rs.getInt("pk_id"));
                fornecedor.setNome(rs.getString("nome"));
                fornecedor.setCnpj(rs.getString("cnpj"));
                fornecedor.setTelefone(rs.getString("telefone"));
                fornecedor.setEmail(rs.getString("email"));
                fornecedor.setEndereco(rs.getString("endereco"));
                ConectaBanco.commit(conn);
                rs.close();
                stmt.close();
                ConectaBanco.fechar(conn);
                return fornecedor;
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
     * Exclui um fornecedor com transação
     * @param fornecedor Fornecedor a ser excluído
     * @return boolean true se excluído com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean excluir(Fornecedores fornecedor) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM fornecedores WHERE pk_id = ?");
            stmt.setInt(1, fornecedor.getId());
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
     * Altera um fornecedor com transação
     * @param fornecedor Fornecedor a ser alterado
     * @return boolean true se alterado com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean alterar(Fornecedores fornecedor) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE fornecedores SET nome=?, cnpj=?, telefone=?, email=?, endereco=? WHERE pk_id = ?"
            );
            stmt.setString(1, fornecedor.getNome());
            stmt.setString(2, fornecedor.getCnpj());
            stmt.setString(3, fornecedor.getTelefone());
            stmt.setString(4, fornecedor.getEmail());
            stmt.setString(5, fornecedor.getEndereco());
            stmt.setInt(6, fornecedor.getId());
            
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

