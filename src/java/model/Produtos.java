/*
 * Mercadinho do Felipe
 * Modelo - Produtos
 * Java 24
 * 
 * Desenvolvedores:
 * - Felipe Soeiro Lopes
 * - Giovanna de Paula Lopes Santos
 * - Kauã da Silveira Nascimento Machado
 * - Victor Guimarães Felipe
 */
package model;

/**
 * @author Mercadinho do Felipe - Equipe de Desenvolvimento
 * Modelo de dados para Produtos
 */
public class Produtos {
    //Atributos
    private int id;
    private String nome;
    private float valor;
    private int qtd;
    private String categoria;
    private int idFornecedor;
    
    //Métodos Getters e Setters
    public void setId(int p_id) {
        this.id = p_id;
    }
    public void setNome(String p_nome) {
        this.nome = p_nome;
    }
    public void setValor(float p_valor) {
        this.valor = p_valor;
    }
    public void setQtd(int p_qtd) {
        this.qtd = p_qtd;
    }
    public void setCategoria(String p_categoria) {
        this.categoria = p_categoria;
    }
    public void setIdFornecedor(int p_idFornecedor) {
        this.idFornecedor = p_idFornecedor;
    }
    
    public int getId() {
        return this.id;
    }
    public String getNome() {
        return this.nome;
    }
    public float getValor() {
        return this.valor;
    }
    public int getQtd() {
        return this.qtd;
    }
    public String getCategoria() {
        return this.categoria;
    }
    public int getIdFornecedor() {
        return this.idFornecedor;
    }          
}
