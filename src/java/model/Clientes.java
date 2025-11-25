/*
 * Mercadinho do Felipe
 * Modelo - Clientes
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
 * Modelo de dados para Clientes
 */
public class Clientes {
    //Atributos
    private int id;
    private String nome;
    private String cpf;
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
    public void setCpf(String p_cpf) {
        this.cpf = p_cpf;
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
    public String getCpf() {
        return this.cpf;
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

