package com.dosmakcic.mechanear.models;

import java.util.List;
import jakarta.persistence.*;

@Entity
public class Location {

    @Id
    private Long id;

    private String city;
    private String country;
    private double latitude;
    private double longitude;

    public Location() {
    }

    public Location(Long id,String city,String country, double latitude, double longitude) {
        this.id = id;
        this.city = city;
        this.country = country;
        this.latitude = latitude;
        this.longitude = longitude;
    }

}
