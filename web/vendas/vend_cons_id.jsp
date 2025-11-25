<%-- 
    Document   : Consulta Venda por ID
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
<%@page import="model.Vendas"%>
<%@page import="model.DAO.VendaDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.TimeZone"%>

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
        <title>Consulta Venda por ID</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #fa709a; }
            .info { margin: 10px 0; padding: 15px; background: #e7f3ff; border-radius: 5px; }
            .error { color: red; padding: 15px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            a { display: inline-block; margin-top: 20px; color: #fa709a; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Consulta de Venda por ID</h1>
            <%
                try {
                    Vendas vend = new Vendas();
                    vend.setId(Integer.parseInt(request.getParameter("id")));
                    
                    VendaDAO vendDAO = new VendaDAO();
                    Vendas resultado = vendDAO.consultar_id(vend);
                    
                    if (resultado != null) {
                        out.println("<div class='info'>");
                        out.println("<strong>ID: </strong>" + resultado.getId() + "<br>");
                        out.println("<strong>ID Cliente: </strong>" + resultado.getIdCliente() + "<br>");
                        out.println("<strong>ID Produto: </strong>" + resultado.getIdProduto() + "<br>");
                        out.println("<strong>Quantidade: </strong>" + resultado.getQuantidade() + "<br>");
                        out.println("<strong>Valor Unitário: </strong>R$ " + formatarMoeda(resultado.getValorUnitario()) + "<br>");
                        out.println("<strong>Valor Total: </strong>R$ " + formatarMoeda(resultado.getValorTotal()) + "<br>");
                        if (resultado.getDataVenda() != null) {
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                            sdf.setTimeZone(TimeZone.getTimeZone("America/Sao_Paulo"));
                            out.println("<strong>Data e Hora (Brasil): </strong>" + sdf.format(resultado.getDataVenda()));
                        } else {
                            out.println("<strong>Data Venda: </strong>N/A");
                        }
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>Venda não encontrada!</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

