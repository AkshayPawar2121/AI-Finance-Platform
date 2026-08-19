package com.nextgendemo.demo.Home.IncomeDeposit.Repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.nextgendemo.demo.Home.IncomeDeposit.Entity.AccountSettings;

public interface AccountSettingsRepository extends JpaRepository<AccountSettings, Long> {
    Optional<AccountSettings> findByUserName(String userName);
}
