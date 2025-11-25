<%-- 
    Document   : Consulta Venda por ID para Alterar
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
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>

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
        <title>Alterar Venda</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #fa709a; }
            label { display: block; margin-bottom: 6px; font-weight: 500; color: #333; }
            input { width: 100%; padding: 10px; margin-bottom: 20px; border: 1px solid #dcdfe3; border-radius: 4px; font-size: 16px; box-sizing: border-box; }
            button { padding: 10px 20px; font-size: 16px; border: none; border-radius: 4px; cursor: pointer; background-color: #fa709a; color: white; width: 100%; }
            .error { color: red; padding: 15px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            a { display: inline-block; margin-top: 20px; color: #fa709a; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Alterar Venda</h1>
            <%
                try {
                    Vendas vend = new Vendas();
                    vend.setId(Integer.parseInt(request.getParameter("id")));
                    
                    VendaDAO vendDAO = new VendaDAO();
                    Vendas resultado = vendDAO.consultar_id(vend);
                    
                    if (resultado != null) {
                        out.println("<form method='post' action='vend_alt.jsp' accept-charset='UTF-8'>");
                        out.println("<input type='hidden' name='id' value='" + resultado.getId() + "'>");
                        out.println("<label for='idCliente'>ID do Cliente:</label>");
                        out.println("<input type='number' id='idCliente' name='idCliente' value='" + resultado.getIdCliente() + "' required>");
                        out.println("<label for='idProduto'>ID do Produto:</label>");
                        out.println("<input type='number' id='idProduto' name='idProduto' value='" + resultado.getIdProduto() + "' required>");
                        out.println("<label for='quantidade'>Quantidade:</label>");
                        out.println("<input type='number' id='quantidade' name='quantidade' step='1' min='1' value='" + resultado.getQuantidade() + "' required>");
                        out.println("<label for='valorUnitario'>Valor Unitário (R$):</label>");
                        out.println("<input type='number' id='valorUnitario' name='valorUnitario' step='0.01' min='0' value='" + String.format("%.2f", resultado.getValorUnitario()).replace(",", ".") + "' required>");
                        out.println("<label for='valorTotal'>Valor Total (R$):</label>");
                        out.println("<input type='number' id='valorTotal' name='valorTotal' step='0.01' min='0' value='" + String.format("%.2f", resultado.getValorTotal()).replace(",", ".") + "' required>");
                        out.println("<label for='dataVenda'>Data e Hora da Venda:</label>");
                        if (resultado.getDataVenda() != null) {
                            // Converter Timestamp para formato datetime-local (YYYY-MM-DDTHH:mm)
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                            sdf.setTimeZone(TimeZone.getTimeZone("America/Sao_Paulo"));
                            String dataFormatada = sdf.format(resultado.getDataVenda());
                            out.println("<input type='datetime-local' id='dataVenda' name='dataVenda' value='" + dataFormatada + "'>");
                        } else {
                            out.println("<input type='datetime-local' id='dataVenda' name='dataVenda'>");
                        }
                        out.println("<button type='submit'>Alterar</button>");
                        out.println("</form>");
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

