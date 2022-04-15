USE northwind;

DELIMITER //
CREATE PROCEDURE 5sec_proc()
BEGIN
    SELECT *
    FROM products;
    DO SLEEP(5);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Ssec_proc()
BEGIN
    SELECT *
    FROM products;
END
//
DELIMITER ;
