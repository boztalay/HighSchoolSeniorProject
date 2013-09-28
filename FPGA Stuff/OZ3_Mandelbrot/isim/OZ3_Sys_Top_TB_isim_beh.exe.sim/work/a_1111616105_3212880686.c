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
static const char *ng0 = "C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ3_Mandelbrot/RegFile.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;
extern char *IEEE_P_3499444699;

unsigned char ieee_p_2592010699_sub_1258338084_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_3620187407_sub_4042748798_3965413181(char *, char *, char *, char *, char *);


static void work_a_1111616105_3212880686_p_0(char *t0)
{
    char t14[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned int t11;
    char *t12;
    char *t13;
    int t15;
    char *t16;
    char *t17;
    int t18;
    int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;

LAB0:    xsi_set_current_line(45, ng0);
    t1 = (t0 + 568U);
    t2 = ieee_p_2592010699_sub_1258338084_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(56, ng0);
    t1 = (t0 + 1684U);
    t3 = *((char **)t1);
    t1 = (t0 + 960U);
    t4 = *((char **)t1);
    t1 = (t0 + 5248U);
    t15 = ieee_std_logic_arith_conv_integer_unsigned(IEEE_P_3499444699, t4, t1);
    t18 = (t15 - 31);
    t11 = (t18 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t15);
    t20 = (32U * t11);
    t21 = (0 + t20);
    t7 = (t3 + t21);
    t8 = (t0 + 2480);
    t9 = (t8 + 32U);
    t12 = *((char **)t9);
    t13 = (t12 + 40U);
    t16 = *((char **)t13);
    memcpy(t16, t7, 32U);
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(57, ng0);
    t1 = (t0 + 1684U);
    t3 = *((char **)t1);
    t1 = (t0 + 1052U);
    t4 = *((char **)t1);
    t1 = (t0 + 5264U);
    t15 = ieee_std_logic_arith_conv_integer_unsigned(IEEE_P_3499444699, t4, t1);
    t18 = (t15 - 31);
    t11 = (t18 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t15);
    t20 = (32U * t11);
    t21 = (0 + t20);
    t7 = (t3 + t21);
    t8 = (t0 + 2516);
    t9 = (t8 + 32U);
    t12 = *((char **)t9);
    t13 = (t12 + 40U);
    t16 = *((char **)t13);
    memcpy(t16, t7, 32U);
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(58, ng0);
    t1 = (t0 + 1684U);
    t3 = *((char **)t1);
    t1 = (t0 + 1144U);
    t4 = *((char **)t1);
    t1 = (t0 + 5280U);
    t15 = ieee_std_logic_arith_conv_integer_unsigned(IEEE_P_3499444699, t4, t1);
    t18 = (t15 - 31);
    t11 = (t18 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t15);
    t20 = (32U * t11);
    t21 = (0 + t20);
    t7 = (t3 + t21);
    t8 = (t0 + 2552);
    t9 = (t8 + 32U);
    t12 = *((char **)t9);
    t13 = (t12 + 40U);
    t16 = *((char **)t13);
    memcpy(t16, t7, 32U);
    xsi_driver_first_trans_fast_port(t8);
    t1 = (t0 + 2436);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(46, ng0);
    t3 = (t0 + 684U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 776U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB10;

LAB11:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(47, ng0);
    t3 = xsi_get_transient_memory(1024U);
    memset(t3, 0, 1024U);
    t7 = t3;
    t8 = (t0 + 6479);
    t10 = (32U != 0);
    if (t10 == 1)
        goto LAB8;

LAB9:    t12 = (t0 + 1684U);
    t13 = *((char **)t12);
    t12 = (t13 + 0);
    memcpy(t12, t3, 1024U);
    goto LAB6;

LAB8:    t11 = (1024U / 32U);
    xsi_mem_set_data(t7, t8, 32U, t11);
    goto LAB9;

LAB10:    xsi_set_current_line(49, ng0);
    t1 = (t0 + 1236U);
    t4 = *((char **)t1);
    t1 = (t0 + 5296U);
    t7 = (t0 + 6511);
    t9 = (t14 + 0U);
    t12 = (t9 + 0U);
    *((int *)t12) = 0;
    t12 = (t9 + 4U);
    *((int *)t12) = 4;
    t12 = (t9 + 8U);
    *((int *)t12) = 1;
    t15 = (4 - 0);
    t11 = (t15 * 1);
    t11 = (t11 + 1);
    t12 = (t9 + 12U);
    *((unsigned int *)t12) = t11;
    t6 = ieee_p_3620187407_sub_4042748798_3965413181(IEEE_P_3620187407, t4, t1, t7, t14);
    if (t6 != 0)
        goto LAB12;

LAB14:
LAB13:    goto LAB6;

LAB12:    xsi_set_current_line(50, ng0);
    t12 = (t0 + 868U);
    t13 = *((char **)t12);
    t12 = (t0 + 1684U);
    t16 = *((char **)t12);
    t12 = (t0 + 1236U);
    t17 = *((char **)t12);
    t12 = (t0 + 5296U);
    t18 = ieee_std_logic_arith_conv_integer_unsigned(IEEE_P_3499444699, t17, t12);
    t19 = (t18 - 31);
    t11 = (t19 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t18);
    t20 = (32U * t11);
    t21 = (0 + t20);
    t22 = (t16 + t21);
    memcpy(t22, t13, 32U);
    goto LAB13;

}


extern void work_a_1111616105_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1111616105_3212880686_p_0};
	xsi_register_didat("work_a_1111616105_3212880686", "isim/OZ3_Sys_Top_TB_isim_beh.exe.sim/work/a_1111616105_3212880686.didat");
	xsi_register_executes(pe);
}
