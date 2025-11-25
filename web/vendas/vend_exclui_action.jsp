<%-- 
    Document   : Processamento de Exclusão de Venda
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
        <title>Resultado da Exclusão</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #fa709a; }
            .success { color: green; padding: 10px; background: #d4edda; border-radius: 5px; margin: 10px 0; }
            .error { color: red; padding: 10px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            .back-link { display: inline-block; margin-top: 20px; color: #fa709a; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Resultado da Exclusão</h1>
            <%
                try {
                    Vendas vend = new Vendas();
                    vend.setId(Integer.parseInt(request.getParameter("id")));
                    
                    VendaDAO vendDAO = new VendaDAO();
                    if (vendDAO.excluir(vend)){
                        out.println("<div class='success'>Venda excluída com sucesso! O estoque do produto foi restaurado.</div>");
                    } else {
                        out.println("<div class='error'>Não foi possível excluir a venda.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro ao processar a exclusão: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp" class="back-link">&larr; Voltar para Vendas</a>
            <br>
            <a href="../index.jsp" class="back-link">&larr; Voltar ao Menu Principal</a>
        </div>
    </body>
</html>
