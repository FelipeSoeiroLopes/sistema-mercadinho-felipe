/*
 * Mercadinho do Felipe
 * DAO - Vendas com Transações
 * Java 24
 * 
 * Desenvolvedores:
 * - Felipe Soeiro Lopes
 * - Giovanna de Paula Lopes Santos
 * - Kauã da Silveira Nascimento Machado
 * - Victor Guimarães Felipe
 */
package model.DAO;
import model.Vendas;
import Config.ConectaBanco;

import java.sql.*;
import java.util.*;
import java.sql.Timestamp;
import java.util.TimeZone;
import java.util.Calendar;

/**
 * @author Mercadinho do Felipe - Equipe de Desenvolvimento
 * DAO para operações CRUD de Vendas com transações
 */
public class VendaDAO {
    
    /**
     * Cadastra uma nova venda com transação
     * @param venda Venda a ser cadastrada
     * @return boolean true se cadastrada com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean cadastrar(Vendas venda) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            
            // Primeiro verifica se o produto tem estoque suficiente
            PreparedStatement stmtEstoque = conn.prepareStatement("SELECT qtd FROM produtos WHERE pk_id = ?");
            stmtEstoque.setInt(1, venda.getIdProduto());
            ResultSet rsEstoque = stmtEstoque.executeQuery();
            
            if (!rsEstoque.next()) {
                ConectaBanco.rollback(conn);
                stmtEstoque.close();
                ConectaBanco.fechar(conn);
                return false; // Produto não encontrado
            }
            
            int estoqueAtual = rsEstoque.getInt("qtd");
            if (estoqueAtual < venda.getQuantidade()) {
                ConectaBanco.rollback(conn);
                stmtEstoque.close();
                ConectaBanco.fechar(conn);
                return false; // Estoque insuficiente
            }
            
            stmtEstoque.close();
            rsEstoque.close();
            
            // Busca o valor unitário do produto
            PreparedStatement stmtProduto = conn.prepareStatement("SELECT valor FROM produtos WHERE pk_id = ?");
            stmtProduto.setInt(1, venda.getIdProduto());
            ResultSet rsProduto = stmtProduto.executeQuery();
            
            float valorUnitario = venda.getValorUnitario();
            if (valorUnitario == 0 && rsProduto.next()) {
                valorUnitario = rsProduto.getFloat("valor");
            }
            stmtProduto.close();
            rsProduto.close();
            
            // Insere a venda e retorna o ID gerado
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO vendas(id_cliente, id_produto, quantidade, valor_unitario, valor_total, data_venda) VALUES(?, ?, ?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS
            );
            stmt.setInt(1, venda.getIdCliente());
            stmt.setInt(2, venda.getIdProduto());
            stmt.setInt(3, venda.getQuantidade());
            stmt.setFloat(4, valorUnitario);
            stmt.setFloat(5, venda.getValorTotal());
            
            // Usa timezone do Brasil (America/Sao_Paulo)
            Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("America/Sao_Paulo"));
            Timestamp dataVenda;
            if (venda.getDataVenda() != null) {
                dataVenda = venda.getDataVenda();
            } else {
                dataVenda = new Timestamp(cal.getTimeInMillis());
            }
            stmt.setTimestamp(6, dataVenda, cal);
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                // Busca o ID gerado
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    venda.setId(generatedKeys.getInt(1));
                }
                generatedKeys.close();
                
                // Atualiza o estoque do produto
                PreparedStatement stmtUpdate = conn.prepareStatement(
                    "UPDATE produtos SET qtd = qtd - ? WHERE pk_id = ?"
                );
                stmtUpdate.setInt(1, venda.getQuantidade());
                stmtUpdate.setInt(2, venda.getIdProduto());
                stmtUpdate.executeUpdate();
                stmtUpdate.close();
                
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
     * Consulta todas as vendas
     * @return List de Vendas
     * @throws ClassNotFoundException 
     */
    public List<Vendas> consultar_geral() throws ClassNotFoundException{
        List<Vendas> lista = new ArrayList<>();
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            // JOIN com produtos para obter o nome
            String sql = "SELECT v.*, p.nome as nome_produto FROM vendas v " +
                        "INNER JOIN produtos p ON v.id_produto = p.pk_id " +
                        "ORDER BY v.pk_id ASC";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("America/Sao_Paulo"));
            
            while (rs.next()){
                Vendas venda = new Vendas();
                venda.setId(rs.getInt("pk_id"));
                venda.setIdCliente(rs.getInt("id_cliente"));
                venda.setIdProduto(rs.getInt("id_produto"));
                venda.setNomeProduto(rs.getString("nome_produto"));
                venda.setQuantidade(rs.getInt("quantidade"));
                venda.setValorUnitario(rs.getFloat("valor_unitario"));
                venda.setValorTotal(rs.getFloat("valor_total"));
                Timestamp ts = rs.getTimestamp("data_venda", cal);
                venda.setDataVenda(ts);
                lista.add(venda);
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
     * Consulta venda por ID
     * @param p_venda Venda com ID preenchido
     * @return Venda encontrada ou null
     * @throws ClassNotFoundException 
     */
    public Vendas consultar_id(Vendas p_venda) throws ClassNotFoundException{
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT v.*, p.nome as nome_produto FROM vendas v " +
                "INNER JOIN produtos p ON v.id_produto = p.pk_id " +
                "WHERE v.pk_id = ?"
            );
            stmt.setInt(1, p_venda.getId());
            ResultSet rs = stmt.executeQuery();
            
            Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("America/Sao_Paulo"));
            
            if(rs.next()){ 
                Vendas venda = new Vendas();
                venda.setId(rs.getInt("pk_id"));
                venda.setIdCliente(rs.getInt("id_cliente"));
                venda.setIdProduto(rs.getInt("id_produto"));
                venda.setNomeProduto(rs.getString("nome_produto"));
                venda.setQuantidade(rs.getInt("quantidade"));
                venda.setValorUnitario(rs.getFloat("valor_unitario"));
                venda.setValorTotal(rs.getFloat("valor_total"));
                Timestamp ts = rs.getTimestamp("data_venda", cal);
                venda.setDataVenda(ts);
                ConectaBanco.commit(conn);
                rs.close();
                stmt.close();
                ConectaBanco.fechar(conn);
                return venda;
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
     * Exclui uma venda com transação (restaura o estoque)
     * @param venda Venda a ser excluída
     * @return boolean true se excluída com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean excluir(Vendas venda) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            
            // Primeiro busca os dados da venda para restaurar o estoque
            PreparedStatement stmtSelect = conn.prepareStatement(
                "SELECT id_produto, quantidade, valor_unitario FROM vendas WHERE pk_id = ?"
            );
            stmtSelect.setInt(1, venda.getId());
            ResultSet rs = stmtSelect.executeQuery();
            
            if (!rs.next()) {
                ConectaBanco.rollback(conn);
                stmtSelect.close();
                ConectaBanco.fechar(conn);
                return false;
            }
            
            int idProduto = rs.getInt("id_produto");
            int quantidade = rs.getInt("quantidade");
            rs.close();
            stmtSelect.close();
            
            // Exclui a venda
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM vendas WHERE pk_id = ?");
            stmt.setInt(1, venda.getId());
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                // Restaura o estoque
                PreparedStatement stmtUpdate = conn.prepareStatement(
                    "UPDATE produtos SET qtd = qtd + ? WHERE pk_id = ?"
                );
                stmtUpdate.setInt(1, quantidade);
                stmtUpdate.setInt(2, idProduto);
                stmtUpdate.executeUpdate();
                stmtUpdate.close();
                
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
     * Altera uma venda com transação
     * @param venda Venda a ser alterada
     * @return boolean true se alterada com sucesso
     * @throws ClassNotFoundException 
     */
    public boolean alterar(Vendas venda) throws ClassNotFoundException{    
        Connection conn = null;
        try{
            conn = ConectaBanco.conectar();
            
            // Busca a venda original para ajustar o estoque
            PreparedStatement stmtSelect = conn.prepareStatement(
                "SELECT id_produto, quantidade FROM vendas WHERE pk_id = ?"
            );
            stmtSelect.setInt(1, venda.getId());
            ResultSet rs = stmtSelect.executeQuery();
            
            if (!rs.next()) {
                ConectaBanco.rollback(conn);
                stmtSelect.close();
                ConectaBanco.fechar(conn);
                return false;
            }
            
            int idProdutoAntigo = rs.getInt("id_produto");
            int quantidadeAntiga = rs.getInt("quantidade");
            rs.close();
            stmtSelect.close();
            
            // Verifica estoque se mudou produto ou quantidade
            if (venda.getIdProduto() != idProdutoAntigo || venda.getQuantidade() != quantidadeAntiga) {
                PreparedStatement stmtEstoque = conn.prepareStatement("SELECT qtd FROM produtos WHERE pk_id = ?");
                stmtEstoque.setInt(1, venda.getIdProduto());
                ResultSet rsEstoque = stmtEstoque.executeQuery();
                
                if (!rsEstoque.next()) {
                    ConectaBanco.rollback(conn);
                    stmtEstoque.close();
                    ConectaBanco.fechar(conn);
                    return false;
                }
                
                int estoqueAtual = rsEstoque.getInt("qtd");
                
                if (venda.getIdProduto() != idProdutoAntigo) {
                    // Restaura estoque do produto antigo
                    PreparedStatement stmtRestaura = conn.prepareStatement(
                        "UPDATE produtos SET qtd = qtd + ? WHERE pk_id = ?"
                    );
                    stmtRestaura.setInt(1, quantidadeAntiga);
                    stmtRestaura.setInt(2, idProdutoAntigo);
                    stmtRestaura.executeUpdate();
                    stmtRestaura.close();
                    
                    // Verifica novo produto
                    if (estoqueAtual < venda.getQuantidade()) {
                        ConectaBanco.rollback(conn);
                        stmtEstoque.close();
                        ConectaBanco.fechar(conn);
                        return false;
                    }
                    estoqueAtual -= venda.getQuantidade();
                } else {
                    // Mesmo produto, ajusta quantidade
                    if (estoqueAtual + quantidadeAntiga < venda.getQuantidade()) {
                        ConectaBanco.rollback(conn);
                        stmtEstoque.close();
                        ConectaBanco.fechar(conn);
                        return false;
                    }
                }
                stmtEstoque.close();
                rsEstoque.close();
            }
            
            // Busca o valor unitário do produto se não foi informado
            float valorUnitario = venda.getValorUnitario();
            if (valorUnitario == 0) {
                PreparedStatement stmtProduto = conn.prepareStatement("SELECT valor FROM produtos WHERE pk_id = ?");
                stmtProduto.setInt(1, venda.getIdProduto());
                ResultSet rsProduto = stmtProduto.executeQuery();
                if (rsProduto.next()) {
                    valorUnitario = rsProduto.getFloat("valor");
                }
                stmtProduto.close();
                rsProduto.close();
            }
            
            // Atualiza a venda
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE vendas SET id_cliente=?, id_produto=?, quantidade=?, valor_unitario=?, valor_total=?, data_venda=? WHERE pk_id = ?"
            );
            stmt.setInt(1, venda.getIdCliente());
            stmt.setInt(2, venda.getIdProduto());
            stmt.setInt(3, venda.getQuantidade());
            stmt.setFloat(4, valorUnitario);
            stmt.setFloat(5, venda.getValorTotal());
            
            Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("America/Sao_Paulo"));
            Timestamp dataVenda;
            if (venda.getDataVenda() != null) {
                dataVenda = venda.getDataVenda();
            } else {
                dataVenda = new Timestamp(cal.getTimeInMillis());
            }
            stmt.setTimestamp(6, dataVenda, cal);
            stmt.setInt(7, venda.getId());
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                // Ajusta o estoque
                if (venda.getIdProduto() != idProdutoAntigo || venda.getQuantidade() != quantidadeAntiga) {
                    if (venda.getIdProduto() == idProdutoAntigo) {
                        // Mesmo produto
                        PreparedStatement stmtUpdate = conn.prepareStatement(
                            "UPDATE produtos SET qtd = qtd + ? - ? WHERE pk_id = ?"
                        );
                        stmtUpdate.setInt(1, quantidadeAntiga);
                        stmtUpdate.setInt(2, venda.getQuantidade());
                        stmtUpdate.setInt(3, venda.getIdProduto());
                        stmtUpdate.executeUpdate();
                        stmtUpdate.close();
                    } else {
                        // Produto diferente - já ajustado acima
                        PreparedStatement stmtUpdate = conn.prepareStatement(
                            "UPDATE produtos SET qtd = ? WHERE pk_id = ?"
                        );
                        PreparedStatement stmtEstoqueFinal = conn.prepareStatement(
                            "SELECT qtd FROM produtos WHERE pk_id = ?"
                        );
                        stmtEstoqueFinal.setInt(1, venda.getIdProduto());
                        ResultSet rsFinal = stmtEstoqueFinal.executeQuery();
                        if (rsFinal.next()) {
                            int estoqueFinal = rsFinal.getInt("qtd");
                            stmtUpdate.setInt(1, estoqueFinal);
                            stmtUpdate.setInt(2, venda.getIdProduto());
                            stmtUpdate.executeUpdate();
                        }
                        rsFinal.close();
                        stmtEstoqueFinal.close();
                        stmtUpdate.close();
                    }
                }
                
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

