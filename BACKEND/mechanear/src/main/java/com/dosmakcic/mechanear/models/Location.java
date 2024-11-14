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

    public Location(Long id, String city, String country, double latitude, double longitude) {
        this.id = id;
        this.city = city;
        this.country = country;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}

