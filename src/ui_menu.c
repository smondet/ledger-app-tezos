#include "ui_menu.h"

#include "glyphs.h"
#include "ui.h"

#include "os.h"
#include "cx.h"

#ifndef BAKING_APP

void exit_app_cb(__attribute__((unused)) unsigned int cb) {
    exit_app();
}

// Mutually recursive static variables require forward declarations
static const ux_menu_entry_t main_menu_data[];
static const ux_menu_entry_t about_menu_data[];

static const ux_menu_entry_t about_menu_data[] = {
    {NULL, NULL, 0, NULL, "Tezos Wallet", "Version " VERSION, 0, 0},
    {main_menu_data, NULL, 1, &C_icon_back, "Back", NULL, 61, 40}, // TODO: Put icon for "back" in
    UX_MENU_END
};

static const ux_menu_entry_t main_menu_data[] = {
    {NULL, NULL, 0, NULL, "Use wallet to", "view accounts", 0, 0},
    {about_menu_data, NULL, 0, NULL, "About", NULL, 0, 0},
    {NULL, exit_app_cb, 0, &C_icon_dashboard, "Quit app", NULL, 50, 29}, // TODO: Put icon for "dashboard" in
    UX_MENU_END
};

void main_menu() {
    UX_MENU_DISPLAY(0, main_menu_data, NULL);
}
#endif
