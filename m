From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH 2/3]: Support cpu frequency scaling and power management for iMX6SL
Date: Mon, 16 Dec 2013 17:40:18 -0800
Message-ID: <CACUGKYP68joryww1cDreWWd1t_1VmfoNyFb1o2JvekH12_O7iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:33314 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3LQBkS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 20:40:18 -0500
Received: by mail-oa0-f43.google.com with SMTP id i7so5947236oag.30
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2013 17:40:18 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Chris Ball <cjb@laptop.org>

iMX6SL re-using iMX6Q driver in order to enable the cpu frequency
scaling and power management

From: John Tobias <john.tobias.ph@gmail.com>


diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 2f952e3..e66eccf 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -9,7 +9,10 @@

 #include <linux/irqchip.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pm_opp.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/regmap.h>
@@ -17,6 +20,7 @@
 #include <asm/mach/map.h>

 #include "common.h"
+#include "cpuidle.h"

 static void __init imx6sl_fec_init(void)
 {
@@ -34,6 +38,47 @@ static void __init imx6sl_fec_init(void)
        }
 }

+
+static void __init imx6sl_opp_init(void)
+{
+       struct device_node *np;
+       struct device *cpu_dev = get_cpu_device(0);
+
+       if (!cpu_dev) {
+               pr_warn("failed to get cpu0 device\n");
+               return;
+       }
+       np = of_node_get(cpu_dev->of_node);
+       if (!np) {
+               pr_warn("failed to find cpu0 node\n");
+               return;
+       }
+
+       if (of_init_opp_table(cpu_dev)) {
+               pr_warn("failed to init OPP table\n");
+               goto put_node;
+       }
+
+put_node:
+       of_node_put(np);
+}
+
+static struct platform_device imx6q_cpufreq_pdev = {
+       .name = "imx6q-cpufreq",
+};
+
+
+static void __init imx6sl_init_late(void)
+{
+       /* re-use imx6q */
+       imx6q_cpuidle_init();
+
+       if (IS_ENABLED(CONFIG_ARM_IMX6SQ_CPUFREQ)) {
+               imx6sl_opp_init();
+               platform_device_register(&imx6q_cpufreq_pdev);
+       }
+}
+
 static void __init imx6sl_init_machine(void)
 {
        struct device *parent;
@@ -70,6 +115,7 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite
(Device Tree)")
        .map_io         = debug_ll_io_init,
        .init_irq       = imx6sl_init_irq,
        .init_machine   = imx6sl_init_machine,
+       .init_late      = imx6sl_init_late,
        .dt_compat      = imx6sl_dt_compat,
        .restart        = mxc_restart,
 MACHINE_END
