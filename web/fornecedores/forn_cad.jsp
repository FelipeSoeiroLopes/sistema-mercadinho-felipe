<%-- 
    Document   : Cadastro de Fornecedores
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
<%@page import="model.Fornecedores"%>
<%@page import="model.DAO.FornecedorDAO"%>

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
        <title>Cadastro de Fornecedores</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
            .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h1 { color: #4facfe; }
            .success { color: green; padding: 10px; background: #d4edda; border-radius: 5px; margin: 10px 0; }
            .error { color: red; padding: 10px; background: #f8d7da; border-radius: 5px; margin: 10px 0; }
            .info { margin: 10px 0; padding: 10px; background: #e7f3ff; border-radius: 5px; }
            a { display: inline-block; margin-top: 20px; color: #4facfe; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Cadastro de Fornecedores</h1>
            <%
                // Configurar encoding UTF-8 ANTES de processar parâmetros
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");
                
                try {
                    Fornecedores forn = new Fornecedores();
                    forn.setNome(request.getParameter("nome"));
                    forn.setCnpj(request.getParameter("cnpj"));
                    forn.setTelefone(request.getParameter("telefone"));
                    forn.setEmail(request.getParameter("email"));
                    forn.setEndereco(request.getParameter("endereco"));
                    
                    FornecedorDAO fornDAO = new FornecedorDAO();
                    if (fornDAO.cadastrar(forn)){
                        out.println("<div class='success'>Fornecedor inserido com sucesso!</div>");
                        out.println("<div class='info'>");
                        out.println("<strong>Nome: </strong>" + forn.getNome() + "<br>");
                        out.println("<strong>CNPJ: </strong>" + forn.getCnpj() + "<br>");
                        out.println("<strong>Telefone: </strong>" + forn.getTelefone() + "<br>");
                        out.println("<strong>E-mail: </strong>" + forn.getEmail() + "<br>");
                        out.println("<strong>Endereço: </strong>" + forn.getEndereco());
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>Fornecedor não inserido! Erro na transação.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
    </body>
</html>

