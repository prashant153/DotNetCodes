<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="Manage_User.aspx.cs" Inherits="Paid_User" %>

<%---- =============================================
-- Author:		<Manish Kumar,Prashant Kumar>
-- Create date: <5/9/2017>
-- Description:	<Here Admin can update the status of user as ACTIVE and INACTIVE.For that purpose OnRowUpdating(after editing the required field,these can be updated), OnRowEditing( for edit status,pricing plan, Data count and Export data), and OnRowCanceling(press cancel button if don't want to update) control events have been used>
//--                With OnPageIndexing control events we can move to all different records of user one by one. 
-- =============================================--%>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
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
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>  --%>
    <div class="bst-full-block bgColor">
        <h1>User Details</h1>
        <div class="table-responsive">
            <asp:UpdatePanel ID="updpanel_user" UpdateMode="Always" runat="server">
                <ContentTemplate>

                    <asp:GridView ID="gv_User_Mgt" runat="server" AutoGenerateColumns="false" DataKeyNames="UserId" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                        HeaderStyle-Font-Bold="true" CssClass="datagrid " HeaderStyle-CssClass="thead" RowStyle-CssClass="td" FooterStyle-CssClass="tfoot" AllowPaging="true" PageSize="8"
                        OnPageIndexChanging="gv_User_Mgt_PageIndexChanging" OnRowCancelingEdit="gv_User_Mgt_RowCancelingEdit" OnRowEditing="gv_User_Mgt_RowEditing" OnRowUpdating="gv_User_Mgt_RowUpdating">
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
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" ToolTip="Edit" CommandName="Edit" />--%>
                                    <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/assets/img/edit.jpg" Style="width: 50%; height: 7%" ToolTip="Edit" CommandName="Edit" />
                                </ItemTemplate>
                                <%--<EditItemTemplate>
                           <asp:Button ID="btnUpdate" runat="server" Text="Update" ToolTip="Update" CommandName="Update" />
                           <asp:Button ID="btnCancel" runat="server" Text="Cancel" ToolTip="Cancel" CommandName="Cancel" />
                       </EditItemTemplate>--%>
                            </asp:TemplateField>
                        </Columns>

                        <PagerStyle CssClass="pagination-ys" />
                    </asp:GridView>
                    <%--<asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" style = "display:none">
<asp:Label Font-Bold = "true" ID = "Label4" runat = "server" Text = "Customer Details" ></asp:Label>
<br />
<table align = "center">
<tr>
<td>
<asp:Label ID = "Label1" runat = "server" Text = "CustomerId" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtCustomerID" Width = "40px" MaxLength = "5" runat="server"></asp:TextBox>
</td>
</tr>
<tr>
<td>
<asp:Label ID = "Label2" runat = "server" Text = "Contact Name" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtContactName" runat="server"></asp:TextBox>   
</td>
</tr>
<tr>
<td>
<asp:Label ID = "Label3" runat = "server" Text = "Company" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>
</td>
</tr>
<tr>
<td>
<asp:Button ID="btnSave" runat="server" Text="Save"/>
</td>
<td>
<asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick = "return Hidepopup()"/>
</td>
</tr>
</table>
</asp:Panel>--%>
                    <%--<asp:Image ID="lnkFake" runat="server"></asp:Image>--%>
                    <%--<asp:ImageButton ID="lnkFake" runat="server" ImageUrl="~/assets/img/edit.jpg" />--%>
                    <%--<cc1:ModalPopupExtender ID="popup" runat="server" DropShadow="false"
PopupControlID="pnlAddEdit" TargetControlID = "lnkFake"
BackgroundCssClass="modalBackground">
</cc1:ModalPopupExtender>--%>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="gv_User_Mgt" />
<%--                    <asp:AsyncPostBackTrigger ControlID="btnSave" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

