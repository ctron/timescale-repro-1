-- create structure

CREATE TABLE temperatures
(
    time        TIMESTAMP WITH TIME ZONE NOT NULL,
    device_id   VARCHAR(64)              NOT NULL,
    temperature DOUBLE PRECISION         NOT NULL,
    PRIMARY KEY (device_id, time)
);

SELECT create_hypertable('temperatures', 'time');

-- generate some data

\copy temperatures (time, device_id, temperature) from PROGRAM './gen.py 6000' WITH (FORMAT CSV, HEADER)

-- now select

SELECT time_bucket('2s',"time") as "time", device_id as metric, avg(avg(temperature)) OVER w as temp
FROM temperatures
WHERE
    "time" BETWEEN now() - INTERVAL '5m' AND NOW()
  AND
    device_id = 'device1'
GROUP BY time, device_id
    WINDOW w as (PARTITION BY device_id ORDER BY time RANGE '1 minute'::INTERVAL PRECEDING)
ORDER BY time, device_id;
