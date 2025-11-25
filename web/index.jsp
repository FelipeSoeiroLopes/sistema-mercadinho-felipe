<%-- 
    Document   : Página Principal
    Mercadinho do Felipe
    Java 24
    Desenvolvedores:
    - Felipe Soeiro Lopes
    - Giovanna de Paula Lopes Santos
    - Kauã da Silveira Nascimento Machado
    - Victor Guimarães Felipe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="verificar_sessao.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Mercadinho do Felipe</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
            }
            .header {
                background: white;
                padding: 20px 40px;
                border-radius: 15px;
                margin-bottom: 30px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }
            .user-info {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            .user-badge {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 600;
            }
            .user-name {
                font-weight: 600;
                color: #333;
            }
            .btn-logout {
                background: #dc3545;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
            }
            .btn-logout:hover {
                background: #c82333;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: #fff;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            }
            h1 {
                color: #667eea;
                text-align: center;
                margin-bottom: 10px;
                font-size: 42px;
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .subtitle {
                text-align: center;
                color: #666;
                margin-bottom: 40px;
                font-size: 18px;
            }
            .menu-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 25px;
                margin-top: 30px;
            }
            .menu-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                padding: 35px;
                border-radius: 15px;
                text-align: center;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                cursor: pointer;
                text-decoration: none;
                color: white;
                display: block;
                position: relative;
                overflow: hidden;
            }
            .menu-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: rgba(255,255,255,0.2);
                transition: left 0.5s;
            }
            .menu-card:hover::before {
                left: 100%;
            }
            .menu-card:hover {
                transform: translateY(-8px) scale(1.02);
                box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            }
            .menu-card h2 {
                margin-bottom: 15px;
                font-size: 28px;
                position: relative;
                z-index: 1;
            }
            .menu-card p {
                font-size: 15px;
                opacity: 0.95;
                position: relative;
                z-index: 1;
            }
            .produtos { 
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            }
            .fornecedores { 
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            }
            .clientes { 
                background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            }
            .vendas { 
                background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            }
            .footer {
                text-align: center;
                margin-top: 40px;
                padding-top: 20px;
                border-top: 2px solid #e0e0e0;
                color: #999;
                font-size: 12px;
            }
        </style>
        <script>
            // Prevenir voltar após logout
            (function() {
                // Prevenir cache
                if (window.history.replaceState) {
                    window.history.replaceState(null, null, window.location.href);
                }
                
                // Prevenir voltar
                window.history.pushState(null, null, location.href);
                window.onpopstate = function () {
                    window.history.pushState(null, null, location.href);
                    // Redirecionar para login se tentar voltar
                    window.location.href = '<%= request.getContextPath() %>/login.html';
                };
                
                // Prevenir cache ao carregar página do cache
                window.addEventListener('pageshow', function(event) {
                    if (event.persisted) {
                        window.location.reload();
                    }
                });
            })();
        </script>
    </head>
    <body>
        <div style="max-width: 1200px; margin: 0 auto;">
            <div class="header">
                <div>
                    <div class="user-name">Olá, <%= nomeFuncionario != null ? nomeFuncionario : "Usuário" %>!</div>
                </div>
                <div class="user-info">
                    <div class="user-badge">
                        <%= isAdmin != null && isAdmin ? "ADMIN" : "FUNCIONARIO" %>
                    </div>
                    <a href="<%= request.getContextPath() %>/logout.jsp" class="btn-logout">Sair</a>
                </div>
            </div>
            
            <div class="container">
                <h1>Mercadinho do Felipe</h1>
                <p class="subtitle">Sistema de Gerenciamento Completo</p>
                <div class="menu-grid">
                    <a href="produtos/index.jsp" class="menu-card produtos">
                        <h2>Produtos</h2>
                        <p>Gerenciar produtos do estoque</p>
                    </a>
                    <a href="fornecedores/index.jsp" class="menu-card fornecedores">
                        <h2>Fornecedores</h2>
                        <p>Gerenciar fornecedores</p>
                    </a>
                    <a href="clientes/index.jsp" class="menu-card clientes">
                        <h2>Clientes</h2>
                        <p>Gerenciar clientes</p>
                    </a>
                    <a href="vendas/index.jsp" class="menu-card vendas">
                        <h2>Vendas</h2>
                        <p>Gerenciar vendas realizadas</p>
                    </a>
                </div>
                
                <div class="footer">
                    <p>Desenvolvido por: Felipe Soeiro Lopes, Giovanna de Paula Lopes Santos,<br>
                    Kauã da Silveira Nascimento Machado, Victor Guimarães Felipe</p>
                </div>
            </div>
        </div>
    </body>
</html>

