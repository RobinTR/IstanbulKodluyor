package com.tobeto.kitap.satis.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "books")
@Entity
public class Book {
    @Column(name = "id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "isbn")
    private int isbn;

    @Column(name = "book_name")
    private String name;

    @Column(name = "book_page")
    private int page;

    @Column(name = "price")
    private double price;

    @OneToMany(mappedBy = "book")
    private List<BookAuthor> bookAuthors;

    @OneToMany(mappedBy = "book")
    private List<BookCategory> bookCategories;

    @ManyToOne
    @JoinColumn(name = "publisher_id")
    private Publisher publisher;

    @OneToMany(mappedBy = "book")
    private List<OrderDetail> orderDetails;

    @OneToMany(mappedBy = "book")
    private List<Order> orders;
}
