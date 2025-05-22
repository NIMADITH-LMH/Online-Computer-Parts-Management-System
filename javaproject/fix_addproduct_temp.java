echo class addproduct extends HttpServlet { 
echo     private static final long serialVersionUID = 1L; 
echo     private static final String imageDirectory = "%%USER_DIR%%/onlinespareparts_v2/src/main/webapp/image/"; 
echo     public addproduct() { 
echo         super(); 
echo         // Make sure image directory exists 
echo         File imgDir = new File(imageDirectory); 
echo         if (!imgDir.exists()) { 
echo             imgDir.mkdirs(); 
echo         } 
echo     } 
