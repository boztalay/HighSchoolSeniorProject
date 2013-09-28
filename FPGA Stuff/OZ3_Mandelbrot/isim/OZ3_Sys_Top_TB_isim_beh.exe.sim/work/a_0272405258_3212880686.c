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
static const char *ng0 = "C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ3_Mandelbrot/ConditionBlock.vhd";



static void work_a_0272405258_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    char *t5;
    char *t6;
    int t7;
    char *t8;
    char *t9;
    int t10;
    char *t11;
    int t13;
    char *t14;
    int t16;
    char *t17;
    int t19;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned char t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;

LAB0:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t1 = (t0 + 4315);
    t4 = xsi_mem_cmp(t1, t2, 3U);
    if (t4 == 1)
        goto LAB3;

LAB10:    t5 = (t0 + 4318);
    t7 = xsi_mem_cmp(t5, t2, 3U);
    if (t7 == 1)
        goto LAB4;

LAB11:    t8 = (t0 + 4321);
    t10 = xsi_mem_cmp(t8, t2, 3U);
    if (t10 == 1)
        goto LAB5;

LAB12:    t11 = (t0 + 4324);
    t13 = xsi_mem_cmp(t11, t2, 3U);
    if (t13 == 1)
        goto LAB6;

LAB13:    t14 = (t0 + 4327);
    t16 = xsi_mem_cmp(t14, t2, 3U);
    if (t16 == 1)
        goto LAB7;

LAB14:    t17 = (t0 + 4330);
    t19 = xsi_mem_cmp(t17, t2, 3U);
    if (t19 == 1)
        goto LAB8;

LAB15:
LAB9:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 2044);
    t2 = (t1 + 32U);
    t3 = *((char **)t2);
    t5 = (t3 + 40U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t1 = (t0 + 2000);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(60, ng0);
    t20 = (t0 + 1052U);
    t21 = *((char **)t20);
    t22 = (0 - 3);
    t23 = (t22 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t20 = (t21 + t25);
    t26 = *((unsigned char *)t20);
    t27 = (t0 + 2044);
    t28 = (t27 + 32U);
    t29 = *((char **)t28);
    t30 = (t29 + 40U);
    t31 = *((char **)t30);
    *((unsigned char *)t31) = t26;
    xsi_driver_first_trans_fast_port(t27);
    goto LAB2;

LAB4:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 1052U);
    t2 = *((char **)t1);
    t4 = (1 - 3);
    t23 = (t4 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t26 = *((unsigned char *)t1);
    t3 = (t0 + 2044);
    t5 = (t3 + 32U);
    t6 = *((char **)t5);
    t8 = (t6 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t26;
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB5:    xsi_set_current_line(64, ng0);
    t1 = (t0 + 1052U);
    t2 = *((char **)t1);
    t4 = (2 - 3);
    t23 = (t4 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t26 = *((unsigned char *)t1);
    t3 = (t0 + 2044);
    t5 = (t3 + 32U);
    t6 = *((char **)t5);
    t8 = (t6 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t26;
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB6:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 1052U);
    t2 = *((char **)t1);
    t4 = (3 - 3);
    t23 = (t4 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t26 = *((unsigned char *)t1);
    t3 = (t0 + 2044);
    t5 = (t3 + 32U);
    t6 = *((char **)t5);
    t8 = (t6 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t26;
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB7:    xsi_set_current_line(68, ng0);
    t1 = (t0 + 868U);
    t2 = *((char **)t1);
    t4 = (4 - 4);
    t23 = (t4 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t1 = (t2 + t25);
    t26 = *((unsigned char *)t1);
    t3 = (t0 + 2044);
    t5 = (t3 + 32U);
    t6 = *((char **)t5);
    t8 = (t6 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t26;
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB8:    xsi_set_current_line(70, ng0);
    t1 = (t0 + 2044);
    t2 = (t1 + 32U);
    t3 = *((char **)t2);
    t5 = (t3 + 40U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB16:;
}


extern void work_a_0272405258_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0272405258_3212880686_p_0};
	xsi_register_didat("work_a_0272405258_3212880686", "isim/OZ3_Sys_Top_TB_isim_beh.exe.sim/work/a_0272405258_3212880686.didat");
	xsi_register_executes(pe);
}
