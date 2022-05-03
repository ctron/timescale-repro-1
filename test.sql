CREATE TABLE temperatures
(
    time            TIMESTAMP WITH TIME ZONE NOT NULL,
    device_id       VARCHAR(64)              NOT NULL,
    temperature     DOUBLE PRECISION         NOT NULL
);

\copy temperatures (time, device_id, temperature) from PROGRAM 'mlr --csv cut -f time,device_id,temperature timescale_test.csv' WITH (FORMAT CSV, HEADER)