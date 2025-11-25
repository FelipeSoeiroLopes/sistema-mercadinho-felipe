<%-- 
    Document   : Consulta Produto por ID para Alterar
    Mercadinho do Felipe
    Java 24
    Desenvolvedores:
    - Felipe Soeiro Lopes
    - Giovanna de Paula Lopes Santos
    - Kauã da Silveira Nascimento Machado
    - Victor Guimarães Felipe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../verificar_sessao.jsp"%>
<%@page import="model.Produtos"%>
<%@page import="model.DAO.ProdutoDAO"%>
<%@page import="java.util.*"%>
<%@page import="model.Fornecedores"%>
<%@page import="model.DAO.FornecedorDAO"%>

<%
    // Verificar se é admin
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=acesso_negado");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>Alterar Produto</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #f5576c; }
            label { display: block; margin-bottom: 6px; font-weight: 500; color: #333; }
            input, select { width: 100%; padding: 10px; margin-bottom: 20px; border: 1px solid #dcdfe3; border-radius: 4px; font-size: 16px; box-sizing: border-box; }
            button { padding: 10px 20px; font-size: 16px; border: none; border-radius: 4px; cursor: pointer; background-color: #f5576c; color: white; width: 100%; }
            .error { color: red; padding: 15px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            a { display: inline-block; margin-top: 20px; color: #f5576c; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Alterar Produto</h1>
            <%
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
                
                try {
                    Produtos prod = new Produtos();
                    prod.setId(Integer.parseInt(request.getParameter("id")));
                    
                    ProdutoDAO prodDAO = new ProdutoDAO();
                    Produtos resultado = prodDAO.consultar_id(prod);
                    
                    // Carregar lista de fornecedores
                    List<Fornecedores> listaFornecedores = new ArrayList<>();
                    try {
                        FornecedorDAO fornDAO = new FornecedorDAO();
                        listaFornecedores = fornDAO.consultar_geral();
                        if (listaFornecedores == null) {
                            listaFornecedores = new ArrayList<>();
                        }
                    } catch (Exception ex) {
                        listaFornecedores = new ArrayList<>();
                    }
                    
                    if (resultado != null) {
                        out.println("<form method='post' action='prod_alt.jsp' accept-charset='UTF-8'>");
                        out.println("<input type='hidden' name='id' value='" + resultado.getId() + "'>");
                        out.println("<label for='nome'>Nome do Produto:</label>");
                        out.println("<input type='text' id='nome' name='nome' value='" + (resultado.getNome() != null ? resultado.getNome().replace("'", "&#39;") : "") + "' required>");
                        out.println("<label for='valor'>Valor (R$):</label>");
                        out.println("<input type='number' id='valor' name='valor' step='0.01' min='0' value='" + resultado.getValor() + "' required>");
                        out.println("<label for='qtd'>Quantidade:</label>");
                        out.println("<input type='number' id='qtd' name='qtd' step='1' min='0' value='" + resultado.getQtd() + "' required>");
                        out.println("<label for='categoria'>Categoria:</label>");
                        out.println("<input type='text' id='categoria' name='categoria' value='" + (resultado.getCategoria() != null ? resultado.getCategoria().replace("'", "&#39;") : "") + "' required>");
                        out.println("<label for='idFornecedor'>Fornecedor:</label>");
                        out.println("<select id='idFornecedor' name='idFornecedor'>");
                        out.println("<option value='0'" + (resultado.getIdFornecedor() == 0 ? " selected" : "") + ">Sem fornecedor</option>");
                        for (Fornecedores forn : listaFornecedores) {
                            String selected = (resultado.getIdFornecedor() == forn.getId()) ? " selected" : "";
                            out.println("<option value='" + forn.getId() + "'" + selected + ">" + 
                                       (forn.getNome() != null ? forn.getNome() : "") + "</option>");
                        }
                        out.println("</select>");
                        out.println("<button type='submit'>Alterar</button>");
                        out.println("</form>");
                    } else {
                        out.println("<div class='error'>Produto não encontrado!</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

