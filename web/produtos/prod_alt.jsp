<%-- 
    Document   : Alteração de Produtos
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
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.util.Locale"%>

<%!
    // Função para formatar valores monetários brasileiros
    public String formatarMoeda(double valor) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(new Locale("pt", "BR"));
        DecimalFormat df = new DecimalFormat("#,##0.00", symbols);
        return df.format(valor);
    }
%>

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
        <title>Alteração de Produtos</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #f5576c; }
            .success { color: green; padding: 10px; background: #d4edda; border-radius: 5px; margin: 10px 0; }
            .error { color: red; padding: 10px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            .info { margin: 10px 0; padding: 10px; background: #e7f3ff; border-radius: 5px; }
            a { display: inline-block; margin-top: 20px; color: #f5576c; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Alteração de Produtos</h1>
            <%
                // Configurar encoding UTF-8 ANTES de processar parâmetros
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");
                
                try {
                    Produtos prod = new Produtos();
                    prod.setId(Integer.parseInt(request.getParameter("id")));
                    prod.setNome(request.getParameter("nome"));
                    prod.setValor(Float.parseFloat(request.getParameter("valor")));
                    prod.setQtd(Integer.parseInt(request.getParameter("qtd")));
                    prod.setCategoria(request.getParameter("categoria"));
                    
                    String idFornecedorStr = request.getParameter("idFornecedor");
                    if (idFornecedorStr != null && !idFornecedorStr.isEmpty() && !idFornecedorStr.equals("0")) {
                        prod.setIdFornecedor(Integer.parseInt(idFornecedorStr));
                    } else {
                        prod.setIdFornecedor(0);
                    }
                    
                    ProdutoDAO prodDAO = new ProdutoDAO();
                    if (prodDAO.alterar(prod)){
                        out.println("<div class='success'>Produto alterado com sucesso!</div>");
                        out.println("<div class='info'>");
                        out.println("<strong>ID: </strong>" + prod.getId() + "<br>");
                        out.println("<strong>Nome: </strong>" + (prod.getNome() != null ? prod.getNome() : "") + "<br>");
                        out.println("<strong>Valor: </strong>R$ " + formatarMoeda(prod.getValor()) + "<br>");
                        out.println("<strong>Quantidade: </strong>" + prod.getQtd() + "<br>");
                        out.println("<strong>Categoria: </strong>" + (prod.getCategoria() != null ? prod.getCategoria() : "") + "<br>");
                        out.println("<strong>ID Fornecedor: </strong>" + (prod.getIdFornecedor() > 0 ? prod.getIdFornecedor() : "Nenhum"));
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>Produto não alterado! Erro na transação.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

