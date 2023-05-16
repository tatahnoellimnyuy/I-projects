## Task: Deploying Two WordPress Websites with Docker 

### Description
Your task is to deploy two WordPress websites locally on an Apache server using Docker . The websites should share the same database but use different prefixes for tables. Each website should be accessible through a specific URL. You need to follow the provided requirements and steps to complete the task.

### Requirements
1. Docker installed on your system.
2. Docker Compose installed on your system.

### Steps to Complete the Task

### structure
File Structure:

.
├── docker-compose.yml
├── app1
│   ├── Dockerfile
│   └── apache-config
│       └── website1.conf
└── app2
    ├── Dockerfile
    └── apache-config
        └── website2.conf
- `docker-compose.yml`: The Docker Compose file that defines the services and configurations for the deployment of the two WordPress websites.
- `app1`: Directory containing the files for Website 1.
  - `Dockerfile`: The Dockerfile specific to Website 1, used for building the custom Docker image for this website.
  - `apache-config`: Directory representing the web root for Website 1. This is where the website's config files are placed.
    - website1.conf: Actual config file 

- `app2`: Directory containing the files for Website 2.
  - `Dockerfile`: The Dockerfile specific to Website 2, used for building the custom Docker image for this website.
   - `apache-config`: Directory representing the web root for Website 2. This is where the website's config files are be placed.
    - website2.conf: Actual config file 


#### Step 1: Explaining the docker compose file
Project Overview:

The Docker Compose setup consists of multiple services defined in the `docker-compose.yml` file. It deploys two WordPress websites on an Apache server locally, sharing the same database but using different prefixes for tables. The project structure includes separate directories for each website, containing their respective Dockerfiles and website files.

Services:

1. `db`:
   - Image: `mysql:8`
   - Description: MySQL database service used to store the data for both websites.
   - Configuration: Environment variables are set to define the database name, user, password, and root password.

2. `app1`:
   - Build: Context is set to the `website1` directory, and the Dockerfile is specified.
   - Description: The first website container built using the custom Docker image generated from the Dockerfile.
   - Configuration: Ports are mapped to make the website accessible on port 80. The website's specific environment variables, including the database prefix, host, name, user, and password, are set.

3. `app2`:
   - Build: Context is set to the `website2` directory, and the Dockerfile is specified.
   - Description: The second website container built using the custom Docker image generated from the Dockerfile.
   - Configuration: Ports are mapped to make the website accessible on port 81. The website's specific environment variables, including the database prefix, host, name, user, and password, are set.

#### explain  the Dockerfile
The Dockerfile is used to build a custom image for each website. It installs the necessary dependencies, configures Apache, and sets up the WordPress installation.

1. `FROM php:8-apache`:
   - Sets the base image to use for the custom image as `php:8-apache`, which includes Apache and PHP 8.

2. `RUN docker-php-ext-install mysqli pdo pdo_mysql`:
   - Installs the required PHP extensions for connecting to MySQL databases.

3. `RUN a2enmod rewrite`:
   - Enables the Apache `mod_rewrite` module for URL rewriting.

4. `COPY apache-config/website1.conf /etc/apache2/sites-available/website1.conf`:
   - Copies the Apache configuration file for Website 1 from the local `apache-config` directory to the appropriate location in the container.

5. `RUN a2ensite website1.conf`:
   - Enables the Website 1 Apache configuration by creating a symlink from the `sites-available` directory to the `sites-enabled` directory.

6. `RUN mkdir -p /var/www/www.website1.local`:
   - Creates the directory for Website 1's web root.

7. `WORKDIR /var/www/www.website1.local`:
   - Sets the working directory to Website 1's web root.

8. `COPY . /var/www/www.website1.local`:
   - Copies the entire contents of the local directory to Website 1's web root in the container.

9. WordPress Installation:
   - The following instructions download and set up the WordPress installation for Website 1:
     - `RUN curl -O https://wordpress.org/latest.tar.gz` - Downloads the latest version of WordPress.
     - `RUN tar -xvzf latest.tar.gz --strip-components=1` - Extracts the WordPress files to the current directory.
     - `RUN mv wp-config-sample.php wp-config.php` - Renames the sample configuration file to `wp-config.php`.
     - Configuration: The `sed` commands modify the `wp-config.php` file to use the specified database name, user, and password, and update the table prefix.
     - `RUN chown -R www-data:www-data /var/www/www.website1.local` - Changes ownership of the web root directory to the Apache user.

10. `EXPOSE 80`:
    - Exposes port 80 for the Apache server to listen on.

#### Step 5: Configure the host file
- Open the host file on your machine.
- Add the appropriate entries for each website's URL in the host file.
- The host file location is `/etc/hosts` for Unix/Linux systems and `C:\Windows\System32\drivers\etc\hosts` for Windows systems.
- Save the file after adding the entries.
# below are my configs for local server
```
127.0.0.1 www.website1.local
127.0.0.1 www.website2.local
```

#### Step 6: Start the containers
- In the same directory as the `docker-compose.yml` file, run the command `docker-compose up -d`.
- This command will build the necessary images and start the containers in detached mode.

#### Step 7: Access the websites
- Open your web browser and navigate to the URLs you configured in the host file for each website.
- You should be able to access and interact with the WordPress websites locally.

