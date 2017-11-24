/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author JunMing
 */
public class User {
    private String name;
    private String username;
    private String password;
    private String accountType;
    
    public User(String name, String username, String password, String accountType) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.accountType = accountType;
    }
    
    public String getName() {
        return name;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public String getAccountType() {
        return accountType;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }
    
    public boolean validateUser(String enteredPassword) {
        return enteredPassword.equals(this.password);
    }
}
