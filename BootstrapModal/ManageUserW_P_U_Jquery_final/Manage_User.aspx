<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" EnableEventValidation="false" AutoEventWireup="true" ValidateRequest="false" CodeFile="Manage_User.aspx.cs" Inherits="Paid_User" %>

<%---- =============================================
-- Author:		<Manish Kumar,Prashant Kumar>
-- Create date: <5/9/2017>
-- Description:	<Here Admin can update the status of user as ACTIVE and INACTIVE.For that purpose OnRowUpdating(after editing the required field,these can be updated), OnRowEditing( for edit status,pricing plan, Data count and Export data), and OnRowCanceling(press cancel button if don't want to update) control events have been used>
//--                With OnPageIndexing control events we can move to all different records of user one by one. 
-- =============================================--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .modal-content {
            top: 100px;
        }

        .fade-scale {
            transform: scale(0);
            opacity: 0;
            -webkit-transition: all .25s linear;
            -o-transition: all .25s linear;
            transition: all .25s linear;
        }

            .fade-scale.in {
                opacity: 1;
                transform: scale(1);
            }

        .bst-block {
            padding: 0px;
        }

        .pagination-ys {
            /*display: inline-block;*/
            padding-left: 0;
            margin: 20px 0;
            border-radius: 4px;
        }

            .pagination-ys table > tbody > tr > td {
                display: inline;
            }

                .pagination-ys table > tbody > tr > td > a,
                .pagination-ys table > tbody > tr > td > span {
                    position: relative;
                    float: left;
                    padding: 8px 12px;
                    line-height: 1.42857143;
                    text-decoration: none;
                    color: #dd4814;
                    background-color: #ffffff;
                    border: 1px solid #dddddd;
                    margin-left: -1px;
                }

                .pagination-ys table > tbody > tr > td > span {
                    position: relative;
                    float: left;
                    padding: 8px 12px;
                    line-height: 1.42857143;
                    text-decoration: none;
                    margin-left: -1px;
                    z-index: 2;
                    color: #aea79f;
                    background-color: #f5f5f5;
                    border-color: #dddddd;
                    cursor: default;
                }

                .pagination-ys table > tbody > tr > td:first-child > a,
                .pagination-ys table > tbody > tr > td:first-child > span {
                    margin-left: 0;
                    border-bottom-left-radius: 4px;
                    border-top-left-radius: 4px;
                }

                .pagination-ys table > tbody > tr > td:last-child > a,
                .pagination-ys table > tbody > tr > td:last-child > span {
                    border-bottom-right-radius: 4px;
                    border-top-right-radius: 4px;
                }

                .pagination-ys table > tbody > tr > td > a:hover,
                .pagination-ys table > tbody > tr > td > span:hover,
                .pagination-ys table > tbody > tr > td > a:focus,
                .pagination-ys table > tbody > tr > td > span:focus {
                    color: #97310e;
                    background-color: #eeeeee;
                    border-color: #dddddd;
                }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bst-full-block bgColor">
        <h1>User Details</h1>
        <div class="table-responsive">
            <asp:UpdatePanel ID="updpanel_user" UpdateMode="Always" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gv_User_Mgt" runat="server" AutoGenerateColumns="false" DataKeyNames="UserId" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                        HeaderStyle-Font-Bold="true" CssClass="datagrid " HeaderStyle-CssClass="thead" RowStyle-CssClass="td" FooterStyle-CssClass="tfoot" AllowPaging="true" PageSize="8"
                        OnPageIndexChanging="gv_User_Mgt_PageIndexChanging" OnRowCancelingEdit="gv_User_Mgt_RowCancelingEdit" OnRowEditing="gv_User_Mgt_RowEditing" OnRowUpdating="gv_User_Mgt_RowUpdating" OnRowCommand="gv_User_Mgt_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="User Id">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_user_id" runat="server" Text='<%#Eval("UserId") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="User Name">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_user_name" runat="server" Text='<%#Eval("User_Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email Id">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Email_Id" runat="server" Text='<%#Eval("Email_Id") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Status" runat="server" Text='<%#Eval("Status") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_Status" runat="server" Text='<%#Eval("Status") %>' Visible="false"></asp:Label>
                                    <asp:DropDownList ID="dll_Status" runat="server" AppendDataBoundItems="True" SelectedValue='<%# Eval("Status") %>'>
                                        <%--<asp:ListItem Text="" Value="0"  ></asp:ListItem>--%>
                                        <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                        <asp:ListItem Text="InActive" Value="InActive"></asp:ListItem>
                                        <asp:ListItem Text="UnAuthorised" Value="UnAuthorised"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pricing Plan">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Pricing_Plan" runat="server" Text='<%#Eval("Pricing_Plan") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_Pricing_Plan" runat="server" Text='<%#Eval("Pricing_Plan") %>' Visible="false"></asp:Label>
                                    <asp:DropDownList ID="dll_Pricing_Plan" runat="server" AppendDataBoundItems="True" SelectedValue='<%# Eval("Pricing_Plan") %>'>
                                        <%-- <asp:ListItem Text="" Value="0"  ></asp:ListItem>--%>
                                        <asp:ListItem Text="Free" Value="Free"></asp:ListItem>
                                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Date" runat="server" Text='<%#Eval("Date","{0:D}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Location">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_location" runat="server" Text='<%#Eval("location") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Export Count">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Export_cnt" runat="server" Text='<%#Eval("Export_cnt") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_Export_cnt" runat="server" Text='<%# Eval("Export_cnt") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Data Count">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_data_count" runat="server" Text='<%# Eval("d_count") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_data_count" runat="server" Text='<%# Eval("d_count") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <%--   <asp:ButtonField CommandName="EditGv" ButtonType="Image" ImageUrl="~/assets/img/edit.jpg" HeaderText="Edit"  ControlStyle-Width="25px" ControlStyle-Height="30px"/>--%>
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/assets/img/edit.png"  Style="width: 24px; height: 24px" ToolTip="Edit"
                                        CommandName="EditGv" CommandArgument='<%#Eval("UserId") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                        <PagerStyle CssClass="pagination-ys" />
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <%--<asp:AsyncPostBackTrigger ControlID="gv_User_Mgt" />--%>
                </Triggers>
            </asp:UpdatePanel>
            <div class="container">
                <h2>Edit User Details</h2>
                <!-- Trigger the modal with a button -->
                <%--<button type="button" class="btn btn-info btn-lg" >Open Small Modal</button>--%>

                <!-- Edit Modal Starts here -->
                <asp:UpdatePanel ID="up_edit" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <div class="modal fade-scale" id="myModal" role="dialog">
                            <div class="modal-dialog modal-sm">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Edit User Details:
                                            <asp:Label runat="server" ID="lbl_BSMUser" style="color:#1ebc9c" ></asp:Label></h4>
                                    </div>

                                    <div class="modal-body" >
                                         
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" Text="Status"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="dll_Status_up" runat="server"   CssClass="form-control">                                                      
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" Text="Pricing Plan"></asp:Label>
                                                </td>
                                                <td>
                                                   <asp:DropDownList ID="dll_Pricing_Plan_up" runat="server"  CssClass="form-control">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" Text="Export Count"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_expcnt" runat="server" CssClass="form-control"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" Text="Data Count"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_dtcnt" runat="server" CssClass="form-control"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <div class="text-center">
                                            <input type="button" class="btn uploadExcelBtn center"  value="Update" onclick="Update_Details()">
                                    <%--    <asp:LinkButton ID="lnk_edit" runat="server" Text="Update"  CssClass="btn btn-success center" ></asp:LinkButton>--%>

                                        <button type="button" class="btn uploadExcelBtn center" data-dismiss="modal">Cancel</button>
                                            </div>
                                    </div>



                                </div>
                            </div>
                        </div>
                    </ContentTemplate>

                </asp:UpdatePanel>
                <!-- Edit Modal Ends here -->
            </div>
        </div>
    </div>

<script type = "text/javascript">
    function Update_Details() {
        
        var dll_Pricing_Plan_up = $('#<%= dll_Pricing_Plan_up.ClientID %>').val();
        var dll_Status_up = $('#<%= dll_Status_up.ClientID %>').val();            
       
    $.ajax({
        type: "POST",
        url: "/Super_Admin/Manage_User.aspx/GetUpdateDetails",
        data: '{excpt_cnt: "' + $("#<%=txt_expcnt.ClientID%>")[0].value + '" ,dta_cnt: "' + $("#<%=txt_dtcnt.ClientID%>")[0].value + '",pricing: "' + dll_Pricing_Plan_up + '" ,stat: "' + dll_Status_up + '" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        failure: function(response) {
        }
    });
}
function OnSuccess(response) {
    alert("Updated Successfully");
    $('#myModal').modal('hide');
}
</script>
</asp:Content>

