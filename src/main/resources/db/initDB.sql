DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS user_roles CASCADE;
DROP TABLE IF EXISTS owner_product CASCADE;
DROP TABLE IF EXISTS owners CASCADE;

CREATE TABLE product
(
    id serial NOT NULL,
    name TEXT,
    owner TEXT,
    manufacturer TEXT,
    price NUMERIC(10,2),
    description TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE owners
(
    id SERIAL NOT NULL PRIMARY KEY,
    name TEXT
);

CREATE TABLE owner_product
(
    owner_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT owner_product_idx UNIQUE (owner_id, product_id),
    FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product (id) ON DELETE CASCADE
);

CREATE TABLE users
(
    id SERIAL NOT NULL PRIMARY KEY,
    username TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE user_roles
(
    user_id INTEGER NOT NULL,
    role    VARCHAR NOT NULL,
    CONSTRAINT users_roles_idx UNIQUE (user_id, role),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);


GRANT SELECT ON ALL TABLES IN SCHEMA public TO "user";
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "user";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public to "user";