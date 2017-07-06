//<%---- =============================================
//-- Author:		<Manish Kumar, Prashant Kumar>
//-- Create date:   <5/9/2017>
//-- Description:	<Here Admin can update the status of user as ACTIVE and INACTIVE.For that purpose OnRowUpdating(after editing the required field,these can be updated), OnRowEditing( for edit status,pricing plan, Data count and Export data), and OnRowCanceling(press cancel button if don't want to update) control events have been used>
//--                With OnPageIndexing control events we can move to all different records of user one by one. 
//-- =============================================--%>

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class Paid_User : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            FillGrid();
        }

        Label lblMasterStatus = (Label)Master.FindControl("lblcurrentpage");
        lblMasterStatus.Text = "User Details";
    }
    protected void FillGrid()
    {
        try
        {
            using (con)
            {
                using (SqlCommand cmd = new SqlCommand("sp_admin_user_details", con))
                {
                    cmd.Parameters.AddWithValue("@Action", "SELECT");
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            con.Open();
                            sda.Fill(dt);
                            gv_User_Mgt.DataSource = dt;
                            gv_User_Mgt.DataBind();
                        }
                        con.Close();
                    }
                }
            }

        }
        catch (Exception ex)
        {

        }
    }
            
    protected void gv_User_Mgt_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        FillGrid();
        gv_User_Mgt.PageIndex = e.NewPageIndex;
        gv_User_Mgt.DataBind();
    }

    protected void gv_User_Mgt_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gv_User_Mgt.EditIndex = -1;
        FillGrid();
    }

    protected void gv_User_Mgt_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gv_User_Mgt.EditIndex = e.NewEditIndex;
        FillGrid();        
    }

    protected void gv_User_Mgt_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
           
            Label id_user = gv_User_Mgt.Rows[e.RowIndex].FindControl("lbl_user_id") as Label;
           
            int id = Convert.ToInt32(id_user.Text);

            Label price_plan = gv_User_Mgt.Rows[e.RowIndex].FindControl("lbl_Pricing_Plan") as Label;
           
            string price = (gv_User_Mgt.Rows[e.RowIndex].FindControl("dll_Pricing_Plan") as DropDownList).SelectedItem.Value;
            
            //    string price  = (gv_User_Mgt.Rows[e.RowIndex].FindControl("dll_Pricing_Plan") as DropDownList).SelectedItem.Value;
            //if(price != null)
            //{
            //    DropDownList dll_Pricing_Plan_v = gv_User_Mgt.Rows[e.RowIndex].FindControl("dll_Pricing_Plan") as DropDownList;
            //    dll_Pricing_Plan_v.SelectedItem.Value = price;
            //}
            if (price == "")
            { 
                price = price_plan.Text;              
            }           
            TextBox export_data = gv_User_Mgt.Rows[e.RowIndex].FindControl("txt_Export_cnt") as TextBox;
            int export = Convert.ToInt32(export_data.Text);
            TextBox data_count = gv_User_Mgt.Rows[e.RowIndex].FindControl("txt_data_count") as TextBox;
            int data_cnt = Convert.ToInt32(data_count.Text);            
            Label user_status = gv_User_Mgt.Rows[e.RowIndex].FindControl("lbl_Status") as Label;
            string status = (gv_User_Mgt.Rows[e.RowIndex].FindControl("dll_Status") as DropDownList).SelectedItem.Value;
            if (status == "")
            {
                status = user_status.Text;
            }
            
            SqlCommand cmd = new SqlCommand("SP_Admin_User_Details", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Action", "UPDATE");
            cmd.Parameters.AddWithValue("@Pricing", price);
            cmd.Parameters.AddWithValue("@ExportCount", export);
            cmd.Parameters.AddWithValue("@Dcount", data_cnt);
            cmd.Parameters.AddWithValue("@Id", id);
            cmd.Parameters.AddWithValue("@Status", status);     
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();



            gv_User_Mgt.EditIndex = -1;
            FillGrid();
        }
        catch( Exception ex)
        {
            //throw ex;
        }
    }




    protected void gv_User_Mgt_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int selected_id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName.Equals("EditGv"))
            {

                //GridViewRow gvrow = gv_User_Mgt.Rows[rowindex(index)];

                SqlCommand cmd = new SqlCommand("SP_Admin_User_Details", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "SELECT_ONE");
                cmd.Parameters.AddWithValue("@Id", selected_id);
                DataTable dt = new DataTable();
                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                adpt.Fill(dt);


                //string Pricing_Plan = Convert.ToString(dt.Rows[0]["Pricing_Plan"].ToString());
                //string Status= Convert.ToString(dt.Rows[0]["Status"].ToString());

                //dll_Pricing_Plan_up.SelectedValue = Pricing_Plan;
                //dll_Status_up.SelectedValue = Status;

                lbl_BSMUser.Text = Convert.ToString(dt.Rows[0]["Email_Id"].ToString());
                txt_expcnt.Text = Convert.ToString(dt.Rows[0]["Export_cnt"].ToString());
                txt_dtcnt.Text = Convert.ToString(dt.Rows[0]["d_count"].ToString());

                HttpContext.Current.Session["id"] = Convert.ToString(selected_id);


                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#myModal').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditModalScript", sb.ToString(), false);
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
       
    }

   

    //private void executeUpdate(string status, string price, string export, string data_cnt)
    //{
    //    SqlCommand cmd = new SqlCommand("SP_Admin_User_Details", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.AddWithValue("@Action", "UPDATE");
    //    cmd.Parameters.AddWithValue("@Pricing", price);
    //    cmd.Parameters.AddWithValue("@ExportCount", export);
    //    cmd.Parameters.AddWithValue("@Dcount", data_cnt);
    //    cmd.Parameters.AddWithValue("@Id", id);
    //    cmd.Parameters.AddWithValue("@Status", status);
    //    con.Open();
    //    cmd.ExecuteNonQuery();
    //    con.Close();
    //}

    //protected void lnk_edit_Click(object sender, EventArgs e)
    //{
    //    if (Convert.ToString(HttpContext.Current.Session["id"]) != "")
    //    {
    //        string id = Convert.ToString(HttpContext.Current.Session["id"]);
    //        string price = dll_Pricing_Plan_up.SelectedItem.Text;
    //        string status = dll_Status_up.SelectedItem.Text;
    //        string export = txt_expcnt.Text;
    //        string data_cnt = txt_dtcnt.Text;
    //        SqlCommand cmd = new SqlCommand("SP_Admin_User_Details", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@Action", "UPDATE");
    //        cmd.Parameters.AddWithValue("@Pricing", price);
    //        cmd.Parameters.AddWithValue("@ExportCount", export);
    //        cmd.Parameters.AddWithValue("@Dcount", data_cnt);
    //        cmd.Parameters.AddWithValue("@Id", id);
    //        cmd.Parameters.AddWithValue("@Status", status);
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        con.Close();
    //        System.Text.StringBuilder sb = new System.Text.StringBuilder();
    //        sb.Append(@"<script type='text/javascript'>");
    //        sb.Append("alert('Records Updated Successfully');");
    //        sb.Append("$('#myModal').modal('hide');");
    //        sb.Append(@"</script>");
    //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);
    //        FillGrid();
    //    }
    //    else
    //    {

    //    }
    //}


    [System.Web.Services.WebMethod]
    public static string GetUpdateDetails(string excpt_cnt,string dta_cnt,string pricing,string stat)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conString"].ConnectionString);
 
        string id = Convert.ToString(HttpContext.Current.Session["id"]);
        string price = pricing;
        string status = stat;
        string export = excpt_cnt;
        string data_cnt = dta_cnt;
        SqlCommand cmd = new SqlCommand("SP_Admin_User_Details", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Action", "UPDATE");
        cmd.Parameters.AddWithValue("@Pricing", price);
        cmd.Parameters.AddWithValue("@ExportCount", export);
        cmd.Parameters.AddWithValue("@Dcount", data_cnt);
        cmd.Parameters.AddWithValue("@Id", id);
        cmd.Parameters.AddWithValue("@Status", status);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        
        return "sa";
    }
}