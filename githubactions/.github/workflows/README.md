#### the DEploy.sh file
This CI/CD pipeline performs the following tasks:

- Checks out the repository.
- Sets up PHP version 7.4.
- Installs dependencies using Composer.
- Runs tests using PHPUnit.
- Installs lftp.
- Deploys the code to an FTP server using lftp.
- Handles deployment errors by checking the success outcome of each step.
Please note that the actual values for secrets like ${{ secrets.FTP_USERNAME }}, ${{ secrets.FTP_PASSWORD }}, and ${{ secrets.FTP_SERVER }} are not included in this documentation and should be configured separately.

## Trigger

The pipeline is triggered on a push event to the `main` branch.

```yaml
on:
  push:
    branches:
      - master
Jobs
Deploy Job
The pipeline has a single job called deploy that runs on an Ubuntu environment.

```
jobs:
  deploy:
    runs-on: ubuntu-latest
Steps
```
The deploy job consists of the following steps:
```
Checkout repository
```
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Set up PHP
      uses: shivammathur/setup-php@v2
      with:
        php-version: '7.4'
```
Install dependencies
```
    - name: Install dependencies
      id: InstallDependencies
      run: composer install --no-interaction --prefer-dist --optimize-autoloader
      continue-on-error: true
```
Run tests
```
    - name: Run tests
      id: RunTests
      run: ./vendor/bin/phpunit
      continue-on-error: true
      ```
Install lftp
```
    - name: Install lftp
      id: InstallFtp
      run: sudo apt-get install -y lftp
      continue-on-error: true
      ```
Deploy to FTP
```
    - name: Deploy to FTP
      id: DeployToFtp
      run: |
        lftp -c "open -u ${{ secrets.FTP_USERNAME }},${{ secrets.FTP_PASSWORD }} ${{ secrets.FTP_SERVER }} && mirror -R ./path/to/deploy /remote/path"
      continue-on-error: true

    ```
Handle deployment errors
```
    - name: Handle deployment errors
      if: ${{ always() }}
      run: |
        if [[ ${{ steps.InstallDependencies.outcome }} != 'success' ]]; then
          echo "Pipeline failed at step: Install dependencies"
          exit 1
        elif [[ ${{ steps.RunTests.outcome }} != 'success' ]]; then
          echo "Pipeline failed at step: Run tests"
          exit 1
        elif [[ ${{ steps.InstallFtp.outcome }} != 'success' ]]; then
          echo "Pipeline failed at step: Install lftp"
          exit 1
        elif [[ ${{ steps.DeployToFtp.outcome }} != 'success' ]]; then
          echo "Pipeline failed at step: Deploy to FTP"
          exit 1
        fi
```
#### the multi-deploy.sh file
This CI/CD pipeline performs the following tasks:

- Checks out the repository.
- Sets up PHP version 7.4.
- Installs dependencies using Composer.
- Runs tests using PHPUnit.
- Installs lftp.
- Deploys the code to an FTP server using lftp to two seperate servers in two steps.
- Handles deployment errors by checking the success outcome of each step.
