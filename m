From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 10/31] ARM: amba: integrator/realview/versatile/vexpress: get
 rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:25:47 +0000
Message-ID: <E1RoAjD-0005Ev-74@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37481 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab2ATJ0R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:26:17 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/core.c                |   10 +++---
 arch/arm/mach-integrator/integrator_cp.c       |    4 +-
 arch/arm/mach-realview/realview_eb.c           |   40 ++++++++++++------------
 arch/arm/mach-realview/realview_pb1176.c       |   40 ++++++++++++------------
 arch/arm/mach-realview/realview_pb11mp.c       |   40 ++++++++++++------------
 arch/arm/mach-realview/realview_pba8.c         |   40 ++++++++++++------------
 arch/arm/mach-realview/realview_pbx.c          |   40 ++++++++++++------------
 arch/arm/mach-versatile/core.c                 |   34 ++++++++++----------
 arch/arm/mach-versatile/versatile_pb.c         |    8 ++--
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h |    2 +-
 10 files changed, 129 insertions(+), 129 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 019f0ab..29baef9 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -44,7 +44,7 @@ static struct amba_device rtc_device = {
 		.end	= INTEGRATOR_RTC_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_RTCINT, NO_IRQ },
+	.irq		= { IRQ_RTCINT },
 };
 
 static struct amba_device uart0_device = {
@@ -57,7 +57,7 @@ static struct amba_device uart0_device = {
 		.end	= INTEGRATOR_UART0_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_UARTINT0, NO_IRQ },
+	.irq		= { IRQ_UARTINT0 },
 };
 
 static struct amba_device uart1_device = {
@@ -70,7 +70,7 @@ static struct amba_device uart1_device = {
 		.end	= INTEGRATOR_UART1_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_UARTINT1, NO_IRQ },
+	.irq		= { IRQ_UARTINT1 },
 };
 
 static struct amba_device kmi0_device = {
@@ -82,7 +82,7 @@ static struct amba_device kmi0_device = {
 		.end	= KMI0_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_KMIINT0, NO_IRQ },
+	.irq		= { IRQ_KMIINT0 },
 };
 
 static struct amba_device kmi1_device = {
@@ -94,7 +94,7 @@ static struct amba_device kmi1_device = {
 		.end	= KMI1_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_KMIINT1, NO_IRQ },
+	.irq		= { IRQ_KMIINT1 },
 };
 
 static struct amba_device *amba_devs[] __initdata = {
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index a8b6aa6..ecc08ed 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -370,7 +370,7 @@ static struct amba_device aaci_device = {
 		.end	= INTEGRATOR_CP_AACI_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_CP_AACIINT, NO_IRQ },
+	.irq		= { IRQ_CP_AACIINT },
 	.periphid	= 0,
 };
 
@@ -437,7 +437,7 @@ static struct amba_device clcd_device = {
 		.flags	= IORESOURCE_MEM,
 	},
 	.dma_mask	= ~0,
-	.irq		= { IRQ_CP_CLCDCINT, NO_IRQ },
+	.irq		= { IRQ_CP_CLCDCINT },
 	.periphid	= 0,
 };
 
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index e629621..5c810e5 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -140,40 +140,40 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 /*
  * These devices are connected via the core APB bridge
  */
-#define GPIO2_IRQ	{ IRQ_EB_GPIO2, NO_IRQ }
-#define GPIO3_IRQ	{ IRQ_EB_GPIO3, NO_IRQ }
+#define GPIO2_IRQ	{ IRQ_EB_GPIO2 }
+#define GPIO3_IRQ	{ IRQ_EB_GPIO3 }
 
-#define AACI_IRQ	{ IRQ_EB_AACI, NO_IRQ }
+#define AACI_IRQ	{ IRQ_EB_AACI }
 #define MMCI0_IRQ	{ IRQ_EB_MMCI0A, IRQ_EB_MMCI0B }
-#define KMI0_IRQ	{ IRQ_EB_KMI0, NO_IRQ }
-#define KMI1_IRQ	{ IRQ_EB_KMI1, NO_IRQ }
+#define KMI0_IRQ	{ IRQ_EB_KMI0 }
+#define KMI1_IRQ	{ IRQ_EB_KMI1 }
 
 /*
  * These devices are connected directly to the multi-layer AHB switch
  */
-#define EB_SMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define MPMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define EB_CLCD_IRQ	{ IRQ_EB_CLCD, NO_IRQ }
-#define DMAC_IRQ	{ IRQ_EB_DMA, NO_IRQ }
+#define EB_SMC_IRQ	{ }
+#define MPMC_IRQ	{ }
+#define EB_CLCD_IRQ	{ IRQ_EB_CLCD }
+#define DMAC_IRQ	{ IRQ_EB_DMA }
 
 /*
  * These devices are connected via the core APB bridge
  */
-#define SCTL_IRQ	{ NO_IRQ, NO_IRQ }
-#define EB_WATCHDOG_IRQ	{ IRQ_EB_WDOG, NO_IRQ }
-#define EB_GPIO0_IRQ	{ IRQ_EB_GPIO0, NO_IRQ }
-#define GPIO1_IRQ	{ IRQ_EB_GPIO1, NO_IRQ }
-#define EB_RTC_IRQ	{ IRQ_EB_RTC, NO_IRQ }
+#define SCTL_IRQ	{ }
+#define EB_WATCHDOG_IRQ	{ IRQ_EB_WDOG }
+#define EB_GPIO0_IRQ	{ IRQ_EB_GPIO0 }
+#define GPIO1_IRQ	{ IRQ_EB_GPIO1 }
+#define EB_RTC_IRQ	{ IRQ_EB_RTC }
 
 /*
  * These devices are connected via the DMA APB bridge
  */
-#define SCI_IRQ		{ IRQ_EB_SCI, NO_IRQ }
-#define EB_UART0_IRQ	{ IRQ_EB_UART0, NO_IRQ }
-#define EB_UART1_IRQ	{ IRQ_EB_UART1, NO_IRQ }
-#define EB_UART2_IRQ	{ IRQ_EB_UART2, NO_IRQ }
-#define EB_UART3_IRQ	{ IRQ_EB_UART3, NO_IRQ }
-#define EB_SSP_IRQ	{ IRQ_EB_SSP, NO_IRQ }
+#define SCI_IRQ		{ IRQ_EB_SCI }
+#define EB_UART0_IRQ	{ IRQ_EB_UART0 }
+#define EB_UART1_IRQ	{ IRQ_EB_UART1 }
+#define EB_UART2_IRQ	{ IRQ_EB_UART2 }
+#define EB_UART3_IRQ	{ IRQ_EB_UART3 }
+#define EB_SSP_IRQ	{ IRQ_EB_SSP }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,  "fpga:aaci",  AACI,     NULL);
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index e4abe94..9506de9 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -132,27 +132,27 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 /*
  * RealView PB1176 AMBA devices
  */
-#define GPIO2_IRQ	{ IRQ_PB1176_GPIO2, NO_IRQ }
-#define GPIO3_IRQ	{ IRQ_PB1176_GPIO3, NO_IRQ }
-#define AACI_IRQ	{ IRQ_PB1176_AACI, NO_IRQ }
+#define GPIO2_IRQ	{ IRQ_PB1176_GPIO2 }
+#define GPIO3_IRQ	{ IRQ_PB1176_GPIO3 }
+#define AACI_IRQ	{ IRQ_PB1176_AACI }
 #define MMCI0_IRQ	{ IRQ_PB1176_MMCI0A, IRQ_PB1176_MMCI0B }
-#define KMI0_IRQ	{ IRQ_PB1176_KMI0, NO_IRQ }
-#define KMI1_IRQ	{ IRQ_PB1176_KMI1, NO_IRQ }
-#define PB1176_SMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define MPMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define PB1176_CLCD_IRQ	{ IRQ_DC1176_CLCD, NO_IRQ }
-#define SCTL_IRQ	{ NO_IRQ, NO_IRQ }
-#define PB1176_WATCHDOG_IRQ	{ IRQ_DC1176_WATCHDOG, NO_IRQ }
-#define PB1176_GPIO0_IRQ	{ IRQ_PB1176_GPIO0, NO_IRQ }
-#define GPIO1_IRQ	{ IRQ_PB1176_GPIO1, NO_IRQ }
-#define PB1176_RTC_IRQ	{ IRQ_DC1176_RTC, NO_IRQ }
-#define SCI_IRQ		{ IRQ_PB1176_SCI, NO_IRQ }
-#define PB1176_UART0_IRQ	{ IRQ_DC1176_UART0, NO_IRQ }
-#define PB1176_UART1_IRQ	{ IRQ_DC1176_UART1, NO_IRQ }
-#define PB1176_UART2_IRQ	{ IRQ_DC1176_UART2, NO_IRQ }
-#define PB1176_UART3_IRQ	{ IRQ_DC1176_UART3, NO_IRQ }
-#define PB1176_UART4_IRQ	{ IRQ_PB1176_UART4, NO_IRQ }
-#define PB1176_SSP_IRQ		{ IRQ_DC1176_SSP, NO_IRQ }
+#define KMI0_IRQ	{ IRQ_PB1176_KMI0 }
+#define KMI1_IRQ	{ IRQ_PB1176_KMI1 }
+#define PB1176_SMC_IRQ	{ }
+#define MPMC_IRQ	{ }
+#define PB1176_CLCD_IRQ	{ IRQ_DC1176_CLCD }
+#define SCTL_IRQ	{ }
+#define PB1176_WATCHDOG_IRQ	{ IRQ_DC1176_WATCHDOG }
+#define PB1176_GPIO0_IRQ	{ IRQ_PB1176_GPIO0 }
+#define GPIO1_IRQ	{ IRQ_PB1176_GPIO1 }
+#define PB1176_RTC_IRQ	{ IRQ_DC1176_RTC }
+#define SCI_IRQ		{ IRQ_PB1176_SCI }
+#define PB1176_UART0_IRQ	{ IRQ_DC1176_UART0 }
+#define PB1176_UART1_IRQ	{ IRQ_DC1176_UART1 }
+#define PB1176_UART2_IRQ	{ IRQ_DC1176_UART2 }
+#define PB1176_UART3_IRQ	{ IRQ_DC1176_UART3 }
+#define PB1176_UART4_IRQ	{ IRQ_PB1176_UART4 }
+#define PB1176_SSP_IRQ		{ IRQ_DC1176_SSP }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 127a3fd..cb4f2da 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -132,27 +132,27 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  * RealView PB11MPCore AMBA devices
  */
 
-#define GPIO2_IRQ		{ IRQ_PB11MP_GPIO2, NO_IRQ }
-#define GPIO3_IRQ		{ IRQ_PB11MP_GPIO3, NO_IRQ }
-#define AACI_IRQ		{ IRQ_TC11MP_AACI, NO_IRQ }
+#define GPIO2_IRQ		{ IRQ_PB11MP_GPIO2 }
+#define GPIO3_IRQ		{ IRQ_PB11MP_GPIO3 }
+#define AACI_IRQ		{ IRQ_TC11MP_AACI }
 #define MMCI0_IRQ		{ IRQ_TC11MP_MMCI0A, IRQ_TC11MP_MMCI0B }
-#define KMI0_IRQ		{ IRQ_TC11MP_KMI0, NO_IRQ }
-#define KMI1_IRQ		{ IRQ_TC11MP_KMI1, NO_IRQ }
-#define PB11MP_SMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define MPMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define PB11MP_CLCD_IRQ		{ IRQ_PB11MP_CLCD, NO_IRQ }
-#define DMAC_IRQ		{ IRQ_PB11MP_DMAC, NO_IRQ }
-#define SCTL_IRQ		{ NO_IRQ, NO_IRQ }
-#define PB11MP_WATCHDOG_IRQ	{ IRQ_PB11MP_WATCHDOG, NO_IRQ }
-#define PB11MP_GPIO0_IRQ	{ IRQ_PB11MP_GPIO0, NO_IRQ }
-#define GPIO1_IRQ		{ IRQ_PB11MP_GPIO1, NO_IRQ }
-#define PB11MP_RTC_IRQ		{ IRQ_TC11MP_RTC, NO_IRQ }
-#define SCI_IRQ			{ IRQ_PB11MP_SCI, NO_IRQ }
-#define PB11MP_UART0_IRQ	{ IRQ_TC11MP_UART0, NO_IRQ }
-#define PB11MP_UART1_IRQ	{ IRQ_TC11MP_UART1, NO_IRQ }
-#define PB11MP_UART2_IRQ	{ IRQ_PB11MP_UART2, NO_IRQ }
-#define PB11MP_UART3_IRQ	{ IRQ_PB11MP_UART3, NO_IRQ }
-#define PB11MP_SSP_IRQ		{ IRQ_PB11MP_SSP, NO_IRQ }
+#define KMI0_IRQ		{ IRQ_TC11MP_KMI0 }
+#define KMI1_IRQ		{ IRQ_TC11MP_KMI1 }
+#define PB11MP_SMC_IRQ		{ }
+#define MPMC_IRQ		{ }
+#define PB11MP_CLCD_IRQ		{ IRQ_PB11MP_CLCD }
+#define DMAC_IRQ		{ IRQ_PB11MP_DMAC }
+#define SCTL_IRQ		{ }
+#define PB11MP_WATCHDOG_IRQ	{ IRQ_PB11MP_WATCHDOG }
+#define PB11MP_GPIO0_IRQ	{ IRQ_PB11MP_GPIO0 }
+#define GPIO1_IRQ		{ IRQ_PB11MP_GPIO1 }
+#define PB11MP_RTC_IRQ		{ IRQ_TC11MP_RTC }
+#define SCI_IRQ			{ IRQ_PB11MP_SCI }
+#define PB11MP_UART0_IRQ	{ IRQ_TC11MP_UART0 }
+#define PB11MP_UART1_IRQ	{ IRQ_TC11MP_UART1 }
+#define PB11MP_UART2_IRQ	{ IRQ_PB11MP_UART2 }
+#define PB11MP_UART3_IRQ	{ IRQ_PB11MP_UART3 }
+#define PB11MP_SSP_IRQ		{ IRQ_PB11MP_SSP }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 25b2e59..293de21 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -122,27 +122,27 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  * RealView PBA8Core AMBA devices
  */
 
-#define GPIO2_IRQ		{ IRQ_PBA8_GPIO2, NO_IRQ }
-#define GPIO3_IRQ		{ IRQ_PBA8_GPIO3, NO_IRQ }
-#define AACI_IRQ		{ IRQ_PBA8_AACI, NO_IRQ }
+#define GPIO2_IRQ		{ IRQ_PBA8_GPIO2 }
+#define GPIO3_IRQ		{ IRQ_PBA8_GPIO3 }
+#define AACI_IRQ		{ IRQ_PBA8_AACI }
 #define MMCI0_IRQ		{ IRQ_PBA8_MMCI0A, IRQ_PBA8_MMCI0B }
-#define KMI0_IRQ		{ IRQ_PBA8_KMI0, NO_IRQ }
-#define KMI1_IRQ		{ IRQ_PBA8_KMI1, NO_IRQ }
-#define PBA8_SMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define MPMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define PBA8_CLCD_IRQ		{ IRQ_PBA8_CLCD, NO_IRQ }
-#define DMAC_IRQ		{ IRQ_PBA8_DMAC, NO_IRQ }
-#define SCTL_IRQ		{ NO_IRQ, NO_IRQ }
-#define PBA8_WATCHDOG_IRQ	{ IRQ_PBA8_WATCHDOG, NO_IRQ }
-#define PBA8_GPIO0_IRQ		{ IRQ_PBA8_GPIO0, NO_IRQ }
-#define GPIO1_IRQ		{ IRQ_PBA8_GPIO1, NO_IRQ }
-#define PBA8_RTC_IRQ		{ IRQ_PBA8_RTC, NO_IRQ }
-#define SCI_IRQ			{ IRQ_PBA8_SCI, NO_IRQ }
-#define PBA8_UART0_IRQ		{ IRQ_PBA8_UART0, NO_IRQ }
-#define PBA8_UART1_IRQ		{ IRQ_PBA8_UART1, NO_IRQ }
-#define PBA8_UART2_IRQ		{ IRQ_PBA8_UART2, NO_IRQ }
-#define PBA8_UART3_IRQ		{ IRQ_PBA8_UART3, NO_IRQ }
-#define PBA8_SSP_IRQ		{ IRQ_PBA8_SSP, NO_IRQ }
+#define KMI0_IRQ		{ IRQ_PBA8_KMI0 }
+#define KMI1_IRQ		{ IRQ_PBA8_KMI1 }
+#define PBA8_SMC_IRQ		{ }
+#define MPMC_IRQ		{ }
+#define PBA8_CLCD_IRQ		{ IRQ_PBA8_CLCD }
+#define DMAC_IRQ		{ IRQ_PBA8_DMAC }
+#define SCTL_IRQ		{ }
+#define PBA8_WATCHDOG_IRQ	{ IRQ_PBA8_WATCHDOG }
+#define PBA8_GPIO0_IRQ		{ IRQ_PBA8_GPIO0 }
+#define GPIO1_IRQ		{ IRQ_PBA8_GPIO1 }
+#define PBA8_RTC_IRQ		{ IRQ_PBA8_RTC }
+#define SCI_IRQ			{ IRQ_PBA8_SCI }
+#define PBA8_UART0_IRQ		{ IRQ_PBA8_UART0 }
+#define PBA8_UART1_IRQ		{ IRQ_PBA8_UART1 }
+#define PBA8_UART2_IRQ		{ IRQ_PBA8_UART2 }
+#define PBA8_UART3_IRQ		{ IRQ_PBA8_UART3 }
+#define PBA8_SSP_IRQ		{ IRQ_PBA8_SSP }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index ac71564..8e2a306 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -144,27 +144,27 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  * RealView PBXCore AMBA devices
  */
 
-#define GPIO2_IRQ		{ IRQ_PBX_GPIO2, NO_IRQ }
-#define GPIO3_IRQ		{ IRQ_PBX_GPIO3, NO_IRQ }
-#define AACI_IRQ		{ IRQ_PBX_AACI, NO_IRQ }
+#define GPIO2_IRQ		{ IRQ_PBX_GPIO2 }
+#define GPIO3_IRQ		{ IRQ_PBX_GPIO3 }
+#define AACI_IRQ		{ IRQ_PBX_AACI }
 #define MMCI0_IRQ		{ IRQ_PBX_MMCI0A, IRQ_PBX_MMCI0B }
-#define KMI0_IRQ		{ IRQ_PBX_KMI0, NO_IRQ }
-#define KMI1_IRQ		{ IRQ_PBX_KMI1, NO_IRQ }
-#define PBX_SMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define MPMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define PBX_CLCD_IRQ		{ IRQ_PBX_CLCD, NO_IRQ }
-#define DMAC_IRQ		{ IRQ_PBX_DMAC, NO_IRQ }
-#define SCTL_IRQ		{ NO_IRQ, NO_IRQ }
-#define PBX_WATCHDOG_IRQ	{ IRQ_PBX_WATCHDOG, NO_IRQ }
-#define PBX_GPIO0_IRQ		{ IRQ_PBX_GPIO0, NO_IRQ }
-#define GPIO1_IRQ		{ IRQ_PBX_GPIO1, NO_IRQ }
-#define PBX_RTC_IRQ		{ IRQ_PBX_RTC, NO_IRQ }
-#define SCI_IRQ			{ IRQ_PBX_SCI, NO_IRQ }
-#define PBX_UART0_IRQ		{ IRQ_PBX_UART0, NO_IRQ }
-#define PBX_UART1_IRQ		{ IRQ_PBX_UART1, NO_IRQ }
-#define PBX_UART2_IRQ		{ IRQ_PBX_UART2, NO_IRQ }
-#define PBX_UART3_IRQ		{ IRQ_PBX_UART3, NO_IRQ }
-#define PBX_SSP_IRQ		{ IRQ_PBX_SSP, NO_IRQ }
+#define KMI0_IRQ		{ IRQ_PBX_KMI0 }
+#define KMI1_IRQ		{ IRQ_PBX_KMI1 }
+#define PBX_SMC_IRQ		{ }
+#define MPMC_IRQ		{ }
+#define PBX_CLCD_IRQ		{ IRQ_PBX_CLCD }
+#define DMAC_IRQ		{ IRQ_PBX_DMAC }
+#define SCTL_IRQ		{ }
+#define PBX_WATCHDOG_IRQ	{ IRQ_PBX_WATCHDOG }
+#define PBX_GPIO0_IRQ		{ IRQ_PBX_GPIO0 }
+#define GPIO1_IRQ		{ IRQ_PBX_GPIO1 }
+#define PBX_RTC_IRQ		{ IRQ_PBX_RTC }
+#define SCI_IRQ			{ IRQ_PBX_SCI }
+#define PBX_UART0_IRQ		{ IRQ_PBX_UART0 }
+#define PBX_UART1_IRQ		{ IRQ_PBX_UART1 }
+#define PBX_UART2_IRQ		{ IRQ_PBX_UART2 }
+#define PBX_UART3_IRQ		{ IRQ_PBX_UART3 }
+#define PBX_SSP_IRQ		{ IRQ_PBX_SSP }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 02b7b93..358cc0b 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -582,36 +582,36 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 	.num_chipselect = 1,
 };
 
-#define AACI_IRQ	{ IRQ_AACI, NO_IRQ }
+#define AACI_IRQ	{ IRQ_AACI }
 #define MMCI0_IRQ	{ IRQ_MMCI0A,IRQ_SIC_MMCI0B }
-#define KMI0_IRQ	{ IRQ_SIC_KMI0, NO_IRQ }
-#define KMI1_IRQ	{ IRQ_SIC_KMI1, NO_IRQ }
+#define KMI0_IRQ	{ IRQ_SIC_KMI0 }
+#define KMI1_IRQ	{ IRQ_SIC_KMI1 }
 
 /*
  * These devices are connected directly to the multi-layer AHB switch
  */
-#define SMC_IRQ		{ NO_IRQ, NO_IRQ }
-#define MPMC_IRQ	{ NO_IRQ, NO_IRQ }
-#define CLCD_IRQ	{ IRQ_CLCDINT, NO_IRQ }
-#define DMAC_IRQ	{ IRQ_DMAINT, NO_IRQ }
+#define SMC_IRQ		{ }
+#define MPMC_IRQ	{ }
+#define CLCD_IRQ	{ IRQ_CLCDINT }
+#define DMAC_IRQ	{ IRQ_DMAINT }
 
 /*
  * These devices are connected via the core APB bridge
  */
-#define SCTL_IRQ	{ NO_IRQ, NO_IRQ }
-#define WATCHDOG_IRQ	{ IRQ_WDOGINT, NO_IRQ }
-#define GPIO0_IRQ	{ IRQ_GPIOINT0, NO_IRQ }
-#define GPIO1_IRQ	{ IRQ_GPIOINT1, NO_IRQ }
-#define RTC_IRQ		{ IRQ_RTCINT, NO_IRQ }
+#define SCTL_IRQ	{ }
+#define WATCHDOG_IRQ	{ IRQ_WDOGINT }
+#define GPIO0_IRQ	{ IRQ_GPIOINT0 }
+#define GPIO1_IRQ	{ IRQ_GPIOINT1 }
+#define RTC_IRQ		{ IRQ_RTCINT }
 
 /*
  * These devices are connected via the DMA APB bridge
  */
-#define SCI_IRQ		{ IRQ_SCIINT, NO_IRQ }
-#define UART0_IRQ	{ IRQ_UARTINT0, NO_IRQ }
-#define UART1_IRQ	{ IRQ_UARTINT1, NO_IRQ }
-#define UART2_IRQ	{ IRQ_UARTINT2, NO_IRQ }
-#define SSP_IRQ		{ IRQ_SSPINT, NO_IRQ }
+#define SCI_IRQ		{ IRQ_SCIINT }
+#define UART0_IRQ	{ IRQ_UARTINT0 }
+#define UART1_IRQ	{ IRQ_UARTINT1 }
+#define UART2_IRQ	{ IRQ_UARTINT2 }
+#define SSP_IRQ		{ IRQ_SSPINT }
 
 /* FPGA Primecells */
 AMBA_DEVICE(aaci,  "fpga:04", AACI,     NULL);
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 9581c19..1a5fe6e 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -58,15 +58,15 @@ static struct pl061_platform_data gpio3_plat_data = {
 	.irq_base	= IRQ_GPIO3_START,
 };
 
-#define UART3_IRQ	{ IRQ_SIC_UART3, NO_IRQ }
-#define SCI1_IRQ	{ IRQ_SIC_SCI3, NO_IRQ }
+#define UART3_IRQ	{ IRQ_SIC_UART3 }
+#define SCI1_IRQ	{ IRQ_SIC_SCI3 }
 #define MMCI1_IRQ	{ IRQ_MMCI1A, IRQ_SIC_MMCI1B }
 
 /*
  * These devices are connected via the core APB bridge
  */
-#define GPIO2_IRQ	{ IRQ_GPIOINT2, NO_IRQ }
-#define GPIO3_IRQ	{ IRQ_GPIOINT3, NO_IRQ }
+#define GPIO2_IRQ	{ IRQ_GPIOINT2 }
+#define GPIO3_IRQ	{ IRQ_GPIOINT3 }
 
 /*
  * These devices are connected via the DMA APB bridge
diff --git a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
index a34d3d4..a40468f 100644
--- a/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
+++ b/arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
@@ -35,7 +35,7 @@
  * Interrupts.  Those in {} are for AMBA devices
  */
 #define IRQ_CT_CA9X4_CLCDC	{ 76 }
-#define IRQ_CT_CA9X4_DMC	{ -1 }
+#define IRQ_CT_CA9X4_DMC	{ 0 }
 #define IRQ_CT_CA9X4_SMC	{ 77, 78 }
 #define IRQ_CT_CA9X4_TIMER0	80
 #define IRQ_CT_CA9X4_TIMER1	81
-- 
1.7.4.4

