From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 22/31] ARM: amba: integrator: use common amba device
 initializers
Date: Fri, 20 Jan 2012 09:29:50 +0000
Message-ID: <E1RoAn8-0005Fk-Hc@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32790 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab2ATJaR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:30:17 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/core.c          |   70 ++++++------------------------
 arch/arm/mach-integrator/integrator_cp.c |   49 ++++-----------------
 2 files changed, 22 insertions(+), 97 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 29baef9..15b87f2 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -35,67 +35,23 @@
 
 static struct amba_pl010_data integrator_uart_data;
 
-static struct amba_device rtc_device = {
-	.dev		= {
-		.init_name = "mb:15",
-	},
-	.res		= {
-		.start	= INTEGRATOR_RTC_BASE,
-		.end	= INTEGRATOR_RTC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_RTCINT },
-};
+#define INTEGRATOR_RTC_IRQ	{ IRQ_RTCINT }
+#define INTEGRATOR_UART0_IRQ	{ IRQ_UARTINT0 }
+#define INTEGRATOR_UART1_IRQ	{ IRQ_UARTINT1 }
+#define KMI0_IRQ		{ IRQ_KMIINT0 }
+#define KMI1_IRQ		{ IRQ_KMIINT1 }
 
-static struct amba_device uart0_device = {
-	.dev		= {
-		.init_name = "mb:16",
-		.platform_data = &integrator_uart_data,
-	},
-	.res		= {
-		.start	= INTEGRATOR_UART0_BASE,
-		.end	= INTEGRATOR_UART0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_UARTINT0 },
-};
+static AMBA_APB_DEVICE(rtc, "mb:15", 0,
+	INTEGRATOR_RTC_BASE, INTEGRATOR_RTC_IRQ, NULL);
 
-static struct amba_device uart1_device = {
-	.dev		= {
-		.init_name = "mb:17",
-		.platform_data = &integrator_uart_data,
-	},
-	.res		= {
-		.start	= INTEGRATOR_UART1_BASE,
-		.end	= INTEGRATOR_UART1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_UARTINT1 },
-};
+static AMBA_APB_DEVICE(uart0, "mb:16", 0,
+	INTEGRATOR_UART0_BASE, INTEGRATOR_UART0_IRQ, &integrator_uart_data);
 
-static struct amba_device kmi0_device = {
-	.dev		= {
-		.init_name = "mb:18",
-	},
-	.res		= {
-		.start	= KMI0_BASE,
-		.end	= KMI0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_KMIINT0 },
-};
+static AMBA_APB_DEVICE(uart1, "mb:17", 0,
+	INTEGRATOR_UART1_BASE, INTEGRATOR_UART1_IRQ, &integrator_uart_data);
 
-static struct amba_device kmi1_device = {
-	.dev		= {
-		.init_name = "mb:19",
-	},
-	.res		= {
-		.start	= KMI1_BASE,
-		.end	= KMI1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_KMIINT1 },
-};
+static AMBA_APB_DEVICE(kmi0, "mb:18", 0, KMI0_BASE, KMI0_IRQ, NULL);
+static AMBA_APB_DEVICE(kmi1, "mb:19", 0, KMI1_BASE, KMI1_IRQ, NULL);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&rtc_device,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index ecc08ed..be9ead4 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -347,32 +347,14 @@ static struct mmci_platform_data mmc_data = {
 	.gpio_cd	= -1,
 };
 
-static struct amba_device mmc_device = {
-	.dev		= {
-		.init_name = "mb:1c",
-		.platform_data = &mmc_data,
-	},
-	.res		= {
-		.start	= INTEGRATOR_CP_MMC_BASE,
-		.end	= INTEGRATOR_CP_MMC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_CP_MMCIINT0, IRQ_CP_MMCIINT1 },
-	.periphid	= 0,
-};
+#define INTEGRATOR_CP_MMC_IRQS	{ IRQ_CP_MMCIINT0, IRQ_CP_MMCIINT1 }
+#define INTEGRATOR_CP_AACI_IRQS	{ IRQ_CP_AACIINT }
 
-static struct amba_device aaci_device = {
-	.dev		= {
-		.init_name = "mb:1d",
-	},
-	.res		= {
-		.start	= INTEGRATOR_CP_AACI_BASE,
-		.end	= INTEGRATOR_CP_AACI_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_CP_AACIINT },
-	.periphid	= 0,
-};
+static AMBA_APB_DEVICE(mmc, "mb:1c", 0, INTEGRATOR_CP_MMC_BASE,
+	INTEGRATOR_CP_MMC_IRQS, &mmc_data);
+
+static AMBA_APB_DEVICE(aaci, "mb:1d", 0, INTEGRATOR_CP_AACI_BASE,
+	INTEGRATOR_CP_AACI_IRQS, NULL);
 
 
 /*
@@ -425,21 +407,8 @@ static struct clcd_board clcd_data = {
 	.remove		= versatile_clcd_remove_dma,
 };
 
-static struct amba_device clcd_device = {
-	.dev		= {
-		.init_name = "mb:c0",
-		.coherent_dma_mask = ~0,
-		.platform_data = &clcd_data,
-	},
-	.res		= {
-		.start	= INTCP_PA_CLCD_BASE,
-		.end	= INTCP_PA_CLCD_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.dma_mask	= ~0,
-	.irq		= { IRQ_CP_CLCDCINT },
-	.periphid	= 0,
-};
+static AMBA_AHB_DEVICE(clcd, "mb:c0", 0, INTCP_PA_CLCD_BASE,
+	{ IRQ_CP_CLCDCINT }, &clcd_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&mmc_device,
-- 
1.7.4.4

