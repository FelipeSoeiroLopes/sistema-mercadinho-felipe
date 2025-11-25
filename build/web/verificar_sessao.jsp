<%-- 
    Document   : Verificar Sessão
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

<%
    // Adicionar headers para prevenir cache e voltar após logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Proxies
    response.setHeader("X-Frame-Options", "DENY");
    response.setHeader("X-Content-Type-Options", "nosniff");
    
    // Configurar encoding UTF-8 ANTES de qualquer processamento
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    // Verificar se o usuário está logado
    Funcionario funcionarioLogado = (Funcionario) session.getAttribute("funcionarioLogado");
    if (funcionarioLogado == null) {
        // Limpar qualquer cache antes de redirecionar
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        response.sendRedirect(request.getContextPath() + "/login.html");
        return;
    }
    
    // Variáveis úteis
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    String tipoAcesso = (String) session.getAttribute("tipoAcesso");
    String nomeFuncionario = (String) session.getAttribute("nomeFuncionario");
    
    if (isAdmin == null) {
        isAdmin = funcionarioLogado.isAdmin();
        session.setAttribute("isAdmin", isAdmin);
    }
    
    if (nomeFuncionario == null) {
        nomeFuncionario = funcionarioLogado.getNome();
        session.setAttribute("nomeFuncionario", nomeFuncionario);
    }
    
    if (tipoAcesso == null) {
        tipoAcesso = funcionarioLogado.getTipoAcesso();
        session.setAttribute("tipoAcesso", tipoAcesso);
    }
%>

