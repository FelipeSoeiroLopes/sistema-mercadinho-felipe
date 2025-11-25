<%-- 
    Document   : Formulário de Cadastro de Vendas
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
<%@page import="java.util.*"%>
<%@page import="model.Clientes"%>
<%@page import="model.Produtos"%>
<%@page import="model.DAO.ClienteDAO"%>
<%@page import="model.DAO.ProdutoDAO"%>

<%
    // Carregar listas
    List<Clientes> listaClientes = new ArrayList<>();
    List<Produtos> listaProdutos = new ArrayList<>();
    try {
        ClienteDAO cliDAO = new ClienteDAO();
        ProdutoDAO prodDAO = new ProdutoDAO();
        listaClientes = cliDAO.consultar_geral();
        listaProdutos = prodDAO.consultar_geral();
        if (listaClientes == null) listaClientes = new ArrayList<>();
        if (listaProdutos == null) listaProdutos = new ArrayList<>();
    } catch (Exception ex) {
        listaClientes = new ArrayList<>();
        listaProdutos = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Cadastrar Venda - Mercadinho do Felipe</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                margin: 0;
                padding: 20px;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .container {
                background-color: #fff;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                width: 100%;
                max-width: 500px;
            }
            h2 {
                margin-bottom: 20px;
                color: #fa709a;
                font-size: 24px;
                text-align: center;
            }
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 500;
                color: #333;
            }
            input[type="number"], select {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #dcdfe3;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
                box-sizing: border-box;
            }
            input:focus, select:focus {
                border-color: #fa709a;
                outline: none;
            }
            .valor-info {
                padding: 10px;
                background: #e7f3ff;
                border: 1px solid #007bff;
                border-radius: 4px;
                margin-bottom: 20px;
                font-size: 14px;
            }
            .valor-info strong {
                color: #0056b3;
            }
            .buttons {
                display: flex;
                justify-content: space-between;
            }
            button {
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .submit-btn {
                background-color: #fa709a;
                color: white;
            }
            .submit-btn:hover {
                background-color: #d85a7f;
            }
            .reset-btn {
                background-color: #e0e0e0;
                color: #333;
            }
            .reset-btn:hover {
                background-color: #c2c2c2;
            }
            a {
                display: inline-block;
                margin-top: 15px;
                color: #fa709a;
                text-decoration: none;
            }
            .info {
                padding: 10px;
                background: #fff3cd;
                border: 1px solid #ffc107;
                border-radius: 4px;
                margin-bottom: 20px;
                color: #856404;
                font-size: 14px;
            }
        </style>
        <script>
            // Armazenar valores dos produtos
            var produtos = {
                <% 
                    for (Produtos p : listaProdutos) {
                        out.println(p.getId() + ": {valor: " + p.getValor() + ", nome: '" + 
                                   (p.getNome() != null ? p.getNome().replace("'", "\\'") : "") + "'},");
                    }
                %>
            };
            
            function calcularTotal() {
                var idProduto = document.getElementById('idProduto').value;
                var quantidade = parseFloat(document.getElementById('quantidade').value) || 0;
                var produto = produtos[idProduto];
                
                if (produto && quantidade > 0) {
                    var valorUnitario = produto.valor;
                    var valorTotal = valorUnitario * quantidade;
                    
                    document.getElementById('valorUnitario').value = valorUnitario.toFixed(2);
                    document.getElementById('valorTotal').value = valorTotal.toFixed(2);
                    
                    document.getElementById('valorInfo').innerHTML = 
                        '<strong>Valor Unitário:</strong> R$ ' + valorUnitario.toFixed(2) + 
                        ' | <strong>Valor Total:</strong> R$ ' + valorTotal.toFixed(2);
                } else {
                    document.getElementById('valorUnitario').value = '';
                    document.getElementById('valorTotal').value = '';
                    document.getElementById('valorInfo').innerHTML = '';
                }
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h2>Cadastrar Venda</h2>
            <% if (listaClientes.isEmpty() || listaProdutos.isEmpty()) { %>
                <div class="info">
                    ⚠️ É necessário ter pelo menos um cliente e um produto cadastrados para realizar uma venda.
                </div>
            <% } %>
            <form method="post" action="vend_cad.jsp" id="formVenda" accept-charset="UTF-8">
                <label for="idCliente">Cliente:</label>
                <select id="idCliente" name="idCliente" required>
                    <option value="">Selecione um cliente</option>
                    <% 
                        for (Clientes c : listaClientes) {
                            out.println("<option value=\"" + c.getId() + "\">" + 
                                       (c.getNome() != null ? c.getNome() : "") + 
                                       " (ID: " + c.getId() + ")</option>");
                        }
                    %>
                </select>
                
                <label for="idProduto">Produto:</label>
                <select id="idProduto" name="idProduto" required onchange="calcularTotal()">
                    <option value="">Selecione um produto</option>
                    <% 
                        for (Produtos p : listaProdutos) {
                            out.println("<option value=\"" + p.getId() + "\" data-valor=\"" + p.getValor() + "\">" + 
                                       (p.getNome() != null ? p.getNome() : "") + 
                                       " - R$ " + String.format("%.2f", p.getValor()) + 
                                       " (Estoque: " + p.getQtd() + ")</option>");
                        }
                    %>
                </select>
      
                <label for="quantidade">Quantidade:</label>
                <input type="number" id="quantidade" name="quantidade" step="1" min="1" required 
                       oninput="calcularTotal()" onchange="calcularTotal()">
                
                <div id="valorInfo" class="valor-info" style="display: none;"></div>
                
                <input type="hidden" id="valorUnitario" name="valorUnitario">
                <input type="hidden" id="valorTotal" name="valorTotal">
               
                <div class="buttons">
                    <button type="submit" class="submit-btn">Salvar</button>
                    <button type="reset" class="reset-btn" onclick="document.getElementById('valorInfo').style.display='none';">Limpar</button>
                </div>
            </form>
            <a href="index.jsp">&larr; Voltar</a>
        </div>
        <script>
            // Mostrar info quando houver valores
            document.getElementById('quantidade').addEventListener('input', function() {
                var info = document.getElementById('valorInfo');
                if (info.innerHTML.trim() !== '') {
                    info.style.display = 'block';
                }
            });
        </script>
    </body>
</html>

