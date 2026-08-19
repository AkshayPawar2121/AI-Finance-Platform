package com.nextgendemo.demo.Home.IncomeDeposit.Repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.nextgendemo.demo.Home.IncomeDeposit.Entity.Notification;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    List<Notification> findByUserNameOrderByCreatedAtDesc(String userName);
}
