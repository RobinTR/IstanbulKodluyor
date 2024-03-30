package com.tobeto.derivedquerymakale;

import org.springframework.data.jpa.repository.JpaRepository;

import java.time.ZonedDateTime;
import java.util.Collection;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Integer> {
    List<User> findByName(String name);
    //List<User> findByNameIs(String name);
    //List<User> findByNameEquals(String name);
    List<User> findByNameIsNot(String name);
    List<User> findByNameIsNull();
    List<User> findByNameIsNotNull();
    List<User> findByActiveTrue();
    List<User> findByActiveFalse();
    List<User> findByNameStartingWith(String prefix);
    List<User> findByNameEndingWith(String suffix);
    List<User> findByNameContaining(String infix);
    List<User> findByNameLike(String likePattern);
    /*
    Usage example: String likePattern = "a%b%c";
    userRepository.findByNameLike(likePattern);
     */

    List<User> findByAgeLessThan(Integer age);
    List<User> findByAgeLessThanEqual(Integer age);
    List<User> findByAgeGreaterThan(Integer age);
    List<User> findByAgeGreaterThanEqual(Integer age);
    List<User> findByAgeBetween(Integer startAge, Integer endAge);
    List<User> findByAgeIn(Collection<Integer> ages);
    List<User> findByBirthDateAfter(ZonedDateTime birthDate);
    List<User> findByBirthDateBefore(ZonedDateTime birthDate);

    List<User> findByNameOrAge(String name, Integer age);
    List<User> findByNameOrAgeAndActive(String name, Integer age, Boolean active);

    List<User> findByNameOrderByName(String name);
    List<User> findByNameOrderByNameAsc(String name);
    List<User> findByNameOrderByNameDesc(String name);
}
