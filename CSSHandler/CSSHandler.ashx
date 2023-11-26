<%@ WebHandler Language="C#" Class="CSSHandler" %>

using System;
using System.Web;
using System.Configuration;

public class CSSHandler : IHttpHandler 
{
    public void ProcessRequest (HttpContext context) 
    {
        context.Response.ContentType = "text/css";

        // Get the file from the query stirng
        string File = context.Request.QueryString["file"];
        
        // Find the actual path
        string Path = context.Server.MapPath(File);

        // Limit to only css files
        if(System.IO.Path.GetExtension(Path) != ".css")
            context.Response.End();
        
        // Make sure file exists
        if(!System.IO.File.Exists(Path))
            context.Response.End();
        
        // Open the file, read the contents and replace the variables
        using( System.IO.StreamReader css =  new System.IO.StreamReader(Path) )
        {
            string CSS = css.ReadToEnd();
            CSS = CSS.Replace("#BG_COLOR#", ConfigurationManager.AppSettings["BGColor"]);
            context.Response.Write(CSS);
        }
    }
 
    public bool IsReusable 
    {
        get 
        {
            return false;
        }
    }

}