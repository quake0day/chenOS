#include <emscripten.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

void js_print(const char *text) {
    EM_ASM({
        const consoleElement = document.getElementById('console');
        consoleElement.innerHTML += UTF8ToString($0) + '\n';
    }, text);
}



void process_command(const char *command) {
    if (strcmp(command, "who") == 0) {
        js_print("root");
    } else {
        char buffer[256];
        snprintf(buffer, sizeof(buffer), "Unknown command: %s", command);
        js_print(buffer);
    }
}

EMSCRIPTEN_KEEPALIVE
void process_command_from_js(const char *command) {
    process_command(command);
}

void kernel_main() {
    js_print("Hello, World!");
}

void print(const char *text) {
    EM_ASM({
        const message = UTF8ToString($0);
        customPrint(message); // Call the customPrint function instead of print
    }, text);
}
