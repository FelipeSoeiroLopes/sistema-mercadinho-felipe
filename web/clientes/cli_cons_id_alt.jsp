<%-- 
    Document   : Consulta Cliente por ID para Alterar
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
        <title>Alterar Cliente</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #43e97b; }
            label { display: block; margin-bottom: 6px; font-weight: 500; color: #333; }
            input { width: 100%; padding: 10px; margin-bottom: 20px; border: 1px solid #dcdfe3; border-radius: 4px; font-size: 16px; }
            button { padding: 10px 20px; font-size: 16px; border: none; border-radius: 4px; cursor: pointer; background-color: #43e97b; color: white; width: 100%; }
            .error { color: red; padding: 15px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            a { display: inline-block; margin-top: 20px; color: #43e97b; text-decoration: none; }
        </style>
        <script>
            // Máscara para CPF
            function mascaraCPF(campo) {
                let valor = campo.value.replace(/\D/g, '');
                if (valor.length <= 11) {
                    valor = valor.replace(/(\d{3})(\d)/, '$1.$2');
                    valor = valor.replace(/(\d{3})(\d)/, '$1.$2');
                    valor = valor.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
                }
                campo.value = valor;
            }
            
            // Máscara para Telefone
            function mascaraTelefone(campo) {
                let valor = campo.value.replace(/\D/g, '');
                if (valor.length <= 10) {
                    valor = valor.replace(/(\d{2})(\d)/, '($1) $2');
                    valor = valor.replace(/(\d{4})(\d)/, '$1-$2');
                } else {
                    valor = valor.replace(/(\d{2})(\d)/, '($1) $2');
                    valor = valor.replace(/(\d{5})(\d)/, '$1-$2');
                }
                campo.value = valor;
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h1>Alterar Cliente</h1>
            <%
                try {
                    Clientes cli = new Clientes();
                    cli.setId(Integer.parseInt(request.getParameter("id")));
                    
                    ClienteDAO cliDAO = new ClienteDAO();
                    Clientes resultado = cliDAO.consultar_id(cli);
                    
                    if (resultado != null) {
                        out.println("<form method='post' action='cli_alt.jsp' accept-charset='UTF-8'>");
                        out.println("<input type='hidden' name='id' value='" + resultado.getId() + "'>");
                        out.println("<label for='nome'>Nome do Cliente:</label>");
                        out.println("<input type='text' id='nome' name='nome' value='" + resultado.getNome() + "' required>");
                        out.println("<label for='cpf'>CPF:</label>");
                        out.println("<input type='text' id='cpf' name='cpf' maxlength='14' value='" + (resultado.getCpf() != null ? resultado.getCpf() : "") + "' oninput='mascaraCPF(this)' required>");
                        out.println("<label for='telefone'>Telefone:</label>");
                        out.println("<input type='text' id='telefone' name='telefone' maxlength='15' value='" + (resultado.getTelefone() != null ? resultado.getTelefone() : "") + "' oninput='mascaraTelefone(this)' required>");
                        out.println("<label for='email'>E-mail:</label>");
                        out.println("<input type='email' id='email' name='email' value='" + resultado.getEmail() + "' required>");
                        out.println("<label for='endereco'>Endereço:</label>");
                        out.println("<input type='text' id='endereco' name='endereco' value='" + resultado.getEndereco() + "' required>");
                        out.println("<button type='submit'>Alterar</button>");
                        out.println("</form>");
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

