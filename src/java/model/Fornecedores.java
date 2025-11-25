/*
 * Mercadinho do Felipe
 * Modelo - Fornecedores
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
 * Modelo de dados para Fornecedores
 */
public class Fornecedores {
    //Atributos
    private int id;
    private String nome;
    private String cnpj;
    private String telefone;
    private String email;
    private String endereco;
    
    //Métodos Getters e Setters
    public void setId(int p_id) {
        this.id = p_id;
    }
    public void setNome(String p_nome) {
        this.nome = p_nome;
    }
    public void setCnpj(String p_cnpj) {
        this.cnpj = p_cnpj;
    }
    public void setTelefone(String p_telefone) {
        this.telefone = p_telefone;
    }
    public void setEmail(String p_email) {
        this.email = p_email;
    }
    public void setEndereco(String p_endereco) {
        this.endereco = p_endereco;
    }
    
    public int getId() {
        return this.id;
    }
    public String getNome() {
        return this.nome;
    }
    public String getCnpj() {
        return this.cnpj;
    }
    public String getTelefone() {
        return this.telefone;
    }
    public String getEmail() {
        return this.email;
    }
    public String getEndereco() {
        return this.endereco;
    }          
}

