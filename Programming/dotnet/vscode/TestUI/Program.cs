using System;
using Microsoft.Data.SqlClient;


namespace AzureSql_test_App 
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Program DbTest = new Program();

        }

        public Program()
        {
            Console.WriteLine("Starting program");
            var state = dbConnector();
            Console.WriteLine($"Ready {state}");
        }

        public string GetConnectionString()
        {
            return  $"Data Source={System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(Parameters.Data_Source))}; " +
                    $" Authentication=Active Directory Password; Encrypt=True;" +
                    $" Database={System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(Parameters.Database_Name))};" +
                    $" User Id={System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(Parameters.User_Id))};" +
                    $" Password={System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(Parameters.Password))}";
            
        }



        public int dbConnector() {

            SqlConnection dbConn = new SqlConnection(GetConnectionString());
             
            try
                {
                Console.WriteLine($"Opening connection");
                dbConn.Open();
                Console.WriteLine("Connection opened");
                }
                catch (Exception e)
                {
                    Console.WriteLine($"Error connecting {e}");
                return -1;
                }
            return 0;

            }
        }
    }

