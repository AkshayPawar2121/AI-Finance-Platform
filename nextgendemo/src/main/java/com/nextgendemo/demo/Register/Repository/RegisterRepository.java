package com.nextgendemo.demo.Register.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nextgendemo.demo.Register.User.User;

@Repository
public interface RegisterRepository extends JpaRepository<User, Long> {
}