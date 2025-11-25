<%-- 
    Document   : Login
    Mercadinho do Felipe
    Java 24
    Desenvolvedores:
    - Felipe Soeiro Lopes
    - Giovanna de Paula Lopes Santos
    - Kauã da Silveira Nascimento Machado
    - Victor Guimarães Felipe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Funcionario"%>
<%@page import="model.DAO.FuncionarioDAO"%>

<%
    // Adicionar headers para prevenir cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Proxies
    
    // Se já estiver logado, invalidar sessão anterior
    if (session.getAttribute("funcionarioLogado") != null) {
        session.invalidate();
        session = request.getSession(true);
    }
    
    String login = request.getParameter("login");
    String senha = request.getParameter("senha");
    
    if (login != null && senha != null && !login.isEmpty() && !senha.isEmpty()) {
        try {
            FuncionarioDAO funcDAO = new FuncionarioDAO();
            Funcionario func = funcDAO.autenticar(login, senha);
            
            if (func != null) {
                // Criar sessão
                session.setAttribute("funcionarioLogado", func);
                session.setAttribute("nomeFuncionario", func.getNome());
                session.setAttribute("tipoAcesso", func.getTipoAcesso());
                session.setAttribute("isAdmin", func.isAdmin());
                
                // Redirecionar para página principal
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                // Credenciais inválidas
                response.sendRedirect(request.getContextPath() + "/login.html?error=1");
            }
        } catch (ClassNotFoundException ex) {
            // Log de erro seria feito no servidor
            response.sendRedirect(request.getContextPath() + "/login.html?error=1");
        } catch (Exception ex) {
            // Log de erro seria feito no servidor
            response.sendRedirect(request.getContextPath() + "/login.html?error=1");
        }
    } else {
        response.sendRedirect(request.getContextPath() + "/login.html?error=1");
    }
%>

