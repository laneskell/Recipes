import { userTableName, recipesTableName } from './../types';
import connection from "../connection";

connection.raw(`
    CREATE TABLE IF NOT EXISTS ${userTableName} (
        id VARCHAR(255) PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS ${recipesTableName} (
        id VARCHAR(255) PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        image VARCHAR(2555) DEFAULT "https://passarelacalcados.vteximg.com.br/arquivos/ids/263443-1000-1000/image-c0c2acb820874abc9642496ace149c06.jpg?v=637407166345700000",
        description VARCHAR(25555) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        author_id VARCHAR(255),
        FOREIGN KEY (author_id) REFERENCES ${userTableName} (id)
    );

    CREATE TABLE IF NOT EXISTS Cookenu_Followers (
        user_follower_id VARCHAR(250),
        user_to_follow_id VARCHAR(250),
        FOREIGN KEY (user_follower_id) REFERENCES Cookenu_User(id),
        FOREIGN KEY (user_to_follow_id) REFERENCES Cookenu_User(id)
        );
        
`).then( () => console.log(
    "MySql table were sucessfully created!"
)).catch(error => console.log(error.message)
).finally( () => {
    connection.destroy()
})