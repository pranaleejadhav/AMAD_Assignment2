package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import sun.net.www.http.HttpClient;

import org.apache.http.entity.StringEntity;

@WebServlet("/AdminAction")
public class AdminServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("inside get");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String action = req.getParameter("submit");
		System.out.println("action is" + action);
		HttpSession session = req.getSession(true);
		
		if(action.equals("signin")) {
			
			String email = (String) req.getParameter("emailaddress");
			String password = (String) req.getParameter("passwordvalue");
			JSONObject json = new JSONObject();
			json.put("username","nbattala");
			json.put("password", "123456");
			CloseableHttpClient httpClient = HttpClientBuilder.create().build();
			HttpPost request = new HttpPost("http://localhost:4000/login");
			HttpResponse response;
			try {	
			request.setHeader("Content-Type", "application/json");
		    StringEntity params =new StringEntity(json.toString());
     	    request.addHeader("Accept","application/json");
		    request.setEntity(params);
		    response= httpClient.execute(request);
		    String output = EntityUtils.toString(response.getEntity());
		    System.out.println("output is" + output);
		    final JSONObject obj = new JSONObject(output);
		    String token = obj.getString("token");
		    String userName =  obj.getString("username");
		    session.setAttribute("token", "Bearer "+token);
		    session.setAttribute("userName", userName);
			}
			catch(Exception ex) {
				
				System.out.println("error ocured" + ex);
			}
			finally {
				 httpClient.close();
		}
			RequestDispatcher rd = req.getRequestDispatcher("actions.jsp");
			rd.forward(req, resp);
			
		}
		
		else if (action.equals("signup"))
		{
			String fname = (String) req.getParameter("fname");
			String lname = (String) req.getParameter("lname");
			String email = (String) req.getParameter("email");
			String address = (String) req.getParameter("address");
			String password = (String) req.getParameter("psw");
			
			JSONObject json = new JSONObject();
			json.put("username", email);
			json.put("name", fname+ " " + lname);
			json.put("address", address);
			json.put("password", password);
			CloseableHttpClient httpClient = HttpClientBuilder.create().build();
			HttpPost request = new HttpPost("http://ec2-18-221-45-243.us-east-2.compute.amazonaws.com:4000/users");
			HttpResponse response;
			try {	
			request.setHeader("Content-Type", "application/json");
		    StringEntity params =new StringEntity(json.toString());
     	    request.addHeader("Accept","application/json");
		    request.setEntity(params);
		    response= httpClient.execute(request);
		    String output = EntityUtils.toString(response.getEntity());
		    session.setAttribute("success","true");
		    System.out.println("output is" + output);
			}
			catch(Exception ex) {
				
				System.out.println("error ocured" + ex);
			}
			finally {
				 httpClient.close();
		}
			
			RequestDispatcher rd = req.getRequestDispatcher("actions.jsp");
			rd.forward(req, resp);
		   
		}
		
		else if (action.equals("list")) {
			
//			JSONObject object = new JSONObject();
//			
//			HttpSession hsession = req.getSession(true);
//			CloseableHttpClient client = HttpClientBuilder.create().build();
//			
//			System.out.println("token is " + hsession.getAttribute("token").toString());
//			HttpGet request = new HttpGet("http://localhost:4000/userslist");
//			
//			HttpResponse response;
//			
//			try {	
//				request.setHeader("Content-Type", "application/json");
//				request.setHeader("Authorization", hsession.getAttribute("token").toString());
//			    StringEntity params =new StringEntity(object.toString());
//	     	    request.addHeader("Accept","application/json");
//			    response= client.execute(request);
//			    String output = EntityUtils.toString(response.getEntity());
//			    System.out.println("output is" + output);
//				}
//				catch(Exception ex) {
//					
//					System.out.println("error ocured" + ex);
//				}
//				finally {
//					 client.close();
//			}
				
				RequestDispatcher rd = req.getRequestDispatcher("patientlist.jsp");
				rd.forward(req, resp);
		}
		
		else if (action.equals("logout")) {
			
			HttpSession insession = req.getSession(true);
			insession.invalidate();
			RequestDispatcher rd = req.getRequestDispatcher("index.html");
			rd.forward(req, resp);
		}
		
		else if (action.equals("getuserresponse")) {
			
			String name = (String)req.getParameter("myField");
			System.out.println("name is " + name);
			RequestDispatcher rd = req.getRequestDispatcher("patientresponses.jsp");
			rd.forward(req, resp);
			
		}
		
		else if (action.equals("response"))
		{
			
			RequestDispatcher rd = req.getRequestDispatcher("patientsresponses.jsp");
			rd.forward(req, resp);
		}
		
		
	}

	
}
