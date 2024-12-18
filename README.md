# Task manager example application

Example application how to implement task manager in Plain.

## Prerequisites

You need ***plain2code*** renderer set up. Please see [plain2code_client](https://github.com/Codeplain-ai/plain2code_client) repository for details how to set it up.

You need to set `PLAIN2CODE_RENDERER_DIR` environmental variable to the directory containing the plain2code.py script.

## Usage

To have the task manager example application rendered to executable software code run

`sh render.sh -v`

The resulting software code will be stored to `build` folder (the folders `build.#` contain intermediary generated code). To run it execute

```
cd node_build
npm start
```

## Plain source

Plain source of the task manager example application is in file

`task_manager.plain`

The files

```
task_list_ui_specification.yaml
add_new_task_modal_specification.yaml
```

contain the definition of the user interface. These two files were automatically generated from Figma design (see [figma_screnshots](figma_screnshots) folder) using GPT-4o and a very simple prompt (`Describe this user interface. Your output should be in yaml format.`)
