CREATE TABLE patient (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE,
  PRIMARY KEY(id),
);

CREATE TABLE medical_histories (
    id              INT GENERATED ALWAYS AS IDENTITY,
    admitted_at     TIMESTAMP,
    status          VARCHAR(100),
    patient_id      INT,
    FOREIGN KEY (patient_id) REFERENCES patients (id),
    PRIMARY KEY(id)
);


