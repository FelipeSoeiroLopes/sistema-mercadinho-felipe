/*
 * Mercadinho do Felipe
 * DAO - Produtos com Transações
 * Java 24
 * 
 * Desenvolvedores:
 * - Felipe Soeiro Lopes
 * - Giovanna de Paula Lopes Santos
 * - Kauã da Silveira Nascimento Machado
 * - Victor Guimarães Felipe
 */
package model.DAO;
import model.Produtos;
import Config.ConectaBanco;

import java.sql.*;
import java.util.*;

/**
 * @author Mercadinho do Felipe - Equipe de Desenvolvimento
 * DAO para operações CRUD de Produtos com transações
 */
public class ProdutoDAO {
    
    /**
     * Cadastra um novo produto com transação
     * @param prod Produto a ser cadastrado
     * @return boolean true se cadastrado com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean cadastrar(Produtos prod) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO produtos(nome, valor, qtd, categoria, id_fornecedor) VALUES(?, ?, ?, ?, ?)"
            );
            stmt.setString(1, prod.getNome());
            stmt.setFloat(2, prod.getValor());
            stmt.setInt(3, prod.getQtd());
            stmt.setString(4, prod.getCategoria());
            if (prod.getIdFornecedor() > 0) {
                stmt.setInt(5, prod.getIdFornecedor());
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            
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
     * Consulta todos os produtos
     * @return List de Produtos
     * @throws ClassNotFoundException 
     */
    public List<Produtos> consultar_geral() throws ClassNotFoundException{
        List<Produtos> lista = new ArrayList<>();
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM produtos ORDER BY pk_id ASC";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()){
                Produtos prod = new Produtos();
                prod.setId(rs.getInt("pk_id"));
                prod.setNome(rs.getString("nome"));
                prod.setValor(rs.getFloat("valor"));
                prod.setQtd(rs.getInt("qtd"));
                prod.setCategoria(rs.getString("categoria"));
                int idFornecedor = rs.getInt("id_fornecedor");
                prod.setIdFornecedor(rs.wasNull() ? 0 : idFornecedor);
                lista.add(prod);
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
     * Consulta produto por ID
     * @param p_prod Produto com ID preenchido
     * @return Produto encontrado ou null
     * @throws ClassNotFoundException 
     */
    public Produtos consultar_id(Produtos p_prod) throws ClassNotFoundException{
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM produtos WHERE pk_id = ?");
            stmt.setInt(1, p_prod.getId());
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){ 
                Produtos prod = new Produtos();
                prod.setId(rs.getInt("pk_id"));
                prod.setNome(rs.getString("nome"));
                prod.setValor(rs.getFloat("valor"));
                prod.setQtd(rs.getInt("qtd"));
                prod.setCategoria(rs.getString("categoria"));
                int idFornecedor = rs.getInt("id_fornecedor");
                prod.setIdFornecedor(rs.wasNull() ? 0 : idFornecedor);
                ConectaBanco.commit(conn);
                rs.close();
                stmt.close();
                ConectaBanco.fechar(conn);
                return prod;
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
     * Consulta produtos por nome (busca parcial)
     * @param p_nome Nome ou parte do nome
     * @return List de Produtos encontrados
     * @throws ClassNotFoundException 
     */
    public List<Produtos> consultar_nome(String p_nome) throws ClassNotFoundException{
        List<Produtos> lista = new ArrayList<>();
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM produtos WHERE nome LIKE ? ORDER BY pk_id ASC");
            stmt.setString(1, "%" + p_nome + "%");
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()){
                Produtos prod = new Produtos();
                prod.setId(rs.getInt("pk_id"));
                prod.setNome(rs.getString("nome"));
                prod.setValor(rs.getFloat("valor"));
                prod.setQtd(rs.getInt("qtd"));
                prod.setCategoria(rs.getString("categoria"));
                int idFornecedor = rs.getInt("id_fornecedor");
                prod.setIdFornecedor(rs.wasNull() ? 0 : idFornecedor);
                lista.add(prod);
            }
            ConectaBanco.commit(conn);
            rs.close();
            stmt.close();
            ConectaBanco.fechar(conn);
            return lista.isEmpty() ? null : lista;
        }catch(SQLException ex){
            System.out.println("Erro SQL ao consultar por nome: " + ex);
            ConectaBanco.rollback(conn);
            ConectaBanco.fechar(conn);
            return null;
        }        
    }
    
    /**
     * Exclui um produto com transação
     * @param prod Produto a ser excluído
     * @return boolean true se excluído com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean excluir(Produtos prod) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM produtos WHERE pk_id = ?");
            stmt.setInt(1, prod.getId());
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
     * Altera um produto com transação
     * @param prod Produto a ser alterado
     * @return boolean true se alterado com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean alterar(Produtos prod) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE produtos SET nome=?, valor=?, qtd=?, categoria=?, id_fornecedor=? WHERE pk_id = ?"
            );
            stmt.setString(1, prod.getNome());
            stmt.setFloat(2, prod.getValor());
            stmt.setInt(3, prod.getQtd());
            stmt.setString(4, prod.getCategoria());
            if (prod.getIdFornecedor() > 0) {
                stmt.setInt(5, prod.getIdFornecedor());
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            stmt.setInt(6, prod.getId());
            
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
