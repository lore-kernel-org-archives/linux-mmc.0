From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 20/31] ARM: amba: versatile: get rid of private platform
 amba_device initializer
Date: Fri, 20 Jan 2012 09:29:10 +0000
Message-ID: <E1RoAmU-0005Fb-9y@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32776 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab2ATJ3e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:29:34 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-versatile/core.c         |   36 ++++++++++++++++----------------
 arch/arm/mach-versatile/core.h         |   20 ++++-------------
 arch/arm/mach-versatile/versatile_pb.c |   10 ++++----
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 358cc0b..4f352e4 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -614,26 +614,26 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 #define SSP_IRQ		{ IRQ_SSPINT }
 
 /* FPGA Primecells */
-AMBA_DEVICE(aaci,  "fpga:04", AACI,     NULL);
-AMBA_DEVICE(mmc0,  "fpga:05", MMCI0,    &mmc0_plat_data);
-AMBA_DEVICE(kmi0,  "fpga:06", KMI0,     NULL);
-AMBA_DEVICE(kmi1,  "fpga:07", KMI1,     NULL);
+APB_DEVICE(aaci,  "fpga:04", AACI,     NULL);
+APB_DEVICE(mmc0,  "fpga:05", MMCI0,    &mmc0_plat_data);
+APB_DEVICE(kmi0,  "fpga:06", KMI0,     NULL);
+APB_DEVICE(kmi1,  "fpga:07", KMI1,     NULL);
 
 /* DevChip Primecells */
-AMBA_DEVICE(smc,   "dev:00",  SMC,      NULL);
-AMBA_DEVICE(mpmc,  "dev:10",  MPMC,     NULL);
-AMBA_DEVICE(clcd,  "dev:20",  CLCD,     &clcd_plat_data);
-AMBA_DEVICE(dmac,  "dev:30",  DMAC,     NULL);
-AMBA_DEVICE(sctl,  "dev:e0",  SCTL,     NULL);
-AMBA_DEVICE(wdog,  "dev:e1",  WATCHDOG, NULL);
-AMBA_DEVICE(gpio0, "dev:e4",  GPIO0,    &gpio0_plat_data);
-AMBA_DEVICE(gpio1, "dev:e5",  GPIO1,    &gpio1_plat_data);
-AMBA_DEVICE(rtc,   "dev:e8",  RTC,      NULL);
-AMBA_DEVICE(sci0,  "dev:f0",  SCI,      NULL);
-AMBA_DEVICE(uart0, "dev:f1",  UART0,    NULL);
-AMBA_DEVICE(uart1, "dev:f2",  UART1,    NULL);
-AMBA_DEVICE(uart2, "dev:f3",  UART2,    NULL);
-AMBA_DEVICE(ssp0,  "dev:f4",  SSP,      &ssp0_plat_data);
+AHB_DEVICE(smc,   "dev:00",  SMC,      NULL);
+AHB_DEVICE(mpmc,  "dev:10",  MPMC,     NULL);
+AHB_DEVICE(clcd,  "dev:20",  CLCD,     &clcd_plat_data);
+AHB_DEVICE(dmac,  "dev:30",  DMAC,     NULL);
+APB_DEVICE(sctl,  "dev:e0",  SCTL,     NULL);
+APB_DEVICE(wdog,  "dev:e1",  WATCHDOG, NULL);
+APB_DEVICE(gpio0, "dev:e4",  GPIO0,    &gpio0_plat_data);
+APB_DEVICE(gpio1, "dev:e5",  GPIO1,    &gpio1_plat_data);
+APB_DEVICE(rtc,   "dev:e8",  RTC,      NULL);
+APB_DEVICE(sci0,  "dev:f0",  SCI,      NULL);
+APB_DEVICE(uart0, "dev:f1",  UART0,    NULL);
+APB_DEVICE(uart1, "dev:f2",  UART1,    NULL);
+APB_DEVICE(uart2, "dev:f3",  UART2,    NULL);
+APB_DEVICE(ssp0,  "dev:f4",  SSP,      &ssp0_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
diff --git a/arch/arm/mach-versatile/core.h b/arch/arm/mach-versatile/core.h
index 2ef2f55..683e607 100644
--- a/arch/arm/mach-versatile/core.h
+++ b/arch/arm/mach-versatile/core.h
@@ -36,20 +36,10 @@ extern unsigned int mmc_status(struct device *dev);
 extern struct of_dev_auxdata versatile_auxdata_lookup[];
 #endif
 
-#define AMBA_DEVICE(name,busid,base,plat)			\
-static struct amba_device name##_device = {			\
-	.dev		= {					\
-		.coherent_dma_mask = ~0,			\
-		.init_name = busid,				\
-		.platform_data = plat,				\
-	},							\
-	.res		= {					\
-		.start	= VERSATILE_##base##_BASE,		\
-		.end	= (VERSATILE_##base##_BASE) + SZ_4K - 1,\
-		.flags	= IORESOURCE_MEM,			\
-	},							\
-	.dma_mask	= ~0,					\
-	.irq		= base##_IRQ,				\
-}
+#define APB_DEVICE(name, busid, base, plat)	\
+static AMBA_APB_DEVICE(name, busid, 0, VERSATILE_##base##_BASE, base##_IRQ, plat)
+
+#define AHB_DEVICE(name, busid, base, plat)	\
+static AMBA_AHB_DEVICE(name, busid, 0, VERSATILE_##base##_BASE, base##_IRQ, plat)
 
 #endif
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 1a5fe6e..1973833 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -73,13 +73,13 @@ static struct pl061_platform_data gpio3_plat_data = {
  */
 
 /* FPGA Primecells */
-AMBA_DEVICE(uart3, "fpga:09", UART3,    NULL);
-AMBA_DEVICE(sci1,  "fpga:0a", SCI1,     NULL);
-AMBA_DEVICE(mmc1,  "fpga:0b", MMCI1,    &mmc1_plat_data);
+APB_DEVICE(uart3, "fpga:09", UART3,    NULL);
+APB_DEVICE(sci1,  "fpga:0a", SCI1,     NULL);
+APB_DEVICE(mmc1,  "fpga:0b", MMCI1,    &mmc1_plat_data);
 
 /* DevChip Primecells */
-AMBA_DEVICE(gpio2, "dev:e6",  GPIO2,    &gpio2_plat_data);
-AMBA_DEVICE(gpio3, "dev:e7",  GPIO3,    &gpio3_plat_data);
+APB_DEVICE(gpio2, "dev:e6",  GPIO2,    &gpio2_plat_data);
+APB_DEVICE(gpio3, "dev:e7",  GPIO3,    &gpio3_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&uart3_device,
-- 
1.7.4.4

