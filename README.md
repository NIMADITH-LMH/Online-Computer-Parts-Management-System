# Online Computer Parts Management System

## Project Overview
This is a Java-based web application designed to streamline the management of computer parts for both customers and sellers. The system provides a user-friendly platform for administrators to manage accounts, sellers to showcase products, and customers to browse and purchase computer parts seamlessly.

## Features

### User Management
- Customer and seller registration and login
- Profile management
- Role-based access control (Admin, Seller, Customer)

### Product Management
- Add, update, and delete products
- Product categorization
- Product search and filtering
- Product details with images and descriptions

### Shopping Experience
- Shopping cart functionality
- Order processing
- Payment processing
- Order history

### Admin Functionalities
- User management (add, delete, convert user types)
- Dashboard with analytics
- Product oversight
- Order monitoring

### Seller Functionalities
- Product inventory management
- Order fulfillment
- Sales reports

## Technology Stack
- **Frontend**: JSP, HTML, CSS, JavaScript
- **Backend**: Java Servlets, JDBC
- **Database**: MySQL
- **Server**: Apache Tomcat 11.0.4
- **Build Tool**: Maven/Ant

## Database Schema
The application uses a MySQL database with the following main tables:
- `user`: Stores user information (customers, sellers, admins)
- `product`: Contains product details including price, quantity, description
- `cart`: Manages shopping cart items for users
- `orders`: Tracks order information and status

## Project Structure
```
onlinespareparts_v2/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── Admin/         # Admin-related functionality
│   │   │   ├── homeServlat/   # Home page servlets
│   │   │   ├── JDBCConnection/ # Database connection handling
│   │   │   ├── orderproduct/  # Order processing
│   │   │   ├── Seller/        # Seller functionality
│   │   │   ├── suggestion/    # Product suggestion features
│   │   │   └── userServlat/   # User management servlets
│   │   └── webapp/
│   │       ├── css/           # Stylesheets
│   │       ├── js/            # JavaScript files
│   │       ├── image/         # Image resources
│   │       ├── WEB-INF/       # Web configuration
│   │       └── *.jsp          # JSP views
├── db_scripts/                # Database setup scripts
├── lib/                       # External libraries
├── build.xml                  # Ant build script
└── pom.xml                    # Maven configuration
```

## Installation and Setup

### Prerequisites
- JDK 17 or higher
- Apache Tomcat 11.0.4
- MySQL Server
- Maven or Ant (for building)

### Database Setup
1. Create a MySQL database using the provided SQL script:
   ```
   mysql -u username -p < database_setup.sql
   ```

### Configuration
1. Update database connection settings in the JDBCConnection class

### Deployment
1. Build the project using Maven:
   ```
   mvn clean package
   ```
   or using Ant:
   ```
   ant build
   ```
2. Deploy the resulting WAR file to Tomcat:
   - Copy the WAR file to Tomcat's `webapps` directory
   - Start Tomcat server

### Running the Application
1. Start the Tomcat server:
   ```
   cd apache-tomcat-11.0.4/bin
   startup.bat
   ```
2. Access the application in a browser:
   ```
   http://localhost:8080/onlinespareparts_v2/
   ```

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## Contact
For questions or feedback, please reach out to the project maintainers.
