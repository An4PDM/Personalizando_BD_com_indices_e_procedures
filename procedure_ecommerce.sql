USE ecommerce;
SHOW TABLES;

-- índices
SELECT * FROM cliente;
SELECT * FROM pedido;
SELECT * FROM produto;
SELECT * FROM fornecedor;

EXPLAIN SELECT razão_social FROM fornecedor;
DESCRIBE SELECT * FROM fornecedor WHERE contato = '11923447312';  

-- Antes do index = filtered 20, rows 5
-- Depois do index = filtered 100, rows 1

ALTER TABLE fornecedor ADD INDEX index_contato(contato);
SHOW INDEX FROM fornecedor;
DROP INDEX index_contato ON fornecedor; -- Índice em contato, pois é um valor único e muito procurado

-- Procedure para gerenciamento de clientes
DELIMITER //
CREATE PROCEDURE gerenciamento_cliente 
(action INT, id INT, fn VARCHAR(45), mn VARCHAR(45), lname VARCHAR(45), b DATE, ad VARCHAR(100), ident CHAR(11))
BEGIN
	CASE action
		WHEN 1 THEN
        -- INSERT
			INSERT INTO cliente VALUES (id,fn,mn,lname,b,ad,ident);
		WHEN 2 THEN
        -- UPDATE
			UPDATE cliente SET idCliente = id,
							   Fname = fn,
                               Minit = mn,
                               LName = lname,
                               Birth = b,
                               Address = ad,
                               Identity = ident
		  WHERE idCliente = id;
		WHEN 3 THEN
			DELETE FROM cliente WHERE idCliente = id;
		END CASE;
        SELECT * FROM cliente;
END //
DELIMITER ;

DROP PROCEDURE gerenciamento_cliente;
CALL gerenciamento_cliente (1,6,'Luiza','K','Jane','2000-09-25','rua 1','11334556778');
CALL gerenciamento_cliente (2,5,'Abigail','M','Lourenço','2000-10-30','rua lero','10191817165');
CALL gerenciamento_cliente (4,5,null,null,null,'2000-09-12',null,'');

-- Qual o departamento com maior número de pessoas? 
-- Quais são os departamentos por cidade? 
-- Relação de empregrados por departamento 
