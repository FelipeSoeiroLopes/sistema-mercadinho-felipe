<%-- 
    Document   : Cadastro de Produtos
    Mercadinho do Felipe
    Java 24
    Desenvolvedores:
    - Felipe Soeiro Lopes
    - Giovanna de Paula Lopes Santos
    - Kauã da Silveira Nascimento Machado
    - Victor Guimarães Felipe
--%>

<%@include file="../verificar_sessao.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Produtos"%>
<%@page import="model.DAO.ProdutoDAO"%>
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
    if (!isAdmin) {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=acesso_negado");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Produtos</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body { 
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
                margin: 0;
                padding: 20px; 
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .container { 
                max-width: 700px; 
                width: 100%;
                margin: 0 auto; 
                background: white; 
                padding: 40px; 
                border-radius: 20px; 
                box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            }
            h1 { 
                color: #f5576c; 
                margin-bottom: 30px;
                font-size: 32px;
                text-align: center;
            }
            .success { 
                color: #155724; 
                padding: 15px; 
                background: #d4edda; 
                border-radius: 10px; 
                margin: 20px 0;
                border-left: 4px solid #28a745;
                font-weight: 500;
            }
            .error { 
                color: #721c24; 
                padding: 15px; 
                background: #f8d7da; 
                border-radius: 10px; 
                margin: 20px 0;
                border-left: 4px solid #dc3545;
                font-weight: 500;
            }
            .info { 
                margin: 20px 0; 
                padding: 20px; 
                background: linear-gradient(135deg, #e7f3ff 0%, #d0e7ff 100%); 
                border-radius: 10px;
                border-left: 4px solid #007bff;
            }
            .info strong {
                color: #0056b3;
            }
            a { 
                display: inline-flex;
                align-items: center;
                gap: 8px;
                margin-top: 20px; 
                color: white;
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                text-decoration: none; 
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s;
            }
            a:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Cadastro de Produtos</h1>
            <%
                // Configurar encoding UTF-8 ANTES de processar parâmetros
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");
                
                try {
                    Produtos prod = new Produtos();
                    prod.setNome(request.getParameter("nome"));
                    prod.setValor(Float.parseFloat(request.getParameter("valor")));
                    prod.setQtd(Integer.parseInt(request.getParameter("qtd")));
                    prod.setCategoria(request.getParameter("categoria"));
                    
                    String idFornecedorStr = request.getParameter("idFornecedor");
                    if (idFornecedorStr != null && !idFornecedorStr.isEmpty() && !idFornecedorStr.equals("0")) {
                        prod.setIdFornecedor(Integer.parseInt(idFornecedorStr));
                    } else {
                        prod.setIdFornecedor(0);
                    }
                    
                    ProdutoDAO prodDAO = new ProdutoDAO();
                    if (prodDAO.cadastrar(prod)){
                        out.println("<div class='success'>Produto inserido com sucesso!</div>");
                        out.println("<div class='info'>");
                        out.println("<strong>Nome: </strong>" + prod.getNome() + "<br>");
                        out.println("<strong>Valor: </strong>R$ " + formatarMoeda(prod.getValor()) + "<br>");
                        out.println("<strong>Quantidade: </strong>" + prod.getQtd() + "<br>");
                        out.println("<strong>Categoria: </strong>" + prod.getCategoria());
                        out.println("</div>");
                    } else {
                        out.println("<div class='error'>Produto não inserido! Erro na transação.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='error'>Erro: " + ex.getMessage() + "</div>");
                }
            %>
            <a href="index.jsp">← Voltar</a>
        </div>
    </body>
</html>
