<%-- 
    Document   : Consulta de Produtos por Nome (Busca Parcial)
    Mercadinho do Felipe
    Java 24
    Desenvolvedores:
    - Felipe Soeiro Lopes
    - Giovanna de Paula Lopes Santos
    - Kauã da Silveira Nascimento Machado
    - Victor Guimarães Felipe
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
        <h2>Consulta de Produtos - Contém no nome</h2>        
        <%                     
            List<Produtos> lista = new ArrayList();            
            
            //Consultar Id...
            ProdutoDAO prodDAO = new ProdutoDAO();                                
            
            lista = prodDAO.consultar_nome(request.getParameter("nome"));
            if (prodDAO.consultar_geral() == null){
                out.println("Produto não encontrado!");
            }else{
               //Saída
               out.println("<br> <b>Código | Nome | Valor | Qtd </b> <br>");
               for(int i=0; i <= lista.size() - 1; i++){ 
                    out.println( lista.get(i).getId() + " | " + lista.get(i).getNome()+ " | "+ lista.get(i).getValor()+ " | " + lista.get(i).getQtd() + "<br>");               
               }
            }


        %>
    </body>
</html>
