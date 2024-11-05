package com.dosmakcic.mechanear.models;

import jakarta.persistence.*;
import java.util.List;

@Entity
public class Driver {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  // Preporučuje se koristiti malo slovo za naziv

    private String name;
    private String email;
    private String password;

    @ManyToMany
    @JoinTable(
            name = "driver_mechanic",
            joinColumns = @JoinColumn(name = "driver_id"),
            inverseJoinColumns = @JoinColumn(name = "mechanic_id"))
    private List<Mechanic> selectedMechanics;

    // Getteri i setteri
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Mechanic> getSelectedMechanics() {
        return selectedMechanics;
    }

    public void setSelectedMechanics(List<Mechanic> selectedMechanics) {
        this.selectedMechanics = selectedMechanics;
    }
}