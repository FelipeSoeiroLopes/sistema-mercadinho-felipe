<%-- 
    Document   : Consulta de Produto por Nome
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
            prod.setNome(request.getParameter("nome"));            
            
            //Consultar Id...
            ProdutoDAO prodDAO = new ProdutoDAO();            
            prod = prodDAO.consultar_nome(prod);
            
            if (prod == null){
                out.println("Produto não encontrado!");
            }else{
               //Saída
               out.println("<br> <b>Código....: </b>" + prod.getId());
               out.println("<br> <b>Produto...: </b>" + prod.getNome());
               out.println("<br> <b>Valor.....: </b>" + prod.getValor());
               out.println("<br> <b>Quantidade: </b>" + prod.getQtd());                
            }
        %>
    </body>
</html>
