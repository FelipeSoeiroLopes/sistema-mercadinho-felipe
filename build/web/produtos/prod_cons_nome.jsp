<%-- 
    Document   : Consulta Produto por Nome
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
<%@page import="java.util.*"%>
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
        <title>Consulta Produto por Nome</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 1000px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #f5576c; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; }
            th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
            th { background-color: #f5576c; color: white; }
            tr:hover { background-color: #f5f5f5; }
            .empty { color: #666; padding: 20px; text-align: center; }
            a { display: inline-block; margin-top: 20px; color: #f5576c; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Consulta de Produtos por Nome</h1>
            <%
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
                
                try {
                    String nome = request.getParameter("nome");
                    ProdutoDAO prodDAO = new ProdutoDAO();
                    List<Produtos> lista = prodDAO.consultar_nome(nome);
                    
                    if (lista == null || lista.isEmpty()){
                        out.println("<div class='empty'>Nenhum produto encontrado com esse nome!</div>");
                    } else {
                        out.println("<table>");
                        out.println("<tr><th>ID</th><th>Nome</th><th>Valor</th><th>Quantidade</th><th>Categoria</th></tr>");
                        for(int i = 0; i < lista.size(); i++){ 
                            Produtos p = lista.get(i);
                            String nomeProduto = (p.getNome() != null ? p.getNome() : "");
                            String categoria = (p.getCategoria() != null ? p.getCategoria() : "");
                            out.println("<tr>");
                            out.println("<td>" + p.getId() + "</td>");
                            out.println("<td>" + nomeProduto + "</td>");
                            out.println("<td>R$ " + formatarMoeda(p.getValor()) + "</td>");
                            out.println("<td>" + p.getQtd() + "</td>");
                            out.println("<td>" + categoria + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='empty'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

