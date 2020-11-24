package tm.pojo;

public class Manager {
    public static final String MANAGER_NAME = "admin309273719";
    public static final String MANAGER_PASSWORD = "ADMIN309273719";
    private String managerName = MANAGER_NAME;
    private String managerPassword = MANAGER_PASSWORD;

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerPassword() {
        return managerPassword;
    }

    public void setManagerPassword(String managerPassword) {
        this.managerPassword = managerPassword;
    }

    public Manager() {
    }

    public Manager(String managerName, String managerPassword) {
        this.managerName = managerName;
        this.managerPassword = managerPassword;
    }

    @Override
    public String toString() {
        return "Manager{" +
                "managerName='" + managerName + '\'' +
                ", managerPassword='" + managerPassword + '\'' +
                '}';
    }
}
