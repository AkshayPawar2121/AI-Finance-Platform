package com.nextgendemo.demo;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nextgendemo.demo.Home.GoalSetter.Entity.AmountSet;
import com.nextgendemo.demo.Home.GoalSetter.Repository.GoalRepository;

@SpringBootTest
@AutoConfigureMockMvc
@Transactional
public class IncomeDepositControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private GoalRepository goalRepository;

    @Autowired
    private ObjectMapper objectMapper;

    private MockHttpSession session;
    private final String testUser = "ctrl_test_user@example.com";
    private AmountSet goal;

    @BeforeEach
    public void setup() {
        session = new MockHttpSession();
        session.setAttribute("userName", testUser);

        goalRepository.deleteAll();
        goal = new AmountSet();
        goal.setUserName(testUser);
        goal.setGoalName("New Car");
        goal.setTarget("20000");
        goal.setRemainingAmount(0.0);
        goal.setAllocationPercentage(15.0);
        goal = goalRepository.save(goal);
    }

    @Test
    public void testGetSettings_Success() throws Exception {
        mockMvc.perform(get("/home/income/settings").session(session))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.settings.userName").value(testUser))
                .andExpect(jsonPath("$.goals[0].goalName").value("New Car"));
    }

    @Test
    public void testSaveSettings_ValidCumulativeAllocation_ReturnsOk() throws Exception {
        Map<String, Object> payload = new HashMap<>();
        payload.put("safetyFloor", 1200.0);
        payload.put("minDepositAmount", 150.0);
        payload.put("accountBalance", 5000.0);

        Map<String, Double> allocations = new HashMap<>();
        allocations.put(String.valueOf(goal.getId()), 25.0); // 25% <= 100%
        payload.put("goalAllocations", allocations);

        mockMvc.perform(post("/home/income/settings")
                .session(session)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(payload)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.settings.safetyFloor").value(1200.0));
    }

    @Test
    public void testSaveSettings_Exceeds100PercentCumulative_ReturnsBadRequest() throws Exception {
        AmountSet goal2 = new AmountSet();
        goal2.setUserName(testUser);
        goal2.setGoalName("Emergency Fund");
        goal2.setTarget("10000");
        goal2.setRemainingAmount(0.0);
        goal2.setAllocationPercentage(10.0);
        goal2 = goalRepository.save(goal2);

        Map<String, Object> payload = new HashMap<>();
        payload.put("safetyFloor", 1200.0);
        payload.put("minDepositAmount", 150.0);

        Map<String, Double> allocations = new HashMap<>();
        allocations.put(String.valueOf(goal.getId()), 60.0);
        allocations.put(String.valueOf(goal2.getId()), 50.0); // 60% + 50% = 110% > 100%
        payload.put("goalAllocations", allocations);

        mockMvc.perform(post("/home/income/settings")
                .session(session)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(payload)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.success").value(false))
                .andExpect(jsonPath("$.error").value(org.hamcrest.Matchers.containsString("cannot exceed 100%")));
    }

    @Test
    public void testProcessDeposit_Success() throws Exception {
        mockMvc.perform(post("/home/income/deposit")
                .session(session)
                .param("amount", "1000"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.status").value("EXECUTED"))
                .andExpect(jsonPath("$.depositAmount").value(1000.0));
    }
}
