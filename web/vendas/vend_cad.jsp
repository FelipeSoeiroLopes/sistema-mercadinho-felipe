<%-- 
    Document   : Cadastro de Vendas
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
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
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
    // Permitir cadastro de venda para todos os funcionários logados
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>Cadastro de Vendas</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #fa709a; }
            .success { color: green; padding: 10px; background: #d4edda; border-radius: 5px; margin: 10px 0; }
            .error { color: red; padding: 10px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            .info { margin: 10px 0; padding: 10px; background: #e7f3ff; border-radius: 5px; }
            a { display: inline-block; margin-top: 20px; color: #fa709a; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Cadastro de Vendas</h1>
            <%
                try {
                    Vendas vend = new Vendas();
                    vend.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
                    vend.setIdProduto(Integer.parseInt(request.getParameter("idProduto")));
                    vend.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
                    
                    // Valor unitário e total
                    String valorUnitarioStr = request.getParameter("valorUnitario");
                    if (valorUnitarioStr != null && !valorUnitarioStr.isEmpty()) {
                        vend.setValorUnitario(Float.parseFloat(valorUnitarioStr));
                    }
                    vend.setValorTotal(Float.parseFloat(request.getParameter("valorTotal")));
                    
                    // Data e hora atual no timezone do Brasil
                    Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("America/Sao_Paulo"));
                    Timestamp dataVenda = new Timestamp(cal.getTimeInMillis());
                    vend.setDataVenda(dataVenda);
                    
                    VendaDAO vendDAO = new VendaDAO();
                    if (vendDAO.cadastrar(vend)){
                        out.println("<div class='success'>Venda inserida com sucesso! Estoque atualizado.</div>");
                        out.println("<div class='info'>");
                        out.println("<strong>ID da Venda: </strong>" + vend.getId() + "<br>");
                        out.println("<strong>ID Cliente: </strong>" + vend.getIdCliente() + "<br>");
                        out.println("<strong>ID Produto: </strong>" + vend.getIdProduto() + "<br>");
                        out.println("<strong>Quantidade: </strong>" + vend.getQuantidade() + "<br>");
                        out.println("<strong>Valor Unitário: </strong>R$ " + formatarMoeda(vend.getValorUnitario()) + "<br>");
                        out.println("<strong>Valor Total: </strong>R$ " + formatarMoeda(vend.getValorTotal()));
                        if (vend.getDataVenda() != null) {
                            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                            sdf.setTimeZone(TimeZone.getTimeZone("America/Sao_Paulo"));
                            out.println("<br><strong>Data e Hora (Brasil): </strong>" + sdf.format(vend.getDataVenda()));
                        }
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>Venda não inserida! Verifique se o produto tem estoque suficiente ou se há erros na transação.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

