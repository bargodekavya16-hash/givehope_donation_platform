# GiveHope Donation Platform — setup for Windows, Maven, MySQL and Tomcat 11

This is a demo/student project. Donations are **recorded as demo entries only**. It does not charge money or collect card details.

## Files included
- `pom.xml`: Maven WAR project, Java 17, Jakarta Servlet 6.1, MySQL Connector/J.
- `src/main/java/com/donation/`: donation, database and admin servlet code.
- `src/main/webapp/index.jsp`: homepage and donation form.
- `src/main/webapp/admin-login.jsp`: admin login page.
- `src/main/webapp/admin.jsp`: admin dashboard.
- `src/main/webapp/success.jsp`: demo receipt.
- `database/donation_db.sql`: database schema.

## 1. Back up your existing project
Copy your current `donation-platform` folder somewhere safe before replacing any files. Merge these files into the existing project; do not delete unrelated files you need.

## 2. Start MySQL and create the database
Use MySQL Workbench or the MySQL command line to run `database/donation_db.sql`.
The database must be created before the app connects. The app creates the `donations` table if it is missing.

Default local settings in `DBUtil.java`:
- URL: `jdbc:mysql://localhost:3306/donation_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC`
- user: `root`
- password: "kavya@40%"

If your MySQL root account has a password, set these environment variables in the same PowerShell terminal before starting Tomcat:
```powershell
$env:DB_URL = "jdbc:mysql://localhost:3306/donation_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
$env:DB_USER = "root"
$env:DB_PASSWORD = "YOUR_MYSQL_PASSWORD"
$env:ADMIN_PASSWORD = "choose-a-local-demo-password"
```
Use your real local database username/password. Do not commit passwords to a public repository.

## 3. Merge/replace the project files
Copy the provided `pom.xml` to the project root, and merge the `src` folder with your existing `src` folder. Keep any other Java files you already have. If you already have a custom `pom.xml`, back it up and compare dependencies before replacing it.

## 4. Build the WAR
In VS Code, open the project root (the folder containing `pom.xml`) and run:
```powershell
mvn clean package
```
Wait for `BUILD SUCCESS`. The output should be `target\donation-platform.war`.

## 5. Deploy to Tomcat 11
Set the paths for the current PowerShell terminal (edit the JDK path if yours differs):
```powershell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.0.20.101-hotspot"
$env:CATALINA_HOME = "C:\Users\sanke\Downloads\apache-tomcat-11.0.27-windows-x64\apache-tomcat-11.0.27"
$env:CATALINA_BASE = $env:CATALINA_HOME
```
Check the Java path:
```powershell
& "$env:JAVA_HOME\bin\java.exe" -version
```
Copy the WAR:
```powershell
Copy-Item ".\target\donation-platform.war" "$env:CATALINA_HOME\webapps\donation-platform.war" -Force
```
If Tomcat is already running, stop it from its Tomcat window or run:
```powershell
& "$env:CATALINA_HOME\bin\shutdown.bat"
```
Wait several seconds, then start:
```powershell
& "$env:CATALINA_HOME\bin\startup.bat"
```
If `startup.bat` opens a separate window, leave it running.

## 6. Open the site
- Home and donation form: `http://localhost:8080/donation-platform/`
- Admin login: `http://localhost:8080/donation-platform/admin-login.jsp`
- Local demo admin password defaults to `admin123` unless `ADMIN_PASSWORD` is set before Tomcat starts.

Submit a demo donation, then log in to Admin and verify it appears in the table.

## Troubleshooting
- **HTTP 404**: check that `target\donation-platform.war` exists and Tomcat has extracted `webapps\donation-platform\`. Check Tomcat logs under `logs`.
- **Database connection error**: make sure MySQL is running, the database exists, and `DB_USER`/`DB_PASSWORD` are correct. Environment variables must be set in the terminal/session that launches Tomcat.
- **`JAVA_HOME` not defined**: set it in the same PowerShell terminal before `startup.bat`.
- **Tomcat starts but page is old**: stop Tomcat, remove the exploded `webapps\donation-platform` directory and old WAR only after confirming no needed files are inside; then copy the new WAR and start Tomcat.
- **Do not use this demo admin login in a public deployment**. For a real system, add CSRF protection, stronger authentication, HTTPS, database least-privilege credentials, and a real payment provider integration.
