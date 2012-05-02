From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/3] ARM: imx: enable pinctrl dummy states
Date: Wed, 2 May 2012 19:31:20 +0800
Message-ID: <1335958282-3068-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:34936
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752356Ab2EBLXR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 May 2012 07:23:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree-discuss@lists.ozlabs.org, linus.walleij@stericsson.com, swarren@wwwdotorg.org, s.hauer@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, cjb@laptop.org, w.sang@pengutronix.de, linux-mmc@vger.kernel.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Enable pinctrl dummy states for imx platforms without pinctrl
support.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/mach-imx/imx51-dt.c |    3 +++
 arch/arm/mach-imx/imx53-dt.c |    3 +++
 arch/arm/mach-imx/mm-imx1.c  |    2 ++
 arch/arm/mach-imx/mm-imx21.c |    2 ++
 arch/arm/mach-imx/mm-imx25.c |    2 ++
 arch/arm/mach-imx/mm-imx27.c |    2 ++
 arch/arm/mach-imx/mm-imx3.c  |    2 ++
 arch/arm/mach-imx/mm-imx5.c  |    2 ++
 8 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index 5cca573..5f577fb 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
@@ -81,6 +82,8 @@ static void __init imx51_dt_init(void)
 
 	of_irq_init(imx51_irq_match);
 
+	pinctrl_provide_dummies();
+
 	node = of_find_matching_node(NULL, imx51_iomuxc_of_match);
 	if (node) {
 		of_id = of_match_node(imx51_iomuxc_of_match, node);
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index 4172279..574eca4 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
@@ -88,6 +89,8 @@ static void __init imx53_dt_init(void)
 
 	of_irq_init(imx53_irq_match);
 
+	pinctrl_provide_dummies();
+
 	node = of_find_matching_node(NULL, imx53_iomuxc_of_match);
 	if (node) {
 		of_id = of_match_node(imx53_iomuxc_of_match, node);
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 2bded59..fcafd3d 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/pinctrl/machine.h>
 
 #include <asm/mach/map.h>
 
@@ -58,4 +59,5 @@ void __init imx1_soc_init(void)
 						MX1_GPIO_INT_PORTC, 0);
 	mxc_register_gpio("imx1-gpio", 3, MX1_GPIO4_BASE_ADDR, SZ_256,
 						MX1_GPIO_INT_PORTD, 0);
+	pinctrl_provide_dummies();
 }
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 14d540e..5f43905 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -20,6 +20,7 @@
 
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/pinctrl/machine.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/devices-common.h>
@@ -88,6 +89,7 @@ void __init imx21_soc_init(void)
 	mxc_register_gpio("imx21-gpio", 4, MX21_GPIO5_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
 	mxc_register_gpio("imx21-gpio", 5, MX21_GPIO6_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
 
+	pinctrl_provide_dummies();
 	imx_add_imx_dma();
 	platform_device_register_simple("imx21-audmux", 0, imx21_audmux_res,
 					ARRAY_SIZE(imx21_audmux_res));
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index 153b457..6ff3714 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/pinctrl/machine.h>
 
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
@@ -95,6 +96,7 @@ void __init imx25_soc_init(void)
 	mxc_register_gpio("imx31-gpio", 2, MX25_GPIO3_BASE_ADDR, SZ_16K, MX25_INT_GPIO3, 0);
 	mxc_register_gpio("imx31-gpio", 3, MX25_GPIO4_BASE_ADDR, SZ_16K, MX25_INT_GPIO4, 0);
 
+	pinctrl_provide_dummies();
 	/* i.mx25 has the i.mx35 type sdma */
 	imx_add_imx_sdma("imx35-sdma", MX25_SDMA_BASE_ADDR, MX25_INT_SDMA, &imx25_sdma_pdata);
 	/* i.mx25 has the i.mx31 type audmux */
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 8cb3f5e..2566255 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -20,6 +20,7 @@
 
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/pinctrl/machine.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/devices-common.h>
@@ -89,6 +90,7 @@ void __init imx27_soc_init(void)
 	mxc_register_gpio("imx21-gpio", 4, MX27_GPIO5_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
 	mxc_register_gpio("imx21-gpio", 5, MX27_GPIO6_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
 
+	pinctrl_provide_dummies();
 	imx_add_imx_dma();
 	/* imx27 has the imx21 type audmux */
 	platform_device_register_simple("imx21-audmux", 0, imx27_audmux_res,
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 7412738..9128d15 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/pinctrl/machine.h>
 
 #include <asm/pgtable.h>
 #include <asm/system_misc.h>
@@ -267,6 +268,7 @@ void __init imx35_soc_init(void)
 	mxc_register_gpio("imx31-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
 	mxc_register_gpio("imx31-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
 
+	pinctrl_provide_dummies();
 	if (to_version == 1) {
 		strncpy(imx35_sdma_pdata.fw_name, "sdma-imx35-to1.bin",
 			strlen(imx35_sdma_pdata.fw_name));
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 05250ae..99de414 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/pinctrl/machine.h>
 
 #include <asm/system_misc.h>
 #include <asm/mach/map.h>
@@ -223,6 +224,7 @@ void __init imx53_soc_init(void)
 	mxc_register_gpio("imx31-gpio", 5, MX53_GPIO6_BASE_ADDR, SZ_16K, MX53_INT_GPIO6_LOW, MX53_INT_GPIO6_HIGH);
 	mxc_register_gpio("imx31-gpio", 6, MX53_GPIO7_BASE_ADDR, SZ_16K, MX53_INT_GPIO7_LOW, MX53_INT_GPIO7_HIGH);
 
+	pinctrl_provide_dummies();
 	/* i.mx53 has the i.mx35 type sdma */
 	imx_add_imx_sdma("imx35-sdma", MX53_SDMA_BASE_ADDR, MX53_INT_SDMA, &imx53_sdma_pdata);
 
-- 
1.7.0.4


