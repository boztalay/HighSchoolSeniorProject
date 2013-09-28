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
static const char *ng0 = "C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ3_Mandelbrot/OZ3_Sys_Top.vhd";
extern char *IEEE_P_2592010699;



static void work_a_0427300286_3212880686_p_0(char *t0)
{
    char t5[16];
    char t7[16];
    char *t1;
    char *t3;
    char *t4;
    char *t6;
    char *t8;
    char *t9;
    int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(83, ng0);

LAB3:    t1 = (t0 + 6534);
    t3 = (t0 + 1420U);
    t4 = *((char **)t3);
    t6 = ((IEEE_P_2592010699) + 2332);
    t8 = (t7 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 0;
    t9 = (t8 + 4U);
    *((int *)t9) = 8;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t10 = (8 - 0);
    t11 = (t10 * 1);
    t11 = (t11 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t11;
    t9 = (t0 + 6204U);
    t3 = xsi_base_array_concat(t3, t5, t6, (char)97, t1, t7, (char)97, t4, t9, (char)101);
    t12 = (t0 + 2688);
    t13 = (t12 + 32U);
    t14 = *((char **)t13);
    t15 = (t14 + 40U);
    t16 = *((char **)t15);
    memcpy(t16, t3, 32U);
    xsi_driver_first_trans_fast(t12);

LAB2:    t17 = (t0 + 2644);
    *((int *)t17) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0427300286_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0427300286_3212880686_p_0};
	xsi_register_didat("work_a_0427300286_3212880686", "isim/OZ3_Sys_Top_TB_isim_beh.exe.sim/work/a_0427300286_3212880686.didat");
	xsi_register_executes(pe);
}
