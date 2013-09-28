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
static const char *ng0 = "C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ3_Mandelbrot/output_pin_cntl.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3499444699;

unsigned char ieee_p_2592010699_sub_1258338084_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_0865462968_3212880686_p_0(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    unsigned char t8;
    char *t9;
    char *t10;
    int t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;

LAB0:    xsi_set_current_line(39, ng0);
    t1 = (t0 + 568U);
    t2 = ieee_p_2592010699_sub_1258338084_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(44, ng0);
    t1 = (t0 + 776U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB8;

LAB10:
LAB9:    xsi_set_current_line(47, ng0);
    t1 = (t0 + 1224U);
    t3 = *((char **)t1);
    t1 = (t0 + 2020);
    t4 = (t1 + 32U);
    t7 = *((char **)t4);
    t9 = (t7 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t3, 16U);
    xsi_driver_first_trans_fast_port(t1);
    t1 = (t0 + 1976);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(40, ng0);
    t3 = (t0 + 684U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(41, ng0);
    t3 = (t0 + 868U);
    t7 = *((char **)t3);
    t8 = *((unsigned char *)t7);
    t3 = (t0 + 1224U);
    t9 = *((char **)t3);
    t3 = (t0 + 960U);
    t10 = *((char **)t3);
    t3 = (t0 + 4000U);
    t11 = ieee_std_logic_arith_conv_integer_unsigned(IEEE_P_3499444699, t10, t3);
    t12 = (t11 - 15);
    t13 = (t12 * -1);
    xsi_vhdl_check_range_of_index(15, 0, -1, t11);
    t14 = (1U * t13);
    t15 = (0 + t14);
    t16 = (t9 + t15);
    *((unsigned char *)t16) = t8;
    goto LAB6;

LAB8:    xsi_set_current_line(45, ng0);
    t1 = xsi_get_transient_memory(16U);
    memset(t1, 0, 16U);
    t4 = t1;
    memset(t4, (unsigned char)2, 16U);
    t7 = (t0 + 1224U);
    t9 = *((char **)t7);
    t7 = (t9 + 0);
    memcpy(t7, t1, 16U);
    goto LAB9;

}


extern void work_a_0865462968_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0865462968_3212880686_p_0};
	xsi_register_didat("work_a_0865462968_3212880686", "isim/OZ3_Sys_Top_TB_isim_beh.exe.sim/work/a_0865462968_3212880686.didat");
	xsi_register_executes(pe);
}
