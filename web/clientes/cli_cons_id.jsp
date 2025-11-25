<%-- 
    Document   : Consulta Cliente por ID
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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>Consulta Cliente por ID</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #43e97b; }
            .info { margin: 10px 0; padding: 15px; background: #e7f3ff; border-radius: 5px; }
            .error { color: red; padding: 15px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            a { display: inline-block; margin-top: 20px; color: #43e97b; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Consulta de Cliente por ID</h1>
            <%
                try {
                    Clientes cli = new Clientes();
                    cli.setId(Integer.parseInt(request.getParameter("id")));
                    
                    ClienteDAO cliDAO = new ClienteDAO();
                    Clientes resultado = cliDAO.consultar_id(cli);
                    
                    if (resultado != null) {
                        out.println("<div class='info'>");
                        out.println("<strong>ID: </strong>" + resultado.getId() + "<br>");
                        out.println("<strong>Nome: </strong>" + resultado.getNome() + "<br>");
                        out.println("<strong>CPF: </strong>" + resultado.getCpf() + "<br>");
                        out.println("<strong>Telefone: </strong>" + resultado.getTelefone() + "<br>");
                        out.println("<strong>E-mail: </strong>" + resultado.getEmail() + "<br>");
                        out.println("<strong>Endereço: </strong>" + resultado.getEndereco());
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>Cliente não encontrado!</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

