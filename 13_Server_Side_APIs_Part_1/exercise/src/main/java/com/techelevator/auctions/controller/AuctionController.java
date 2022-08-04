package com.techelevator.auctions.controller;

import com.techelevator.auctions.dao.AuctionDao;
import com.techelevator.auctions.dao.MemoryAuctionDao;
import com.techelevator.auctions.model.Auction;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/auctions")
public class AuctionController {

    private AuctionDao dao;

    public AuctionController() {
        this.dao = new MemoryAuctionDao();
    }


    @GetMapping()
    public List<Auction> list(@RequestParam(value = "title_like", defaultValue = "") String title,
                              @RequestParam(value = "currentBid_lte", defaultValue = "0") double bid){
        if (!title.isEmpty()&&bid>0){
            return dao.searchByTitleAndPrice(title,bid);
        }
        else if (!title.isEmpty()) {
            return dao.searchByTitle(title);
        }
        else if(bid>0){
            return dao.searchByPrice(bid);
        }
        return dao.list();
    }




    @GetMapping(path= "/{id}")
    public Auction get(@PathVariable int id){
        return dao.get(id);
    }

    @PostMapping()
    public Object create(@RequestBody Auction auction){
        if(auction!=null){
            dao.create(auction);
            return auction;
        }
      return null;
    }




    }
