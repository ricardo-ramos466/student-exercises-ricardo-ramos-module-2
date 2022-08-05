package com.techelevator.locations.controllers;

import com.techelevator.locations.dao.LocationDao;
import com.techelevator.locations.exception.LocationNotFoundException;
import com.techelevator.locations.model.Location;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/locations")
public class LocationController {

    private LocationDao dao;

    public LocationController(LocationDao dao) {
        this.dao = dao;
    }

    @RequestMapping(path = "", method = RequestMethod.GET)
    public List<Location> list() {
        return dao.list();
    }

    @RequestMapping(path = "/{id}", method = RequestMethod.GET)
    public Location get(@PathVariable int id) throws LocationNotFoundException {
        return dao.get(id);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(value = "", method = RequestMethod.POST)
    public Location add(@Valid @RequestBody Location location) {
        return dao.create(location);
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @PutMapping(path = "/{id}")
    public Location update(@Valid @RequestBody Location location, @PathVariable int id) throws LocationNotFoundException {
        return dao.update(location,id);
    }
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping(path = "/{id}")
    public void delete(@PathVariable int id) throws LocationNotFoundException {
        dao.delete(id);
    }
}
