<%-- 
    Document   : Consulta de Produto por ID para Alteração
    Mercadinho do Felipe
    Java 24
    Desenvolvedores:
    - Felipe Soeiro Lopes
    - Giovanna de Paula Lopes Santos
    - Kauã da Silveira Nascimento Machado
    - Victor Guimarães Felipe
--%>

<%@page import="model.Produtos"%>
<%@page import="model.DAO.ProdutoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Consulta de Produtos Geral</h2>        
        <%                     
            // Instância do Objeto           
            Produtos prod = new Produtos();
            prod.setId(Integer.parseInt(request.getParameter("ident")));            
            
            //Consultar Id...
            ProdutoDAO prodDAO = new ProdutoDAO();            
            prod = prodDAO.consultar_id(prod);
            
            if (prod == null){
                out.println("Produto não encontrado!");
            }else{
               //Saída
        %>
                <form method="post" action="prod_alt.jsp">
                    <p>Identificador: <input type="number" name="ident" step="1" readonly="true" value="<%=prod.getId()%>"></p>
                    <p>Produto: <input type="text" name="nome" value="<%=prod.getNome()%>"></p>
                    <p>Valor <input type="number" name="valor" step="0.05" value="<%=prod.getValor()%>"></p>
                    <p>Quantidade: <input type="number" name="qtd" step="1" value="<%=prod.getQtd()%>"></p>

                    <input type="submit" value="Alterar">
                    <input type="reset" value="Limpar">
                </form>              
                    
        <%
            }
        %>
    </body>
</html>
