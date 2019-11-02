CREATE DATABASE neuroexpert;

USE neuroexpert;

CREATE TABLE sympton(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    real_name VARCHAR(1000) NOT NULL,
    question VARCHAR(1000) NOT NULL
);

CREATE TABLE disease(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    real_name VARCHAR(1000) NOT NULL
);


CREATE TABLE sympton_disease(
	sympton_id INT NOT NULL,
    disease_id INT NOT NULL,
    FOREIGN KEY (sympton_id) REFERENCES sympton(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (disease_id) REFERENCES disease(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (sympton_id, disease_id)
);

INSERT INTO sympton(name, real_name, question) VALUES
('fatigue', 'Fatiga', '¿Sientes fatiga constantemente?'),
('muscle_tension', 'Tensión muscular', '¿Sientes tensión muscular?'),
('hyperhidrosis', 'Sudoración', '¿Sudas más de la cuenta?'),
('confusion', 'Confusión', '¿Pierdes la noción de la razón muy a menudo?'),
('insomnia', 'Insomnio', '¿Te cuesta mucho conciliar el sueño?'),
('abdominal_pain', 'Dolor abdominal', '¿Sientes un dolor en el abdomen?'),
('stress', 'Estrés', '¿Te sientes estresado?'),
('fear_stolen', 'Miedo a ser asaltado', '¿Cuando sales a la calle, tienes un constante miedo de ser asaltado?'),
('fear_harm', 'Miedo a hacer daño', '¿Tienes un miedo constante de lastimar a otras personas?'),
('fear_mistakes', 'Miedo a las equivocaciones', '¿Tienes pánico a equivocarte?'),
('excessive_organization', 'Organización excesiva', '¿Te pones nervioso si un grupo de objetos no está debidamente ordenado?'),
('showers', 'Ducha excesiva', '¿Te bañas más de una vez al día?'),
('hand_washing', 'Lavada de manos excesiva', '¿Te lavas las manos muy frecuentemente?'),
('eating_fixed_food', 'Alimentación fija', '¿No sueles cambiar tu rutina alimenticia?'),
('separation_reality', 'Separación de la realidad', '¿Tienes la sensación de que vives una realidad distinta a los demás?'),
('loss_memory', 'Pérdida temporal de la memoria', '¿Te ha pasado que has perdido la memoria temporalmente?'),
('absence_consciousness', 'Ausencia de consciencia', '¿Sueles quedarte con la mente en blanca?'),
('feeling_hatred', 'Sentir odio', '¿Sientes odio por alguna persona en particular'),
('sleep_disruption', 'Interrupción del hambre y sueño', '¿Duermes o te alimentas a deshoras?'),
('inactivity_body', 'Vida sedentaria', '¿Tienes una vida sedentaria?'),
('inner_horror', 'Miedo interno', '¿Sueles sentir pánico o miedo interno?'),
('frustration_sense', 'Frustración y pérdida de esperanza', '¿Te persigue una constante sensación de frustración o pérdida de esperanza?'),
('loss_enjoyment_life', 'Falta de motivación por vivir', '¿Sientes que has perdido las ganas de vivir?');

INSERT INTO disease(name, real_name) VALUES
('anxiety', 'Ansiedad paroxìstica'),
('ocd', 'Desorden obsesivo compulsivo'),
('hysteria', 'Histeria'),
('depression', 'Depresiòn');

SELECT * FROM sympton;

INSERT INTO sympton_disease(sympton_id, disease_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 4),
(20, 4),
(21, 4),
(22, 4),
(23, 4)
