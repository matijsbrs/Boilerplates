using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace BlazorDemo.Models
{
    public class Meterstanden
    {
        public DateTime TimeStamp { get; set; }
        public int KWh1 { get; set; }
        public int KWh2 { get; set; }
        public int m3gas { get; set; }
                // public string Emailid { get; set; } = null!;
        public int KWhSum {
            get {
                return KWh1 + KWh2;
            }
        }
    }
}