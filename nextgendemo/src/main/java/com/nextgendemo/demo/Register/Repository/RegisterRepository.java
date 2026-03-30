package com.nextgendemo.demo.Register.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nextgendemo.demo.Register.User.User;

@Repository
public interface RegisterRepository extends JpaRepository<User, Long> {

    /**
     * Check if a user with the given email already exists
     * @param email The email to check
     * @return true if email exists, false otherwise
     */
    boolean existsByEmail(String email);

    /**
     * Find a user by their email address
     * @param email The email to search for
     * @return User if found, null otherwise
     */
    User findByEmail(String email);
}