<%-- 
    Document   : Alteração de Clientes
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
<%@page import="model.Clientes"%>
<%@page import="model.DAO.ClienteDAO"%>

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
        <title>Alteração de Clientes</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #43e97b; }
            .success { color: green; padding: 10px; background: #d4edda; border-radius: 5px; margin: 10px 0; }
            .error { color: red; padding: 10px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            .info { margin: 10px 0; padding: 10px; background: #e7f3ff; border-radius: 5px; }
            a { display: inline-block; margin-top: 20px; color: #43e97b; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Alteração de Clientes</h1>
            <%
                // Configurar encoding UTF-8 ANTES de processar parâmetros
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");
                
                try {
                    Clientes cli = new Clientes();
                    cli.setId(Integer.parseInt(request.getParameter("id")));
                    cli.setNome(request.getParameter("nome"));
                    cli.setCpf(request.getParameter("cpf"));
                    cli.setTelefone(request.getParameter("telefone"));
                    cli.setEmail(request.getParameter("email"));
                    cli.setEndereco(request.getParameter("endereco"));
                    
                    ClienteDAO cliDAO = new ClienteDAO();
                    if (cliDAO.alterar(cli)){
                        out.println("<div class='success'>Cliente alterado com sucesso!</div>");
                        out.println("<div class='info'>");
                        out.println("<strong>ID: </strong>" + cli.getId() + "<br>");
                        out.println("<strong>Nome: </strong>" + cli.getNome() + "<br>");
                        out.println("<strong>CPF: </strong>" + cli.getCpf() + "<br>");
                        out.println("<strong>Telefone: </strong>" + cli.getTelefone() + "<br>");
                        out.println("<strong>E-mail: </strong>" + cli.getEmail() + "<br>");
                        out.println("<strong>Endereço: </strong>" + cli.getEndereco());
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>Cliente não alterado! Erro na transação.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

