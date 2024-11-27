# Initialize variables
VERBOSE=0
TESTS_ONLY=0

# Parse command line arguments
for arg in "$@"; do
  case $arg in
    -v|--verbose)
      VERBOSE=1
      ;;
    --tests-only)
      TESTS_ONLY=1
      ;;
  esac
done

if [ "${VERBOSE:-}" -eq 1 ] 2>/dev/null; then
    printf "Running the task manager example in verbose mode.\n"
fi

# Check if PLAIN2CODE_RENDERER variable is set
if [ -z "${PLAIN2CODE_RENDERER_DIR:-}" ]; then
    echo "Error: PLAIN2CODE_RENDERER_DIR variable is not set. Please set the PLAIN2CODE_RENDERER_DIR variable to the directory containing the plain2code.py script."
    exit 1
fi

# Run plain2code.py unless --tests-only is not set
if [[ $TESTS_ONLY -eq 0 ]]; then
    # Removing all the end-to-end tests before rendering the the task manage example.
    rm -rf e2e_tests
    rm -rf node_e2e_tests

    python $PLAIN2CODE_RENDERER_DIR/plain2code.py task_manager.plain --e2e-tests-script=$PLAIN2CODE_RENDERER_DIR//test_scripts/run_e2e_tests_cypress.sh ${VERBOSE:+-v}

    # Check if the plain2code command failed
    if [ $? -ne 0 ]; then
        echo "Error: The plain2code command failed."
        exit 1
    fi

    printf "\nThe plain2code command ran successfully. Now running the test harness...\n\n"
else
    printf "\nSkipping plain2code command. Running the test harness...\n\n"
fi

run_tests() {
    local folder=$1
    $PLAIN2CODE_RENDERER_DIR/test_scripts/run_e2e_tests_cypress.sh build harness_tests/"$folder" ${VERBOSE:+-v}
    
    # Check if the test harness has failed
    if [ $? -ne 0 ]; then
        echo "Error: The test harness has failed for $folder."
        exit 1
    fi
}

run_tests "app_entry"
run_tests "task_list_view"
run_tests "task_creation"
run_tests "task_deletion"
run_tests "task_editing"
run_tests "task_completion"

printf "Test harness ran successfully.\n\n"