package com.nextgendemo.demo.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.nextgendemo.demo.Home.Home;
import com.nextgendemo.demo.Home.BudgetPlanner.Entity.BudgetPlan;
import com.nextgendemo.demo.Home.BudgetPlanner.Service.BudgetService;
import com.nextgendemo.demo.Home.ExpenseTracker.Entity.ExpenseTrack;
import com.nextgendemo.demo.Home.ExpenseTracker.Service.ExpenseService;
import com.nextgendemo.demo.Home.GoalSetter.Entity.AmountSet;
import com.nextgendemo.demo.Home.GoalSetter.Service.AmountSetService;
import com.nextgendemo.demo.Register.Service.RegisterService;

import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

	@Autowired
	private Home h;
    @Autowired
    private RegisterService rs;
    @Autowired 
    private AmountSetService ass;
    @Autowired
    private BudgetService bs;
    @Autowired
    private ExpenseService es;
    // Home Page Mapping
    @GetMapping("/")
    public String Index() {
        return "index"; 
    }
	
	    // Registration Page Mapping
	    @GetMapping("/register")
	    public String Register() {
	        return "register"; // This will load register.jsp
	    }

	    // Registration Form Submission
	    @PostMapping("/register")
	    public String registerUser(@RequestParam String name,
	                               @RequestParam String mobile,
	                               @RequestParam String email,
	                               @RequestParam String password) {
	        boolean isRegistered = rs.registerUser(name, mobile, email, password);
	
	        if (isRegistered) {
	            return "redirect:/register"; // Redirect to a success page
	        } else {
	            return "redirect:/error"; // Redirect to an error page in case of failure
	        }
	    }

	    
	    // Home Page Mapping After Login    
	    // Login page submission and loading of the home page
	    @PostMapping("/verify")
	    public String home(@RequestParam String email, @RequestParam String password, HttpSession session) {
	        boolean isHome = h.validateLogin(email, password);
	        if (isHome) {
	            // Fetch user details (e.g., name) from the database
	            String userName = h.getUserNameByEmail(email);
	            session.setAttribute("userName", userName);
	            return "redirect:/home"; // Redirect to the home page
	        } else {
	            return "redirect:/"; // Redirect to the login page
	        }
	    }
	    
	    //Home page loading
	    @GetMapping("/home")
	    public String showUserGoals(HttpSession session, Model model) {
	        String userName = (String) session.getAttribute("userName");
	
	        if (userName != null) {
	            // Fetch all goals for the user
	            List<AmountSet> userGoals = ass.getGoalsByUserName(userName);
	            List<BudgetPlan> userBudgets = bs.getBudgetsByUserName(userName);
	            List<ExpenseTrack> userExpenses = es.getExpensesByUserName(userName);
	            System.out.print(userGoals);
	            System.out.print(userBudgets);
	
	            // Add goals to the model for rendering in the JSP
	            model.addAttribute("userGoals", userGoals);
	            model.addAttribute("userBudgets", userBudgets);
	            model.addAttribute("userExpenses", userExpenses);
	        }
	
	        return "home"; 
	    }
    
	    
	    
		// for goal setting
	    @PostMapping("/home/goalsetter")
	    public String goalSetter(@RequestParam String goalname, @RequestParam String target,HttpSession session) {
	    	String username = (String) session.getAttribute("userName");
	    	boolean amntSetS= ass.setGoal(username,goalname, target);
	        if (amntSetS) {
	            return "redirect:/home"; // Redirect to the home page
	        } else {
	            return "redirect:/"; // Redirect to error page
	        }
	    }
	    
	    // update the goalsetter
	    @PostMapping("/home/goalsetter/payment")
	    @ResponseBody
	    public Map<String, Object> processPayment(@RequestParam("goalId") Long goalId,
	                                            @RequestParam("paymentAmount") double paymentAmount,
	                                            HttpSession session) {
	        Map<String, Object> response = new HashMap<>();
	        String userName = (String) session.getAttribute("userName");
	        
	        if (userName != null) {
	            try {
	                // Update the remaining amount in the database
	                boolean success = ass.updateGoalPayment(goalId, paymentAmount);
	                response.put("success", success);
	            } catch (Exception e) {
	                response.put("success", false);
	                response.put("error", e.getMessage());
	            }
	        } else {
	            response.put("success", false);
	            response.put("error", "User not logged in");
	        }
	        
	        return response;
	    }
       
	    // delete the goalsetter
	    @DeleteMapping("/home/goalsetter/delete/{id}")
	    @ResponseBody
	    public Map<String, Boolean> deleteGoal(@PathVariable Long id) {
	        Map<String, Boolean> response = new HashMap<>();
	        try {
	            ass.deleteGoal(id);
	            response.put("success", true);
	        } catch (Exception e) {
	            response.put("success", false);
	        }
	        return response;
	    }
  
	    
	    
	    //budget predict
	    @PostMapping("/home/budgetplanner/predict")
	    @ResponseBody
	    public Map<String, Object> predictPlan(
	            @RequestParam("income") int income,
	            @RequestParam("age") int age,
	            @RequestParam("dependents") int dependents,
	            @RequestParam("occupation") String occupation,
	            @RequestParam("city_tier") int cityTier,
	            @RequestParam("loan_repayment") int loanRepayment,
	            @RequestParam("insurance") int insurance,
	            @RequestParam(value = "own_house", required = false) Boolean ownHouse,
	            @RequestParam(value = "self_sufficient_food", required = false) Boolean selfSufficientFood,
	            @RequestParam(value = "no_transport", required = false) Boolean noTransport,
	            @RequestParam(value = "no_eating_out", required = false) Boolean noEatingOut,
	            @RequestParam(value = "no_entertainment", required = false) Boolean noEntertainment,
	            @RequestParam(value = "no_utilities", required = false) Boolean noUtilities,
	            @RequestParam(value = "no_healthcare", required = false) Boolean noHealthcare,
	            @RequestParam(value = "no_education", required = false) Boolean noEducation,
	            HttpSession session) {
		    	Map<String, Object> response = new HashMap<>();
		        String userName = (String) session.getAttribute("userName");
	
		        System.out.println("User: " + userName);
		        System.out.println("Income: " + income);
		        System.out.println("Age: " + age);
		        System.out.println("Dependents: " + dependents);
		        System.out.println("Occupation: " + occupation);
		        System.out.println("City Tier: " + cityTier);
		        System.out.println("Loan Repayment: " + loanRepayment);
		        System.out.println("Insurance: " + insurance);
		        System.out.println("Own House: " + ownHouse);
		        System.out.println("Self Sufficient Food: " + selfSufficientFood);
		        System.out.println("No Transport: " + noTransport);
		        System.out.println("No Eating Out: " + noEatingOut);
		        System.out.println("No Entertainment: " + noEntertainment);
		        System.out.println("No Utilities: " + noUtilities);
		        System.out.println("No Healthcare: " + noHealthcare);
		        System.out.println("No Education: " + noEducation);
		        if (userName != null) {
		            try {
		                // Prepare input data for Python API
		                Map<String, Object> requestData = new HashMap<>();
		                requestData.put("Income", income);
		                requestData.put("Age", age);
		                requestData.put("Dependents", dependents);
		                requestData.put("Occupation", occupation); // Python will map this value
		                requestData.put("City_Tier", cityTier);
		                requestData.put("Loan_Repayment", loanRepayment);
		                requestData.put("Insurance", insurance);
		                requestData.put("Own_House", ownHouse != null && ownHouse);
		                requestData.put("Self_Sufficient_Food", selfSufficientFood != null && selfSufficientFood);
		                requestData.put("No_Transport", noTransport != null && noTransport);
		                requestData.put("No_Eating_Out", noEatingOut != null && noEatingOut);
		                requestData.put("No_Entertainment", noEntertainment != null && noEntertainment);
		                requestData.put("No_Utilities", noUtilities != null && noUtilities);
		                requestData.put("No_Healthcare", noHealthcare != null && noHealthcare);
		                requestData.put("No_Education", noEducation != null && noEducation);
		             // Make HTTP call to Python API
		                RestTemplate restTemplate = new RestTemplate();
		                String pythonApiUrl = "http://localhost:5000/predict"; // Ensure this matches your Python API endpoint

		                // Set headers (application/json for the Python API)
		                HttpHeaders headers = new HttpHeaders();
		                headers.setContentType(MediaType.APPLICATION_JSON);

		                HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(requestData, headers);
		                ResponseEntity<Map> apiResponse = restTemplate.exchange(
		                        pythonApiUrl, org.springframework.http.HttpMethod.POST, httpEntity, Map.class);

		                // Process Python API response
		                Map<String, Object> pythonResponse = apiResponse.getBody();
		                response.put("success", true);
		                response.put("data", pythonResponse);
		                System.out.println(pythonResponse);
		            } catch (Exception e) {
		                response.put("success", false);
		                response.put("error", e.getMessage());
		            }
		        } else {
		            response.put("success", false);
		            response.put("error", "User not logged in");
		        }

		        return response;
		    }
		








	
	    
//	    @PostMapping("/home/budgetplanner/predict")
//	    @ResponseBody
//	    public Map<String, Object> predictPlan(
//	            @RequestParam("income") int income,
//	            @RequestParam("age") int age,
//	            @RequestParam("dependents") int dependents,
//	            @RequestParam("occupation") String occupation,
//	            @RequestParam("city_tier") int cityTier,
//	            @RequestParam("loan_repayment") int loanRepayment,
//	            @RequestParam("insurance") int insurance,
//	            HttpSession session) {
//
//	        Map<String, Object> response = new HashMap<>();
//	        String userName = (String) session.getAttribute("userName");
//
//	        System.out.println("User: " + userName);
//	        System.out.println("Income: " + income);
//	        System.out.println("Age: " + age);
//	        System.out.println("Dependents: " + dependents);
//	        System.out.println("Occupation: " + occupation);
//	        System.out.println("City Tier: " + cityTier);
//	        System.out.println("Loan Repayment: " + loanRepayment);
//	        System.out.println("Insurance: " + insurance);
//
//	        if (userName != null) {
//	            try {
//	                // Prepare input data for Python API
//	                Map<String, Object> requestData = new HashMap<>();
//	                requestData.put("Income", income);
//	                requestData.put("Age", age);
//	                requestData.put("Dependents", dependents);
//	                requestData.put("Occupation", occupation);  // Python will map this value
//	                requestData.put("City_Tier", cityTier);
//	                requestData.put("Loan_Repayment", loanRepayment);
//	                requestData.put("Insurance", insurance);
//
//	                // Make HTTP call to Python API
//	                RestTemplate restTemplate = new RestTemplate();
//	                String pythonApiUrl = "http://localhost:5000/predict"; // Ensure this matches your Python API endpoint
//
//	                // Set headers (application/json for the Python API)
//	                HttpHeaders headers = new HttpHeaders();
//	                headers.setContentType(MediaType.APPLICATION_JSON);
//
//	                HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(requestData, headers);
//	                ResponseEntity<Map> apiResponse = restTemplate.exchange(
//	                        pythonApiUrl, HttpMethod.POST, httpEntity, Map.class);
//
//	                // Process Python API response
//	                Map<String, Object> pythonResponse = apiResponse.getBody();
//	                response.put("success", true);
//	                response.put("data", pythonResponse);
//	                System.out.println(pythonResponse);
//
//	            } catch (Exception e) {
//	                response.put("success", false);
//	                response.put("error", e.getMessage());
//	            }
//	        } else {
//	            response.put("success", false);
//	            response.put("error", "User not logged in");
//	        }
//
//	        return response;
//	    }

	
	    
    	// open the budget planner set the budget
	    @PostMapping("/home/budgetplanner")
	    public String budgetSetter(@RequestParam String budgetName, @RequestParam int budgetAmount,HttpSession session) {
	    	String username = (String) session.getAttribute("userName");
	    	System.out.println(username+" "+budgetName+" "+budgetAmount);
	    	boolean amntBgtS= bs.setBudget(username,budgetName, budgetAmount);
	        if (amntBgtS) {
	            return "redirect:/home"; // Redirect to the home page
	        } else {
	            return "redirect:/"; // Redirect to error page
	        }
	    }
	    
	    // update the budget 
	    @PostMapping("/home/budgetplanner/payment")
	    @ResponseBody
	    public Map<String, Object> processBudgetPayment(@RequestParam("budgetId") Long budgetId,
	                                                   @RequestParam("budgetAmount") int budgetAmount,
	                                                   HttpSession session) {
	        Map<String, Object> response = new HashMap<>();
	        String userName = (String) session.getAttribute("userName");

	        System.out.println(userName);
	        System.out.println(budgetId);

	        if (userName != null) {
	            try {
	                // Update the remaining amount in the database
	                boolean success = bs.updateBudgetPayment(budgetId, budgetAmount);
	                response.put("success", success);
	            } catch (Exception e) {
	                response.put("success", false);
	                response.put("error", e.getMessage());
	            }
	        } else {
	            response.put("success", false);
	            response.put("error", "User not logged in");
	        }

	        return response;
	    }

	    
	    // Delete the Budget
	    @DeleteMapping("/home/budgetplanner/delete/{id}")
	    @ResponseBody
	    public Map<String, Boolean> deleteBudget(@PathVariable Long id) {
	        Map<String, Boolean> response = new HashMap<>();
	        try {
	           bs.deleteBudget(id);
	            response.put("success", true);
	        } catch (Exception e) {
	            response.put("success", false);
	        }
	        return response;
	    }
	    
	    
	    
	    
	    // for the setting the expense tracker
	    @PostMapping("/home/expensetracker")
	    public String expenseTracker(@RequestParam String expenseName, @RequestParam int expenseAmount,HttpSession session) {
	    	String username = (String) session.getAttribute("userName");
	    	System.out.println(username+" "+expenseName+" "+expenseAmount);
	    	boolean amntBgtS= es.setExpense(username,expenseName, expenseAmount);
	        if (amntBgtS) {
	            return "redirect:/home"; // Redirect to the home page
	        } else {
	            return "redirect:/"; // Redirect to error page
	        }
	    }
	    
	    // update expense tracker
	    @PostMapping("/home/expensetracker/payment")
	    @ResponseBody
	    public Map<String, Object> processExpensePayment(@RequestParam("expenseId") Long expenseId,
	                                                    @RequestParam("expenseAmount") double expenseAmount,
	                                                    HttpSession session) {
	        Map<String, Object> response = new HashMap<>();
	        String userName = (String) session.getAttribute("userName");
	        
	        System.out.println("Received expenseId: " + expenseId + ", expenseAmount: " + expenseAmount);

	        if (userName != null) {
	            try {
	                boolean success = es.updateExpensePayment(expenseId, (int) expenseAmount);
	                response.put("success", success);
	            } catch (Exception e) {
	                response.put("success", false);
	                response.put("error", e.getMessage());
	            }
	        } else {
	            response.put("success", false);
	            response.put("error", "User not logged in");
	        }
	        
	        return response;
	    }



	    
	    // delete the expense 
	    @DeleteMapping("/home/expensetracker/delete/{id}")
	    @ResponseBody
	    public Map<String, Boolean> deleteExpense(@PathVariable Long id) {
	        Map<String, Boolean> response = new HashMap<>();
	        try {
	            es.deleteExpense(id);
	            response.put("success", true);
	        } catch (Exception e) {
	            response.put("success", false);
	        }
	        return response;
	    }

 
}
