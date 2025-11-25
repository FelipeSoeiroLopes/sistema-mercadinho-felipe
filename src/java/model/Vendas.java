/*
 * Mercadinho do Felipe
 * Modelo - Vendas
 * Java 24
 * 
 * Desenvolvedores:
 * - Felipe Soeiro Lopes
 * - Giovanna de Paula Lopes Santos
 * - Kauã da Silveira Nascimento Machado
 * - Victor Guimarães Felipe
 */
package model;

import java.sql.Timestamp;

/**
 * @author Mercadinho do Felipe - Equipe de Desenvolvimento
 * Modelo de dados para Vendas
 */
public class Vendas {
    //Atributos
    private int id;
    private int idCliente;
    private int idProduto;
    private String nomeCliente; // Nome do cliente para exibição
    private String nomeProduto; // Nome do produto para exibição
    private int quantidade;
    private float valorUnitario;
    private float valorTotal;
    private Timestamp dataVenda; // Timestamp para suportar data e hora
    
    //Métodos Getters e Setters
    public void setId(int p_id) {
        this.id = p_id;
    }
    public void setIdCliente(int p_idCliente) {
        this.idCliente = p_idCliente;
    }
    public void setIdProduto(int p_idProduto) {
        this.idProduto = p_idProduto;
    }
    public void setNomeCliente(String p_nomeCliente) {
        this.nomeCliente = p_nomeCliente;
    }
    public void setNomeProduto(String p_nomeProduto) {
        this.nomeProduto = p_nomeProduto;
    }
    public void setQuantidade(int p_quantidade) {
        this.quantidade = p_quantidade;
    }
    public void setValorUnitario(float p_valorUnitario) {
        this.valorUnitario = p_valorUnitario;
    }
    public void setValorTotal(float p_valorTotal) {
        this.valorTotal = p_valorTotal;
    }
    public void setDataVenda(Timestamp p_dataVenda) {
        this.dataVenda = p_dataVenda;
    }
    
    public int getId() {
        return this.id;
    }
    public int getIdCliente() {
        return this.idCliente;
    }
    public int getIdProduto() {
        return this.idProduto;
    }
    public String getNomeCliente() {
        return this.nomeCliente;
    }
    public String getNomeProduto() {
        return this.nomeProduto;
    }
    public int getQuantidade() {
        return this.quantidade;
    }
    public float getValorUnitario() {
        return this.valorUnitario;
    }
    public float getValorTotal() {
        return this.valorTotal;
    }
    public Timestamp getDataVenda() {
        return this.dataVenda;
    }          
}

