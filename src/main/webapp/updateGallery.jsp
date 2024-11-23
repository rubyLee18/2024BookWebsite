<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String id = null;
    String title = null;
    String content = null;
    String author = (String) session.getAttribute("username"); // 로그인한 사용자 닉네임
    String imagePath = null;

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 파일 업로드 경로 설정
        String uploadPath = application.getRealPath("/") + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Apache Commons FileUpload를 사용하여 multipart/form-data 파싱
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> formItems = upload.parseRequest(request);

        for (FileItem item : formItems) {
            if (item.isFormField()) {
                // 일반 폼 필드 처리
                if ("id".equals(item.getFieldName())) {
                    id = item.getString("UTF-8");
                } else if ("title".equals(item.getFieldName())) {
                    title = item.getString("UTF-8");
                } else if ("content".equals(item.getFieldName())) {
                    content = item.getString("UTF-8");
                }
            } else {
                // 파일 업로드 처리
                if (!item.getName().isEmpty()) {
                    String fileName = new File(item.getName()).getName();
                    String filePath = uploadPath + File.separator + fileName;
                    File storeFile = new File(filePath);
                    item.write(storeFile);
                    imagePath = "uploads/" + fileName;
                }
            }
        }

        if (id == null || id.isEmpty()) {
            out.println("<script>alert('잘못된 접근입니다. ID 값이 없습니다.'); history.back();</script>");
            return;
        }

        // 데이터베이스 연결 및 업데이트
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookcom?useUnicode=true&characterEncoding=utf8", "root", "1116");

        // 기존 이미지 경로 가져오기
        if (imagePath == null) {
            String sqlSelect = "SELECT image_path FROM pictures WHERE id = ?";
            pstmt = conn.prepareStatement(sqlSelect);
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                imagePath = rs.getString("image_path");
            }
            pstmt.close();
        }

        String sql = "UPDATE pictures SET title = ?, content = ?, image_path = ? WHERE id = ? AND author = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setString(3, imagePath);
        pstmt.setInt(4, Integer.parseInt(id));
        pstmt.setString(5, author);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.sendRedirect("gallerypost.jsp?id=" + id);
        } else {
            out.println("<script>alert('글 수정에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
