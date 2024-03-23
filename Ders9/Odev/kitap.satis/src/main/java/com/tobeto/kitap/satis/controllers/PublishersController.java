package com.tobeto.kitap.satis.controllers;

import com.tobeto.kitap.satis.entities.Publisher;
import com.tobeto.kitap.satis.repositories.PublisherRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/publishers")
public class PublishersController {
    private PublisherRepository publisherRepository;

    public PublishersController(PublisherRepository publisherRepository) {
        this.publisherRepository = publisherRepository;
    }

    @GetMapping
    public List<Publisher> getAll() {
        return publisherRepository.findAll();
    }

    @PostMapping
    public String add(@RequestBody Publisher publisher) {
        publisherRepository.save(publisher);

        return "Başarıyla eklendi";
    }

    @PutMapping
    public String update(@RequestBody Publisher publisher) {
        publisherRepository.save(publisher);

        return "Başarıyla güncellendi.";
    }

    @DeleteMapping
    public String delete(@RequestParam int id) {
        Publisher publisher = publisherRepository.findById(id).orElseThrow(() -> new RuntimeException("Böyle bir kategori bulunamadı."));
        publisherRepository.delete(publisher);

        return "Başarıyla silindi.";
    }
}
