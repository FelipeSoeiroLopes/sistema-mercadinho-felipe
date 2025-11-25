<%-- 
    Document   : Consulta Geral de Vendas
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
<%@page import="model.Vendas"%>
<%@page import="model.DAO.VendaDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.TimeZone"%>
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
        <title>Consulta Geral de Vendas</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #fa709a; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 13px; }
            th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
            th { background-color: #fa709a; color: white; position: sticky; top: 0; }
            tr:hover { background-color: #f5f5f5; }
            td { word-wrap: break-word; }
            .empty { color: #666; padding: 20px; text-align: center; }
            a { display: inline-block; margin-top: 20px; color: #fa709a; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Consulta Geral de Vendas</h1>
            <%
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
                
                List<Vendas> lista = new ArrayList<>();
                VendaDAO vendDAO = new VendaDAO();
                lista = vendDAO.consultar_geral();
                
                if (lista == null || lista.isEmpty()){
                    out.println("<div class='empty'>Nenhuma venda encontrada!</div>");
                } else {
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                    sdf.setTimeZone(java.util.TimeZone.getTimeZone("America/Sao_Paulo"));
                    
                    out.println("<table>");
                    out.println("<tr><th>ID Venda</th><th>ID Cliente</th><th>ID Produto</th><th>Nome Produto</th><th>Quantidade</th><th>Valor Unitário</th><th>Valor Total</th><th>Data e Hora (Brasil)</th><th>Ações</th></tr>");
                    for(int i = 0; i < lista.size(); i++){ 
                        Vendas v = lista.get(i);
                        out.println("<tr>");
                        out.println("<td>" + v.getId() + "</td>");
                        out.println("<td>" + v.getIdCliente() + "</td>");
                        out.println("<td>" + v.getIdProduto() + "</td>");
                        out.println("<td>" + (v.getNomeProduto() != null ? v.getNomeProduto() : "N/A") + "</td>");
                        out.println("<td>" + v.getQuantidade() + "</td>");
                        out.println("<td>R$ " + formatarMoeda(v.getValorUnitario()) + "</td>");
                        out.println("<td>R$ " + formatarMoeda(v.getValorTotal()) + "</td>");
                        if (v.getDataVenda() != null) {
                            out.println("<td>" + sdf.format(v.getDataVenda()) + "</td>");
                        } else {
                            out.println("<td>N/A</td>");
                        }
                        
                        out.println("<td style='text-align:center;'>");

// Ícone Editar
out.println("<a href='vend_cons_id_alt.jsp?id=" + v.getId() + "'>");
out.println("<img alt='Editar' width='30' height='30' "
    + "src=\"data:image/svg+xml;utf8,"
    + "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'>"
    + "<path fill='%23f5a623' d='M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25z'/>"
    + "<path fill='%23000000' d='M20.71 7.04a1.003 1.003 0 0 0 0-1.42l-2.34-2.34a1.003 1.003 0 0 0-1.42 0l-1.83 1.83 3.75 3.75 1.84-1.82z'/>"
    + "</svg>\"/>"
);
out.println("</a>");

// Ícone Excluir
out.println("<a href='vend_excluir_form.jsp?id=" + v.getId() + "'>");
out.println("<img alt='Excluir' width='30' height='30' "
    + "src=\"data:image/svg+xml;utf8,"
    + "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'>"
    + "<path fill='%23d0021b' d='M6 7h12v13a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2V7z'/>"
    + "<path fill='%23000000' d='M9 4h6l1 2h4v2H4V6h4l1-2z'/>"
    + "<path fill='%23ffffff' d='M9 10h2v8H9zm4 0h2v8h-2z'/>"
    + "</svg>\"/>"
);
out.println("</a>");

out.println("</td>");

                        
                        out.println("</tr>");
                    }
                    out.println("</table>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

