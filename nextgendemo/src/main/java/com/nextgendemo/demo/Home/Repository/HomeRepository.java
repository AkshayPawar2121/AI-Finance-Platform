package com.nextgendemo.demo.Home.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nextgendemo.demo.Home.User.User;

@Repository
public interface HomeRepository extends JpaRepository<User, Long> {
    User findByEmail(String email); // Custom query to fetch user by email
}