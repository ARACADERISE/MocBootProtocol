#pragma once

typedef struct TerminalId
{
    unsigned int        id;
    unsigned char       level: 1;
} _TerminalId;

void try_this()
{
    extern _TerminalId term_id_setup;

    printf("%x", term_id_setup.id);
}