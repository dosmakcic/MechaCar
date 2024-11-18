package com.dosmakcic.mechanear.models;


import jakarta.persistence.*;
import java.util.List;
import com.dosmakcic.mechanear.models.Location;


@Entity
public class Mechanic {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;

    private String email ;

    private String password;

    @ManyToOne
    @JoinColumn(name = "location_id") 
    private Location location;

    @ManyToMany(mappedBy = "selectedMechanics")
    private List<Driver> chosenbyDrivers;
    

    public Mechanic() {
    }

    public Mechanic(String name,String email,String password, Location location) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.location = location;
    }

    public Long getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public String getEmail() {
        return this.email;
    }

    public Location getLocation() {
        return this.location;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword(){
        return this.password;
    }

    public void setLocation(Location location) {
        this.location = location;
    }


}
