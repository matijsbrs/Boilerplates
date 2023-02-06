using MySqlConnector;

namespace BlazorDemo.Models {
    public class MySql_Helper {
        //this field gets initialized at Startup.cs
        public static string conStr;
        public static MySqlConnection GetConnection() {
            try {
                MySqlConnection connection = new MySqlConnection(conStr);
                return connection;
            } catch (Exception e) {
                Console.WriteLine(e);
                throw;
            }
        }
    }
}