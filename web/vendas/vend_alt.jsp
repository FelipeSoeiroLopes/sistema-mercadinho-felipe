<%-- 
    Document   : Alteração de Vendas
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
<%@page import="java.text.SimpleDateFormat"%>
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
        <title>Alteração de Vendas</title>
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
            <h1>Alteração de Vendas</h1>
            <%
                // Configurar encoding UTF-8 ANTES de processar parâmetros
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");
                
                try {
                    Vendas vend = new Vendas();
                    vend.setId(Integer.parseInt(request.getParameter("id")));
                    vend.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
                    vend.setIdProduto(Integer.parseInt(request.getParameter("idProduto")));
                    vend.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
                    
                    // Valor unitário e total
                    String valorUnitarioStr = request.getParameter("valorUnitario");
                    if (valorUnitarioStr != null && !valorUnitarioStr.isEmpty()) {
                        vend.setValorUnitario(Float.parseFloat(valorUnitarioStr));
                    }
                    vend.setValorTotal(Float.parseFloat(request.getParameter("valorTotal")));
                    
                    // Processar data e hora no formato datetime-local (YYYY-MM-DDTHH:mm)
                    String dataVendaStr = request.getParameter("dataVenda");
                    if (dataVendaStr != null && !dataVendaStr.isEmpty()) {
                        try {
                            // Converter de datetime-local para Timestamp com timezone Brasil
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                            sdf.setTimeZone(TimeZone.getTimeZone("America/Sao_Paulo"));
                            java.util.Date date = sdf.parse(dataVendaStr);
                            Timestamp timestamp = new Timestamp(date.getTime());
                            vend.setDataVenda(timestamp);
                        } catch (Exception e) {
                            // Se houver erro, usa a data/hora atual
                            Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("America/Sao_Paulo"));
                            vend.setDataVenda(new Timestamp(cal.getTimeInMillis()));
                        }
                    } else {
                        // Se não informou data, usa a data/hora atual
                        Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("America/Sao_Paulo"));
                        vend.setDataVenda(new Timestamp(cal.getTimeInMillis()));
                    }
                    
                    VendaDAO vendDAO = new VendaDAO();
                    if (vendDAO.alterar(vend)){
                        out.println("<div class='success'>Venda alterada com sucesso! Estoque atualizado.</div>");
                        out.println("<div class='info'>");
                        out.println("<strong>ID: </strong>" + vend.getId() + "<br>");
                        out.println("<strong>ID Cliente: </strong>" + vend.getIdCliente() + "<br>");
                        out.println("<strong>ID Produto: </strong>" + vend.getIdProduto() + "<br>");
                        out.println("<strong>Quantidade: </strong>" + vend.getQuantidade() + "<br>");
                        out.println("<strong>Valor Unitário: </strong>R$ " + formatarMoeda(vend.getValorUnitario()) + "<br>");
                        out.println("<strong>Valor Total: </strong>R$ " + formatarMoeda(vend.getValorTotal()));
                        if (vend.getDataVenda() != null) {
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                            sdf.setTimeZone(TimeZone.getTimeZone("America/Sao_Paulo"));
                            out.println("<br><strong>Data e Hora (Brasil): </strong>" + sdf.format(vend.getDataVenda()));
                        }
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>Venda não alterada! Verifique se o produto tem estoque suficiente ou se há erros na transação.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

