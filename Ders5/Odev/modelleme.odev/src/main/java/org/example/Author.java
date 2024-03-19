package org.example;

import java.time.LocalDate;
import java.util.Date;

public class Author extends Person {
    public Author(int id, String firstName, String lastName, LocalDate birthdate) {
        super(id, firstName, lastName, birthdate);
    }
}
