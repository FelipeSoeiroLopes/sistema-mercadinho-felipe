<%-- 
    Document   : Consulta de Produtos em Tabela
    Mercadinho do Felipe
    Java 24
    Desenvolvedores:
    - Felipe Soeiro Lopes
    - Giovanna de Paula Lopes Santos
    - Kauã da Silveira Nascimento Machado
    - Victor Guimarães Felipe
--%>

<%@page import="java.util.*"%>
<%@page import="model.Produtos"%>
<%@page import="model.DAO.ProdutoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%-- 
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th{
                padding: 8px;
                text-align: left;
                border: 1px solid #DDD;
                background-color: #1a73e8;
            }
            td{
                padding: 8px;
                text-align: left;
                border: 1px solid #DDD;
            }
            tr:hover {background-color: #D6EEEE;}
        </style> --%>
        
        
        <link href="../style_geral/tabela.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h2>Consulta de Produtos Geral</h2>
        
        <%
            List<Produtos> lista = new ArrayList();
                    
            // Instância do Objeto           
            //Consultar Geral...
            ProdutoDAO prodDAO = new ProdutoDAO();
            lista = prodDAO.consultar_geral();
            if (prodDAO.consultar_geral() == null){
                out.println("Produto não encontrado!");
            }else{
               //Saída
        %>
                <table class="table table-hover">
                    <tr>                        
                        <th>Código</th>
                        <th>Nome</th>
                        <th>Valor</th>
                        <th>Qtd</th>                                               
                   </tr>                 
        <%
               for(int i=0; i <= lista.size() - 1; i++){ 
        %>
                    <tr>                        
                        <td><%=lista.get(i).getId()%></td>
                        <td><%=lista.get(i).getNome()%></td>
                        <td><%=lista.get(i).getValor()%></td>
                        <td><%=lista.get(i).getQtd()%></td>                                               
                   </tr>                        
        <%
               }
            }
        %>
               </table>
    </body>
</html>
