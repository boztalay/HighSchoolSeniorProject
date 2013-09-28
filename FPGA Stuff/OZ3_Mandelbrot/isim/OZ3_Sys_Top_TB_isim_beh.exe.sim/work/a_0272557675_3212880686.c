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

/* This file is designed for use with ISim build 0x79f3f3a8 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ3_Mandelbrot/GenReg.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_0272557675_3212880686_p_0(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(35, ng0);
    t1 = (t0 + 568U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(42, ng0);
    t1 = (t0 + 1200U);
    t3 = *((char **)t1);
    t1 = (t0 + 1996);
    t4 = (t1 + 32U);
    t7 = *((char **)t4);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memcpy(t9, t3, 23U);
    xsi_driver_first_trans_fast_port(t1);
    t1 = (t0 + 1952);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(36, ng0);
    t3 = (t0 + 776U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 684U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB8;

LAB9:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(37, ng0);
    t3 = xsi_get_transient_memory(23U);
    memset(t3, 0, 23U);
    t7 = t3;
    memset(t7, (unsigned char)2, 23U);
    t8 = (t0 + 1200U);
    t9 = *((char **)t8);
    t8 = (t9 + 0);
    memcpy(t8, t3, 23U);
    goto LAB6;

LAB8:    xsi_set_current_line(39, ng0);
    t1 = (t0 + 868U);
    t4 = *((char **)t1);
    t1 = (t0 + 1200U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    memcpy(t1, t4, 23U);
    goto LAB6;

}


extern void work_a_0272557675_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0272557675_3212880686_p_0};
	xsi_register_didat("work_a_0272557675_3212880686", "isim/OZ3_Sys_Top_TB_isim_beh.exe.sim/work/a_0272557675_3212880686.didat");
	xsi_register_executes(pe);
}
