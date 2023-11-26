using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;

namespace CustomHandler
{
    public class CSSHandler : System.Web.IHttpHandler
    {
        #region IHttpHandler Members

        public bool IsReusable
        {
            get { return false; }
        }

        public void ProcessRequest(System.Web.HttpContext context)
        {
            // Get the physical path of the file being processed
            string File = context.Request.PhysicalPath;

            // Open the file, read the contents and replace the variables
            using(System.IO.StreamReader reader = new System.IO.StreamReader(File))
            {
                string CSS = reader.ReadToEnd();
                CSS = CSS.Replace("#BG_COLOR#", ConfigurationManager.AppSettings["BGColor"]);
                context.Response.Write(CSS);
            }
        }

        #endregion
    }
}
