<%-- 
    Document   : Consulta Produto por ID
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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>Consulta Produto por ID</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #f5576c; }
            .info { margin: 10px 0; padding: 15px; background: #e7f3ff; border-radius: 5px; }
            .error { color: red; padding: 15px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            a { display: inline-block; margin-top: 20px; color: #f5576c; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Consulta de Produto por ID</h1>
            <%
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
                
                try {
                    Produtos prod = new Produtos();
                    prod.setId(Integer.parseInt(request.getParameter("id")));
                    
                    ProdutoDAO prodDAO = new ProdutoDAO();
                    Produtos resultado = prodDAO.consultar_id(prod);
                    
                    if (resultado != null) {
                        String nome = (resultado.getNome() != null ? resultado.getNome() : "");
                        String categoria = (resultado.getCategoria() != null ? resultado.getCategoria() : "");
                        out.println("<div class='info'>");
                        out.println("<strong>ID: </strong>" + resultado.getId() + "<br>");
                        out.println("<strong>Nome: </strong>" + nome + "<br>");
                        out.println("<strong>Valor: </strong>R$ " + formatarMoeda(resultado.getValor()) + "<br>");
                        out.println("<strong>Quantidade: </strong>" + resultado.getQtd() + "<br>");
                        out.println("<strong>Categoria: </strong>" + categoria);
                        out.println("</div>");
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

