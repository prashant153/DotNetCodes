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


    
}