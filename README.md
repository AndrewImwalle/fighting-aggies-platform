# Fightin' Aggie Platform

Developing an analytical panel to generate insights that help facilitate the post-game analysis done by the coaches and players of Fightin' Texas Aggie Football team.

### Deployment - [Heroku](https://fighting-aggies-platform.herokuapp.com/)

### Installation and Running Instructions
Clone repo
```bash
git clone https://github.com/jessefphipps/fighting-aggies-platform.git
cd fighting-aggies-platform
```

Install dependencies (takes a while)
```bash
./setup.sh
~/.bashrc
```

Run server
```bash
bin/dev
```

If you are developing on a server on a remote machine (e.g., AWS/EC2) use **http://0.0.0.0:8080** as your host url
and on your local machine use the EC2 instance's public IPv4 address in place of **0.0.0.0**.

If you are using vscode's remote editing feature use *localhost* as the broadcast IP and vscode will port-forward 
the instance's public IP and allow you to access the machine using your localhost (you can access the remote 
server's webpages and APIs by going to http://localhost:8080 on your local machine).

The server's broadcast IP (-b) and port (-p) can be set in **Procfile.dev**.

### Testing Instructions
Run the server in your local machine and use a new terminal to run the tests using the commands given below,
```bash
# to run cucumber and rspec unit tests
rake run_tests
```

```bash
#to run just cucumber
rake cucumber
```

```bash
# to run just rspec
rake spec
```
### Heroku Deployment Instructions
Migrate and seed the database
```bash
heroku run rake db:migrate
heroku run rake db:seed
```
Install ffmpeg on heroku
```bash
heroku buildpacks:add --index 1 https://github.com/jonathanong/heroku-buildpack-ffmpeg-latest.git
bundle install
yarn
git add .
git commit -m "ffmpeg buildpack on heroku"
git push heroku main
```
### Google OAuth
Visit https://console.cloud.google.com/ and login
Then, search for Credentials and click Credentials
Next, click create credentials and create OAuth client id credentials.
Then, add the following uris under authorized redirect URIs. These will be the uris that are allowed for the application and will need to be added for dev, test, and production uris.

  http://localhost:8080/auth/google_oauth2/callback
  http://127.0.0.1:8080/auth/google_oauth2/callback
  http://www.example.com/auth/google_oauth2/callback
  https://fighting-aggies-platform.herokuapp.com/auth/google_oauth2/callback
  http://fighting-aggies-platform.herokuapp.com/auth/google_oauth2/callback 

If you are trying to login with Google and get an error involving redirect uris these have not been added properly.

Finally, modify the .env file to include the Google Client ID and Google Secret Id for your new application. These will be shown on the right side of the page after the credentials are created.

### One Time Link Email
Email: fighting.aggies.analytics@gmail.com

App Password: tsaqzyyqbplvzcaa 

This is not the password for the email.


If having issues, to create new email:

Enable 2-step verification. Must be turned on to avoid getting the emails blocked by Google.

To create an app password, go to your Google account settings and navigate to the "Security" tab. Under "Signing in to Google", click on the "App passwords" menu item (this will only be available if you have 2-step verification turned on). Next, select Other (Custom name) under the "Select app" dropdown and enter the name of your app or something else useful. Click "Generate" and your new app password will appear on the screen. Make sure you copy it before closing the window, or you won't be able to see the password again.


When using application in development mode, the one time link is in the terminal. When using the application in production mode, the one time email will be sent to the email address of the user.

### Enabling Google OAuth for Website

### Video Upload Setup:

Videos are saved in the ActiveStorage. A S3 Bucket is being used. 

Create an AWS S3 Bucket. Additionally, there will be credentials that are needed to access the bucket. The credentials are an access key id and a secret access key. This will be in the security credentials section of the AWS console.

To use the access keys, encrypt the keys and the rails app will decrypt the keys while running. To start, run the following:
```bash
rails credentials:edit
```
This will open a file. If using vs code, the user will have to run the following.
```bash
EDITOR=”code –wait” rails credentials edit. 
```
This will open a temporary file with the credentials. Replace the values of both keys with AWS access keys:
```bash
aws:
  access_key_id: your-access-key-id
  secret_access_key: your-secret-access-key
```
Save the file and close which will encrypt the contents to config/credentials.yml.enc. The master key for this file will be in the config/master.key file. Be sure to set this key on heroku using the following command.
```bash
Heroku config:set RAILS_MASTER_KEY=12345678
```
Replace 12345678 with your application’s master key.

Finally, go to config/storage.yml and set the region and name of the bucket to be correct. This should be in the following format.
```bash
amazon:
  service: S3
  access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>
  secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>
  region: us-east-1
  bucket: your-bucket-name
```
This should make the storage function properly when using production. The videos will not work initially unless the table is empty and it is populated using videos to your specific S3 Bucket. To test this on a local end, make an edit to your config/environments/development.rb to switch the ActiveStorage service from local to amazon as shown below.
```bash
config.active_storage.service = :amazon 
```
