<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="_csrf" content="${_csrf.token}"/>
  <title>Finance Dashboard</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    /* Your existing CSS remains unchanged */
    .card-body {
      padding: 1rem;
    }
    .progress-bar {
      transition: width 0.5s ease;
    }
    #sidebar {
      position: sticky;
      top: 0;
      height: 100vh;
      padding-top: 20px;
    }
    .nav-link.active {
      background-color: #f0f0f0;
      font-weight: bold;
    }
    .centered-container {
        min-height: 100vh;
        display: flex;
        justify-content: center;
    }
    .large-label {
        font-size: 1.5rem;
        font-weight: bold;
    }
    .small-input {
        font-size: 1rem;
        padding: 0.5rem;
    }
  </style>
</head>
<body>
  <!-- Navbar and other HTML remains unchanged until the suggestions section -->
  
  <!-- Suggestions Section -->
  <div id="suggestions" class="section" style="display: none;">
    <div class="centered-container">
      <div class="container my-5">
        <div class="row mb-4 justify-content-center">
          <div class="col-md-8">
            <div class="card">
              <div class="card-body">
                <form id="suggestionsForm">
                  <div class="mb-3">
                    <label for="suggestIncome" class="form-label large-label">Income</label>
                    <input type="number" class="form-control small-input" id="suggestIncome" name="income" placeholder="Enter your income" min="0" step="1" required>
                  </div>
                  <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                      <tr>
                        <th scope="col">Goal Name</th>
                        <th scope="col">Target Amount</th>
                        <th scope="col">Remaining Amount</th>
                        <th scope="col">Priority</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="goal" items="${userGoals}" varStatus="loop">
                        <tr>
                          <td>${goal.goalName}</td>
                          <td>${goal.target}</td>
                          <td>${goal.target - (goal.remainingAmount != null ? goal.remainingAmount : 0)}</td>
                          <td>
                            <input type="number" class="form-control form-control-sm priority-input" 
                                   name="priority_${loop.index}" 
                                   value="${loop.index + 1}" 
                                   min="1" required>
                          </td>
                        </tr>
                      </c:forEach>
                      <c:if test="${empty userGoals}">
                        <tr><td colspan="4" class="text-center">No goals found</td></tr>
                      </c:if>
                    </tbody>
                  </table>
                  <button type="button" class="btn btn-primary mt-3" id="submitSuggestions">Suggest</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Rest of your HTML remains unchanged -->

  <!-- JavaScript Section -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    // Your existing section switching and other functions remain unchanged
    
    // Suggestions Form Handling - NEW IMPLEMENTATION
    $(document).ready(function() {
      $('#submitSuggestions').click(function() {
        submitSuggestions();
      });
    });

    function submitSuggestions() {
      try {
        // 1. Collect income
        const income = $('#suggestIncome').val() ? parseInt($('#suggestIncome').val()) : 0;
        
        // 2. Collect table data
        const goals = [];
        let isValid = true;
        
        $('table tbody tr').each(function() {
          // Skip empty rows
          if ($(this).find('td[colspan]').length > 0) return;
          
          const cells = $(this).find('td');
          if (cells.length < 4) return;
          
          const goalName = $(cells[0]).text().trim();
          const targetAmount = parseFloat($(cells[1]).text().replace(/[^0-9.-]+/g, '')) || 0;
          const remainingAmount = parseFloat($(cells[2]).text().replace(/[^0-9.-]+/g, '')) || 0;
          const priorityInput = $(cells[3]).find('.priority-input');
          
          if (priorityInput.length === 0) {
            console.error('Priority input not found for row:', $(this));
            isValid = false;
            return;
          }
          
          const priority = parseInt(priorityInput.val());
          
          if (isNaN(priority) || priority < 1) {
            alert(`Please enter a valid priority (≥1) for goal: ${goalName}`);
            isValid = false;
            return false; // Break out of the each loop
          }
          
          goals.push({
            goalName,
            targetAmount,
            remainingAmount,
            priority
          });
        });
        
        if (!isValid) return;
        if (goals.length === 0) {
          alert('No valid goals to submit');
          return;
        }
        
        // 3. Prepare and send data
        const payload = {
          income,
          goals
        };
        
        console.log('Submitting suggestions:', payload);
        
        $.ajax({
          url: '/home/suggestion',
          type: 'POST',
          contentType: 'application/json',
          data: JSON.stringify(payload),
          success: function(response) {
            alert('Suggestions received successfully!');
            console.log('Server response:', response);
          },
          error: function(xhr) {
            alert('Error: ' + (xhr.responseText || 'Request failed'));
            console.error('Error details:', xhr);
          }
        });
        
      } catch (e) {
        alert('Error: ' + e.message);
        console.error('Submission error:', e);
      }
    }

    // Rest of your existing JavaScript remains unchanged
  </script>
</body>
</html>