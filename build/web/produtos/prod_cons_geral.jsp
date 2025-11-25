<%-- 
    Document   : Consulta Geral de Produtos
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
<%@page import="Config.ConectaBanco"%>
<%@page import="java.sql.*"%>
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
        <title>Consulta Geral de Produtos</title>
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
            <h1>Consulta Geral de Produtos</h1>
            <%
                response.setCharacterEncoding("UTF-8");
                request.setCharacterEncoding("UTF-8");
                
                Connection conn = null;
                try {
                    conn = ConectaBanco.conectar();
                    // JOIN com fornecedores para obter o nome do fornecedor
                    String sql = "SELECT p.*, f.nome as nome_fornecedor " +
                                "FROM produtos p " +
                                "LEFT JOIN fornecedores f ON p.id_fornecedor = f.pk_id " +
                                "ORDER BY p.pk_id ASC";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);
                    
                    if (!rs.next()) {
                        out.println("<div class='empty'>Nenhum produto encontrado!</div>");
                    } else {
                        out.println("<table>");
                        out.println("<tr><th>ID</th><th>Nome</th><th>Valor</th><th>Quantidade</th><th>Categoria</th><th>Fornecedor</th><th>Ações</th></tr>");
                        do {
                            int id = rs.getInt("pk_id");
                            String nome = rs.getString("nome") != null ? rs.getString("nome") : "";
                            float valor = rs.getFloat("valor");
                            int qtd = rs.getInt("qtd");
                            String categoria = rs.getString("categoria") != null ? rs.getString("categoria") : "";
                            String nomeFornecedor = rs.getString("nome_fornecedor");
                            
                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + nome + "</td>");
                            out.println("<td>R$ " + formatarMoeda(valor) + "</td>");
                            out.println("<td>" + qtd + "</td>");
                            out.println("<td>" + categoria + "</td>");
                            out.println("<td>" + (nomeFornecedor != null ? nomeFornecedor : "<em>Sem fornecedor</em>") + "</td>");
                            
                           
                                                      
                        out.println("<td style='text-align:center;'>");

                        // Ícone Editar
                        out.println("<a href='prod_cons_id_alt.jsp?id=" + id + "'>");
                        out.println("<img alt='Editar' width='30' height='30' "
                            + "src=\"data:image/svg+xml;utf8,"
                            + "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'>"
                            + "<path fill='%23f5a623' d='M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25z'/>"
                            + "<path fill='%23000000' d='M20.71 7.04a1.003 1.003 0 0 0 0-1.42l-2.34-2.34a1.003 1.003 0 0 0-1.42 0l-1.83 1.83 3.75 3.75 1.84-1.82z'/>"
                            + "</svg>\"/>"
                        );
                        out.println("</a>");

                        // Ícone Excluir
                        out.println("<a href='prod_excluir_form.jsp?id=" + id + "'>");
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
                        } while (rs.next());
                        out.println("</table>");
                        rs.close();
                        stmt.close();
                    }
                    ConectaBanco.commit(conn);
                    ConectaBanco.fechar(conn);
                } catch (Exception ex) {
                    out.println("<div class='empty'>Erro ao consultar produtos: " + ex.getMessage() + "</div>");
                    if (conn != null) {
                        ConectaBanco.rollback(conn);
                        ConectaBanco.fechar(conn);
                    }
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

