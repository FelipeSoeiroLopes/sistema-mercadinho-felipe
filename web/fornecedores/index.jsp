<%-- 
    Document   : CRUD Fornecedores
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

<!DOCTYPE html>
<html>
    <head>
        <title>CRUD Fornecedores - Mercadinho do Felipe</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                min-height: 100vh;
                padding: 20px;
            }
            .header-bar {
                background: white;
                padding: 15px 30px;
                border-radius: 15px;
                margin-bottom: 20px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }
            .user-badge {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                color: white;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
            }
            .btn-logout {
                background: #dc3545;
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
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
                color: #4facfe;
                text-align: center;
                margin-bottom: 10px;
                font-size: 38px;
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .subtitle {
                text-align: center;
                color: #666;
                margin-bottom: 40px;
                font-size: 16px;
            }
            .menu-links {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
            .menu-link {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                color: white;
                padding: 25px;
                border-radius: 15px;
                text-align: center;
                text-decoration: none;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: block;
                font-weight: 600;
                box-shadow: 0 5px 15px rgba(79, 172, 254, 0.3);
                position: relative;
                overflow: hidden;
            }
            .menu-link::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: rgba(255,255,255,0.2);
                transition: left 0.5s;
            }
            .menu-link:hover::before {
                left: 100%;
            }
            .menu-link:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(79, 172, 254, 0.5);
            }
            .menu-link.disabled {
                opacity: 0.5;
                cursor: not-allowed;
                pointer-events: none;
            }
            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                margin-top: 20px;
                color: #4facfe;
                text-decoration: none;
                font-weight: 600;
                padding: 10px 20px;
                background: #fff;
                border-radius: 8px;
                transition: all 0.3s;
            }
            .back-link:hover {
                background: #4facfe;
                color: white;
                transform: translateX(-5px);
            }
        </style>
    </head>
    <body>
        <div style="max-width: 1200px; margin: 0 auto;">
            <div class="header-bar">
                <div>
                    <span class="user-badge"><%= isAdmin != null && isAdmin ? "ADMIN" : "FUNCIONARIO" %></span>
                    <span style="margin-left: 15px; color: #333; font-weight: 600;"><%= nomeFuncionario != null ? nomeFuncionario : "Usuario" %></span>
                </div>
                <div>
                    <a href="<%= request.getContextPath() %>/logout.jsp" class="btn-logout">Sair</a>
                    <a href="<%= request.getContextPath() %>/index.jsp" style="margin-left: 10px; color: #4facfe; text-decoration: none; font-weight: 600;">&larr; Voltar</a>
                </div>
            </div>
            
            <div class="container">
                <h1>Gerenciamento de Fornecedores</h1>
                <p class="subtitle">Sistema completo de CRUD para fornecedores</p>
                <div class="menu-links">
                    <% if (isAdmin != null && isAdmin) { %>
                    <a href="forn_cad.html" class="menu-link">+ Cadastrar Fornecedor</a>
                    <% } else { %>
                    <span class="menu-link disabled">+ Cadastrar Fornecedor<br><small>(Apenas Admin)</small></span>
                    <% } %>
                    
                    <a href="forn_cons_geral.jsp" class="menu-link">Consultar Todos</a>
                    <a href="forn_cons_id.html" class="menu-link">Consultar por ID</a>
                    
                    <% if (isAdmin != null && isAdmin) { %>
                    <a href="forn_cons_id_alt.html" class="menu-link">Alterar Fornecedor</a>
                    <a href="forn_excluir_form.jsp" class="menu-link">Excluir Fornecedor</a>
                    <% } else { %>
                    <span class="menu-link disabled">Alterar Fornecedor<br><small>(Apenas Admin)</small></span>
                    <span class="menu-link disabled">Excluir Fornecedor<br><small>(Apenas Admin)</small></span>
                    <% } %>
                </div>
                <a href="<%= request.getContextPath() %>/index.jsp" class="back-link">&larr; Voltar ao Menu Principal</a>
            </div>
        </div>
        <script>
            // Prevenir voltar após logout
            (function() {
                if (window.history.replaceState) {
                    window.history.replaceState(null, null, window.location.href);
                }
                window.history.pushState(null, null, location.href);
                window.onpopstate = function () {
                    window.history.pushState(null, null, location.href);
                    window.location.href = '<%= request.getContextPath() %>/login.html';
                };
                window.addEventListener('pageshow', function(event) {
                    if (event.persisted) {
                        window.location.reload();
                    }
                });
            })();
        </script>
    </body>
</html>

