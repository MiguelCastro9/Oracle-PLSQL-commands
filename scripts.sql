------------------- ESTRUTURA BÁSICA -------------------.
CREATE TABLE funcionario(
    id INT PRIMARY KEY NOT NULL,
    nome VARCHAR2(45) NOT NULL,
    idade INT NOT NULL,
    email VARCHAR2(45) NOT NULL,
    salario NUMBER(11, 2)
);

BEGIN

    INSERT INTO funcionario (id, nome, idade, email, salario) VALUES(1, 'miguel castro', 22, 'miguel@email.com', 7000);
    COMMIT;

END;

SELECT * FROM funcionario;

------------------- FUNÇÕES BÁSICAS -------------------.
SELECT UPPER (nome), UPPER (email) FROM funcionario;

SELECT SUBSTR(nome,2,6) FROM funcionario;

SELECT nome, (idade + 10) FROM funcionario;

SELECT nome, POWER(salario, 2) FROM funcionario;

SELECT AVG(salario)media_salarial FROM funcionario;

SELECT MAX(idade)maior_idade FROM funcionario;

SELECT MIN(idade)menor_idade FROM funcionario;

SELECT COUNT(email)qtd_email FROM funcionario;

SELECT SUM(salario)soma_salario FROM funcionario;

SELECT * FROM funcionario WHERE nome = 'miguel castro';

SELECT * FROM funcionario WHERE nome LIKE 'm%';

SELECT * FROM funcionario ORDER BY id DESC;

SELECT * FROM funcionario ORDER BY id ASC;

SELECT id, SUM(salario)soma_idade_salario FROM funcionario GROUP BY id;

SELECT id, SUM(salario)soma_idade_salario_h FROM funcionario GROUP BY id HAVING id = '1';

------------------- ESTRUTURA DE DECISÃO (IF) -------------------.
SET SERVEROUTPUT ON

DECLARE

variavel_id INT;
variavel_nome VARCHAR2(45);
variavel_idade INT;

BEGIN

    SELECT id, nome, idade INTO variavel_id, variavel_nome, variavel_idade
    FROM funcionario WHERE id = '1';
    
    IF variavel_idade < 18 THEN
    DBMS_OUTPUT.PUT_LINE(variavel_nome || ' É MENOR DE IDADE');
    ELSIF variavel_idade >= 18 THEN
    DBMS_OUTPUT.PUT_LINE(variavel_nome || ' É MAIOR DE IDADE');
    END IF;
    
EXCEPTION

    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('DADOS NÃO ENCONTRADOS!');

END;

------------------- ESTRUTURA DE DECISÃO (CASE) -------------------.
SET SERVEROUTPUT ON

DECLARE

variavel_id INT;
variavel_nome VARCHAR2(45);
variavel_idade INT;

BEGIN

    SELECT id, nome, idade INTO variavel_id, variavel_nome, variavel_idade
    FROM funcionario WHERE id = '1';
    
    CASE
    WHEN variavel_idade < 18 THEN
    DBMS_OUTPUT.PUT_LINE(variavel_nome || ' É MENOR DE IDADE');
    WHEN variavel_idade >= 18 THEN
    DBMS_OUTPUT.PUT_LINE(variavel_nome || ' É MAIOR DE IDADE');
    END CASE;
    
EXCEPTION

    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('DADOS NÃO ENCONTRADOS!');

END;

------------------- ESTRUTURA DE REPETIÇÃO (LOOP) -------------------.
SET SERVEROUTPUT ON

DECLARE

variavel_id INT;
variavel_nome VARCHAR2(45);
variavel_idade INT;
variavel_ano_previsao INT;
variavel_ano_atual INT;

BEGIN

    SELECT id, nome, idade INTO variavel_id, variavel_nome, variavel_idade
    FROM funcionario WHERE id = '1';
    
    variavel_ano_atual:='&ano_atual';
    
    variavel_ano_previsao:='&previsão_em_anos';
    
    LOOP
    variavel_idade:=variavel_idade + 1;
    variavel_ano_atual:=variavel_ano_atual + 1;
    DBMS_OUTPUT.PUT_LINE('EM ' || variavel_ano_atual || ' VOCÊ TERÁ ' || variavel_idade || ' ANOS DE IDADE.');
    EXIT WHEN variavel_ano_atual = variavel_ano_previsao;
    END LOOP;
    
EXCEPTION

    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('DADOS NÃO ENCONTRADOS!');

END;

------------------- ESTRUTURA DE REPETIÇÃO (WHILE) -------------------.
SET SERVEROUTPUT ON

DECLARE

variavel_id INT;
variavel_nome VARCHAR2(45);
variavel_idade INT;
variavel_ano_previsao INT;
variavel_ano_atual INT;

BEGIN

    SELECT id, nome, idade INTO variavel_id, variavel_nome, variavel_idade
    FROM funcionario WHERE id = '1';
    
    variavel_ano_atual:='&ano_atual';
    
    variavel_ano_previsao:='&previsão_em_anos';
    
    WHILE variavel_ano_atual < variavel_ano_previsao LOOP
    variavel_idade:=variavel_idade + 1;
    variavel_ano_atual:=variavel_ano_atual + 1;
    DBMS_OUTPUT.PUT_LINE('EM ' || variavel_ano_atual || ' VOCÊ TERÁ ' || variavel_idade || ' ANOS DE IDADE.');
    END LOOP;
    
EXCEPTION

    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('DADOS NÃO ENCONTRADOS!');

END;

------------------- ESTRUTURA DE REPETIÇÃO (FOR) -------------------.
SET SERVEROUTPUT ON

DECLARE

variavel_id INT;
variavel_nome VARCHAR2(45);
variavel_idade INT;
variavel_ano_previsao INT;
variavel_ano_atual INT;

BEGIN

    SELECT id, nome, idade INTO variavel_id, variavel_nome, variavel_idade
    FROM funcionario WHERE id = '1';
    
    variavel_ano_atual:='&ano_atual';
    
    variavel_ano_previsao:='&previsão_em_anos';
    
    FOR CONTADOR IN variavel_ano_atual..variavel_ano_previsao LOOP
    variavel_idade:=variavel_idade + 1;
    variavel_ano_atual:=variavel_ano_atual + 1;
    DBMS_OUTPUT.PUT_LINE('EM ' || variavel_ano_atual || ' VOCÊ TERÁ ' || variavel_idade || ' ANOS DE IDADE.');
    END LOOP;
    
EXCEPTION

    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('DADOS NÃO ENCONTRADOS!');

END;

------------------- CURSORES -------------------.
SET SERVEROUTPUT ON

DECLARE

CURSOR email_funcionario IS SELECT email FROM funcionario;

BEGIN

    FOR CONTADOR IN email_funcionario
    LOOP
    DBMS_OUTPUT.PUT_LINE(CONTADOR.email);
    END LOOP;

END;

------------------- CURSORES (%ROWTYPE) -------------------.
SET SERVEROUTPUT ON

DECLARE

CURSOR email_funcionario IS SELECT email FROM funcionario;

CONTADOR email_funcionario%ROWTYPE;

BEGIN
    
    OPEN email_funcionario;
        LOOP 
            FETCH email_funcionario INTO CONTADOR;
            EXIT WHEN email_funcionario%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(CONTADOR.email);
        END LOOP;
    CLOSE email_funcionario;
    
END;

------------------- PROCEDURES -------------------.
CREATE OR REPLACE PROCEDURE proc_idade IS

f_idade NUMBER;

BEGIN

    SELECT idade INTO f_idade FROM funcionario WHERE idade = 23;

END proc_idade;

EXECUTE proc_idade;

DROP PROCEDURE proc_idade;

------------------- FUNCTIONS -------------------.
CREATE OR REPLACE FUNCTION func_idade RETURN NUMBER

IS

f_idade NUMBER;

BEGIN

    SELECT idade INTO f_idade FROM funcionario WHERE idade = 23;
    RETURN f_idade;    
    
END;

SELECT func_idade FROM funcionario;

DROP FUNCTION func_idade;

------------------- TRIGGERS -------------------.
CREATE TABLE historico_salario(
    id INT PRIMARY KEY NOT NULL,
    h_salario NUMBER(11, 2)
);

CREATE OR REPLACE TRIGGER insere

BEFORE INSERT

ON funcionario

FOR EACH ROW

BEGIN

    INSERT INTO historico_salario VALUES(:NEW.id, :NEW.salario);

END;    

BEGIN

    INSERT INTO funcionario (id, nome, idade, email, salario) VALUES(2, 'miguel castro', 22, 'miguel@email.com', 7000);
    COMMIT;

END;

SELECT * FROM funcionario;

SELECT * FROM historico_salario;

CREATE OR REPLACE TRIGGER altera

AFTER UPDATE

ON funcionario

FOR EACH ROW

BEGIN

    UPDATE historico_salario SET h_salario = :NEW.salario;

END;    

BEGIN

    UPDATE funcionario SET salario = 9000 WHERE id = 1;
    COMMIT;

END;

SELECT * FROM funcionario;

SELECT * FROM historico_salario;





