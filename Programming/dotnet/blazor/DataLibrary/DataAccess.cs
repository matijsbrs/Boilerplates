using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using Dapper;
using MySql.Data.MySqlClient;

namespace DataLibrary;

public interface IDataAccess
{
    Task<List<U>> LoadData<U, T>(string sql, T parameters, string connectionString);
    Task SaveData<T>(string sql, T parameters, string connectionString);
}

public class DataAccess : IDataAccess
{

    public async Task<List<U>> LoadData<U, T>(string sql, T parameters, string connectionString)
    {
        using (IDbConnection connection = new MySqlConnection(connectionString))
        {
            var rows = await connection.QueryAsync<U>(sql, parameters);

            return rows.ToList();
        }
    }

    public Task SaveData<T>(string sql, T parameters, string connectionString)
    {
        using (IDbConnection connection = new MySqlConnection(connectionString))
        {
            return connection.ExecuteAsync(sql, parameters);
        }
    }

}
