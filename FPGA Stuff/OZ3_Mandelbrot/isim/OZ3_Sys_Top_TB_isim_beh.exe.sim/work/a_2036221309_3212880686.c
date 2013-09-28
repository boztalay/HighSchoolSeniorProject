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
static const char *ng0 = "C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ3_Mandelbrot/MEMIO.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3499444699;

unsigned char ieee_p_2592010699_sub_1605435078_503743352(char *, unsigned char , unsigned char );


static void work_a_2036221309_3212880686_p_0(char *t0)
{
    char t17[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned char t12;
    unsigned char t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    int t18;
    unsigned int t19;
    int t20;
    int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned char t24;
    char *t25;
    char *t26;
    int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned char t31;
    unsigned char t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;

LAB0:    xsi_set_current_line(108, ng0);
    t1 = (t0 + 4980);
    t2 = (t1 + 32U);
    t3 = *((char **)t2);
    t4 = (t3 + 40U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(109, ng0);
    t1 = (t0 + 11961);
    t3 = (t0 + 5016);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(110, ng0);
    t1 = (t0 + 5052);
    t2 = (t1 + 32U);
    t3 = *((char **)t2);
    t4 = (t3 + 40U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(111, ng0);
    t1 = (t0 + 5088);
    t2 = (t1 + 32U);
    t3 = *((char **)t2);
    t4 = (t3 + 40U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(113, ng0);
    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t8 = (0 - 20);
    t9 = (t8 * -1);
    t10 = (1U * t9);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t12 = *((unsigned char *)t1);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4888);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(117, ng0);
    t3 = (t0 + 1052U);
    t4 = *((char **)t3);
    t3 = (t0 + 2800U);
    t5 = *((char **)t3);
    t14 = (31 - 3);
    t15 = (t14 * 1U);
    t16 = (0 + t15);
    t3 = (t5 + t16);
    t6 = (t17 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 3;
    t7 = (t6 + 4U);
    *((int *)t7) = 0;
    t7 = (t6 + 8U);
    *((int *)t7) = -1;
    t18 = (0 - 3);
    t19 = (t18 * -1);
    t19 = (t19 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t19;
    t20 = ieee_std_logic_arith_conv_integer_unsigned(IEEE_P_3499444699, t3, t17);
    t21 = (t20 - 15);
    t19 = (t21 * -1);
    xsi_vhdl_check_range_of_index(15, 0, -1, t20);
    t22 = (1U * t19);
    t23 = (0 + t22);
    t7 = (t4 + t23);
    t24 = *((unsigned char *)t7);
    t25 = (t0 + 2524U);
    t26 = *((char **)t25);
    t27 = (3 - 20);
    t28 = (t27 * -1);
    t29 = (1U * t28);
    t30 = (0 + t29);
    t25 = (t26 + t30);
    t31 = *((unsigned char *)t25);
    t32 = ieee_p_2592010699_sub_1605435078_503743352(IEEE_P_2592010699, t24, t31);
    t33 = (t0 + 4980);
    t34 = (t33 + 32U);
    t35 = *((char **)t34);
    t36 = (t35 + 40U);
    t37 = *((char **)t36);
    *((unsigned char *)t37) = t32;
    xsi_driver_first_trans_fast_port(t33);
    xsi_set_current_line(118, ng0);
    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t8 = (4 - 20);
    t9 = (t8 * -1);
    t10 = (1U * t9);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t12 = *((unsigned char *)t1);
    t3 = (t0 + 5052);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t12;
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(119, ng0);
    t1 = (t0 + 2800U);
    t2 = *((char **)t1);
    t9 = (31 - 3);
    t10 = (t9 * 1U);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t3 = (t0 + 5016);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(120, ng0);
    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t8 = (5 - 20);
    t9 = (t8 * -1);
    t10 = (1U * t9);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t12 = *((unsigned char *)t1);
    t3 = (t0 + 5088);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t12;
    xsi_driver_first_trans_fast_port(t3);
    goto LAB3;

}

static void work_a_2036221309_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    unsigned char t15;

LAB0:    xsi_set_current_line(128, ng0);
    t1 = (t0 + 11965);
    t3 = (t0 + 5124);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 32U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(129, ng0);
    t1 = (t0 + 5160);
    t2 = (t1 + 32U);
    t3 = *((char **)t2);
    t4 = (t3 + 40U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(132, ng0);
    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t8 = (1 - 20);
    t9 = (t8 * -1);
    t10 = (1U * t9);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t12 = *((unsigned char *)t1);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4896);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(133, ng0);
    t3 = (t0 + 2800U);
    t4 = *((char **)t3);
    t3 = (t0 + 5124);
    t5 = (t3 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 40U);
    t14 = *((char **)t7);
    memcpy(t14, t4, 32U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(134, ng0);
    t1 = (t0 + 592U);
    t2 = *((char **)t1);
    t12 = *((unsigned char *)t2);
    t1 = (t0 + 2524U);
    t3 = *((char **)t1);
    t8 = (6 - 20);
    t9 = (t8 * -1);
    t10 = (1U * t9);
    t11 = (0 + t10);
    t1 = (t3 + t11);
    t13 = *((unsigned char *)t1);
    t15 = ieee_p_2592010699_sub_1605435078_503743352(IEEE_P_2592010699, t12, t13);
    t4 = (t0 + 5160);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 40U);
    t14 = *((char **)t7);
    *((unsigned char *)t14) = t15;
    xsi_driver_first_trans_fast_port(t4);
    goto LAB3;

}

static void work_a_2036221309_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned char t12;
    unsigned char t13;
    int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned char t18;
    unsigned char t19;
    char *t20;
    char *t21;
    char *t22;

LAB0:    xsi_set_current_line(143, ng0);
    t1 = (t0 + 11997);
    t3 = (t0 + 5196);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 32U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(144, ng0);
    t1 = (t0 + 5232);
    t2 = (t1 + 32U);
    t3 = *((char **)t2);
    t4 = (t3 + 40U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(145, ng0);
    t1 = (t0 + 12029);
    t3 = (t0 + 5268);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 23U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(147, ng0);
    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t8 = (2 - 20);
    t9 = (t8 * -1);
    t10 = (1U * t9);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t12 = *((unsigned char *)t1);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4904);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(148, ng0);
    t3 = (t0 + 2524U);
    t4 = *((char **)t3);
    t14 = (7 - 20);
    t15 = (t14 * -1);
    t16 = (1U * t15);
    t17 = (0 + t16);
    t3 = (t4 + t17);
    t18 = *((unsigned char *)t3);
    t19 = (t18 == (unsigned char)3);
    if (t19 != 0)
        goto LAB5;

LAB7:
LAB6:    xsi_set_current_line(152, ng0);
    t1 = (t0 + 2800U);
    t2 = *((char **)t1);
    t9 = (31 - 22);
    t10 = (t9 * 1U);
    t11 = (0 + t10);
    t1 = (t2 + t11);
    t3 = (t0 + 5268);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 23U);
    xsi_driver_first_trans_fast_port(t3);
    goto LAB3;

LAB5:    xsi_set_current_line(149, ng0);
    t5 = (t0 + 960U);
    t6 = *((char **)t5);
    t5 = (t0 + 5196);
    t7 = (t5 + 32U);
    t20 = *((char **)t7);
    t21 = (t20 + 40U);
    t22 = *((char **)t21);
    memcpy(t22, t6, 32U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(150, ng0);
    t1 = (t0 + 5232);
    t2 = (t1 + 32U);
    t3 = *((char **)t2);
    t4 = (t3 + 40U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB6;

}

static void work_a_2036221309_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned int t3;
    unsigned int t4;
    unsigned int t5;
    char *t6;
    char *t7;
    int t8;
    char *t9;
    char *t10;
    int t11;
    char *t12;
    int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;

LAB0:    xsi_set_current_line(162, ng0);
    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t3 = (20 - 19);
    t4 = (t3 * 1U);
    t5 = (0 + t4);
    t1 = (t2 + t5);
    t6 = (t0 + 12052);
    t8 = xsi_mem_cmp(t6, t1, 2U);
    if (t8 == 1)
        goto LAB3;

LAB7:    t9 = (t0 + 12054);
    t11 = xsi_mem_cmp(t9, t1, 2U);
    if (t11 == 1)
        goto LAB4;

LAB8:    t12 = (t0 + 12056);
    t14 = xsi_mem_cmp(t12, t1, 2U);
    if (t14 == 1)
        goto LAB5;

LAB9:
LAB6:    xsi_set_current_line(170, ng0);
    t1 = (t0 + 12058);
    t6 = (t0 + 5304);
    t7 = (t6 + 32U);
    t9 = *((char **)t7);
    t10 = (t9 + 40U);
    t12 = *((char **)t10);
    memcpy(t12, t1, 32U);
    xsi_driver_first_trans_fast_port(t6);

LAB2:    t1 = (t0 + 4912);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(164, ng0);
    t15 = (t0 + 2800U);
    t16 = *((char **)t15);
    t15 = (t0 + 5304);
    t17 = (t15 + 32U);
    t18 = *((char **)t17);
    t19 = (t18 + 40U);
    t20 = *((char **)t19);
    memcpy(t20, t16, 32U);
    xsi_driver_first_trans_fast_port(t15);
    goto LAB2;

LAB4:    xsi_set_current_line(166, ng0);
    t1 = (t0 + 1144U);
    t2 = *((char **)t1);
    t1 = (t0 + 5304);
    t6 = (t1 + 32U);
    t7 = *((char **)t6);
    t9 = (t7 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 32U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB5:    xsi_set_current_line(168, ng0);
    t1 = (t0 + 2708U);
    t2 = *((char **)t1);
    t1 = (t0 + 5304);
    t6 = (t1 + 32U);
    t7 = *((char **)t6);
    t9 = (t7 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 32U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB2;

LAB10:;
}

static void work_a_2036221309_3212880686_p_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;

LAB0:    xsi_set_current_line(179, ng0);
    t1 = (t0 + 2616U);
    t2 = *((char **)t1);
    t1 = (t0 + 5340);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 40U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 32U);
    xsi_driver_first_trans_fast(t1);
    t1 = (t0 + 4920);
    *((int *)t1) = 1;

LAB1:    return;
}

static void work_a_2036221309_3212880686_p_5(char *t0)
{
    char *t1;
    char *t2;
    unsigned int t3;
    unsigned int t4;
    unsigned int t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;

LAB0:    xsi_set_current_line(213, ng0);

LAB3:    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t3 = (20 - 12);
    t4 = (t3 * 1U);
    t5 = (0 + t4);
    t1 = (t2 + t5);
    t6 = (t0 + 5376);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 5U);
    xsi_driver_first_trans_fast_port(t6);

LAB2:    t11 = (t0 + 4928);
    *((int *)t11) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2036221309_3212880686_p_6(char *t0)
{
    char *t1;
    char *t2;
    unsigned int t3;
    unsigned int t4;
    unsigned int t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;

LAB0:    xsi_set_current_line(217, ng0);

LAB3:    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t3 = (20 - 17);
    t4 = (t3 * 1U);
    t5 = (0 + t4);
    t1 = (t2 + t5);
    t6 = (t0 + 5412);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 5U);
    xsi_driver_first_trans_fast_port(t6);

LAB2:    t11 = (t0 + 4936);
    *((int *)t11) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2036221309_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2036221309_3212880686_p_0,(void *)work_a_2036221309_3212880686_p_1,(void *)work_a_2036221309_3212880686_p_2,(void *)work_a_2036221309_3212880686_p_3,(void *)work_a_2036221309_3212880686_p_4,(void *)work_a_2036221309_3212880686_p_5,(void *)work_a_2036221309_3212880686_p_6};
	xsi_register_didat("work_a_2036221309_3212880686", "isim/OZ3_Sys_Top_TB_isim_beh.exe.sim/work/a_2036221309_3212880686.didat");
	xsi_register_executes(pe);
}
