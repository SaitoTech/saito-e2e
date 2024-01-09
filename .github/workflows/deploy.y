# name: Clone and Run Two Instances with Config Modification

# on:
#   push:
#     branches: [ main, master, feature/e2e-testing ]
#   pull_request:
#     branches: [ main, master, feature/e2e-testing]

# jobs:
#   setup_and_run:
#     runs-on: ubuntu-latest
#     steps:
#     - name: Check out the repository
#       uses: actions/checkout@v2
#       with:
#         repository: 'SaitoTech/saito-lite-rust'
#         path: 'source_repo'

# #     - name: Set up Node.js
# #       uses: actions/setup-node@v2
# #       with:
# #         node-version: '20'

#     - name: Create directories for instances
#       run: |
#         mkdir instance1
#         mkdir instance2

#     - name: Copy repository into instances
#       run: |
#         cp -r source_repo/* instance1/
#         cp -r source_repo/* instance2/

#     - name: Install dependencies in instance 1
#       run: npm install
#       working-directory: ./instance1

# #     - name: Install dependencies in instance 2
# #       run: npm install
# #       working-directory: ./instance2

#     - name: Modify config for instance 1
#       run: |
#         echo '{"server":{"host":"127.0.0.1","port":12101,"protocol":"http","endpoint":{"host":"127.0.0.1","port":12101,"protocol":"http"},"verification_threads":4,"channel_size":10000,"stat_timer_in_ms":5000,"reconnection_wait_time":10000,"thread_sleep_time_in_ms":10,"block_fetch_batch_size":10},"peers":[],"spv_mode":false,"browser_mode":false,"blockchain":{"last_block_hash":"0000000000000000000000000000000000000000000000000000000000000000","last_block_id":0,"last_timestamp":0,"genesis_block_id":0,"genesis_timestamp":0,"lowest_acceptable_timestamp":0,"lowest_acceptable_block_hash":"0000000000000000000000000000000000000000000000000000000000000000","lowest_acceptable_block_id":0,"fork_id":"0000000000000000000000000000000000000000000000000000000000000000"},"wallet":{}}' > instance1/config/options.conf



#     - name: Run go in instance 1
#       run: npm run dev-server &
#       working-directory: ./instance1
#     - name: Wait for servers to start
#       run: sleep 120

# #     # - name: Run go in instance 2
# #     #   run: npm run dev-server &
# #     #   working-directory: ./instance2
    
#     # - name: Wait for servers to start
#     #   run: sleep 120

#     - name: Health check for instance 1
#       run: |
#         echo "Waiting for instance 1 to be ready..."
#         until curl --output /dev/null --silent --head --fail http://localhost:12101/redsquare; do
#           printf '.'
#           sleep 5
#         done
#         echo "Instance 1 is up and running!"

#     # - name: Health check for instance 2
#     #   run: |
#     #     echo "Waiting for instance 2 to be ready..."
#     #     until curl --output /dev/null --silent --head --fail http://localhost:12103; do
#     #       printf '.'
#     #       sleep 5
#     #     done
#     #     echo "Instance 2 is up and running!"
#     - name: Checkout repository
#       uses: actions/checkout@v2

#     - name: Install dependencies
#       run: npm install
#     - name: Install Playwright Browsers
#       run: npx playwright install --with-deps
#     - name: Run Playwright tests
#       run: npx playwright test
#     - uses: actions/upload-artifact@v3
#       if: always()
#       with:
#         name: playwright-report
#         path: tests/playwright-report/
#         retention-days: 30
    



name: Clone and Run Two Instances with Config Modification

on:
  push:
    branches: [ main, master, feature/e2e-testing ]
  pull_request:
    branches: [ main, master, feature/e2e-testing]

jobs:
  setup_and_run:
    runs-on: ubuntu-latest
    steps:
    - name: Check out the external repository
      uses: actions/checkout@v2
      with:
        repository: 'SaitoTech/saito-lite-rust'
        path: 'source_repo'

    - name: Check out the current repository
      uses: actions/checkout@v2
      with:
        path: 'deploy-tests'

    - name: Create directories for instances
      run: |
        mkdir instance1
        mkdir instance2

    - name: Copy external repository into instances
      run: |
        cp -r source_repo/* instance1/
        cp -r source_repo/* instance2/

    - name: Install dependencies in instance 1
      run: npm install
      working-directory: ./instance1

    - name: Modify config for instance 1
      run: |
        echo '{"server":{"host":"127.0.0.1","port":12101,"protocol":"http","endpoint":{"host":"127.0.0.1","port":12101,"protocol":"http"},"verification_threads":4,"channel_size":10000,"stat_timer_in_ms":5000,"reconnection_wait_time":10000,"thread_sleep_time_in_ms":10,"block_fetch_batch_size":10},"peers":[],"spv_mode":false,"browser_mode":false,"blockchain":{"last_block_hash":"0000000000000000000000000000000000000000000000000000000000000000","last_block_id":0,"last_timestamp":0,"genesis_block_id":0,"genesis_timestamp":0,"lowest_acceptable_timestamp":0,"lowest_acceptable_block_hash":"0000000000000000000000000000000000000000000000000000000000000000","lowest_acceptable_block_id":0,"fork_id":"0000000000000000000000000000000000000000000000000000000000000000"},"wallet":{}}' > instance1/config/options.conf

#     - name: Modify config for instance 2
#       run: |
#         echo '{"server":{"host":"127.0.0.1","port":12103,"protocol":"http","endpoint":{"host":"127.0.0.1","port":12103,"protocol":"http"},"verification_threads":4,"channel_size":10000,"stat_timer_in_ms":5000,"reconnection_wait_time":10000,"thread_sleep_time_in_ms":10,"block_fetch_batch_size":10},"peers":[{"host":"localhost","port":12101,"protocol":"http","synctype":"full"}],"spv_mode":false,"browser_mode":false,"blockchain":{"last_block_hash":"0000000000000000000000000000000000000000000000000000000000000000","last_block_id":0,"last_timestamp":0,"genesis_block_id":0,"genesis_timestamp":0,"lowest_acceptable_timestamp":0,"lowest_acceptable_block_hash":"0000000000000000000000000000000000000000000000000000000000000000","lowest_acceptable_block_id":0,"fork_id":"0000000000000000000000000000000000000000000000000000000000000000"},"wallet":{}}' > instance2/config/options.conf

    - name: Run server in instance 1
      run: npm run dev-server &
      working-directory: ./instance1

    - name: Health check for instance 1
      run: |
        echo "Waiting for instance 1 to be ready..."
        until curl --output /dev/null --silent --head --fail http://localhost:12101/redsquare; do
          printf '.'
          sleep 5
        done
        echo "Instance 1 is up and running!"

    - name: Install dependencies for tests
      run: npm install
      working-directory: ./deploy-tests

    - name: Install Playwright Browsers
      run: npx playwright install --with-deps
      working-directory: ./deploy-tests

    - name: Run Playwright tests
      run: npx playwright test
      working-directory: ./deploy-tests

    - uses: actions/upload-artifact@v3
      if: always()
      with:
        name: playwright-report
        path: deploy-tests/tests/playwright-report/
        retention-days: 30

  
