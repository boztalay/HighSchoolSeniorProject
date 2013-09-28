/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *STD_TEXTIO;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *UNISIM_P_0947159679;
char *IEEE_P_3564397177;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    std_textio_init();
    ieee_p_3564397177_init();
    unisim_p_0947159679_init();
    work_a_0272557675_3212880686_init();
    work_a_3125958273_3212880686_init();
    work_a_2522068999_3212880686_init();
    work_a_1111616105_3212880686_init();
    work_a_2839604025_3212880686_init();
    work_a_3379253520_3212880686_init();
    work_a_0832606739_3212880686_init();
    work_a_1499998111_3212880686_init();
    work_a_0272405258_3212880686_init();
    work_a_0055124914_3212880686_init();
    work_a_2577596667_3212880686_init();
    work_a_0330969605_3212880686_init();
    work_a_2036221309_3212880686_init();
    work_a_1525478385_3212880686_init();
    work_a_2199296449_3212880686_init();
    work_a_0865462968_3212880686_init();
    work_a_0071338862_3212880686_init();
    work_a_3840815671_3212880686_init();
    work_a_1632567566_3212880686_init();
    xilinxcorelib_a_2619479265_2959432447_init();
    xilinxcorelib_a_0058954218_1709443946_init();
    xilinxcorelib_a_1380386513_0543512595_init();
    xilinxcorelib_a_1540231117_3212880686_init();
    work_a_1564937543_1315133242_init();
    work_a_0427300286_3212880686_init();
    work_a_3226806031_2372691052_init();


    xsi_register_tops("work_a_3226806031_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");

    return xsi_run_simulation(argc, argv);

}
