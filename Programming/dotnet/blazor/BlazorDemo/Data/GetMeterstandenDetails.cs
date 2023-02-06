using BlazorDemo.Models;
using BlazorDemo.Shared.Models;
using MySqlConnector;
using System.Data;

namespace BlazorDemo.Data {
    public class meterstandenConnections {

        public async Task < Meterstanden[] > GetMeterstandensAsync() {
            List < Meterstanden > list = new List < Meterstanden > ();
            using(MySqlConnection conn = MySql_Helper.GetConnection()) {
                conn.Open();
                using(MySqlCommand cmd = new MySqlCommand("select * from Meterstanden", conn)) {
                    using(MySqlDataReader reader = cmd.ExecuteReader()) {
                        while (reader.Read()) {
                            list.Add(new Meterstanden() {
                                    TimeStamp = reader.GetDateTime("TimeStamp"),
                                    KWh1 = reader.GetInt32("KWh1"),
                                    KWh2 = reader.GetInt32("KWh2"),
                                    m3gas = reader.GetInt32("m3gas")
                                    
                            });
                        }
                    }
                }
            }
            return list.ToArray();
        }
    }
}