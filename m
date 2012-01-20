From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 15/31] ARM: amba: spear: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:27:29 +0000
Message-ID: <E1RoAkr-0005FH-CA@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60974 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab2ATJ1z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:27:55 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-spear3xx/spear300.c |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c |    4 ++--
 arch/arm/mach-spear6xx/spear6xx.c |   10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index a5e46b4..6fdeec9 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -440,7 +440,7 @@ struct amba_device spear300_gpio1_device = {
 		.end = SPEAR300_GPIO_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {SPEAR300_VIRQ_GPIO1, NO_IRQ},
+	.irq = {SPEAR300_VIRQ_GPIO1},
 };
 
 /* spear300 routines */
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 10af45d..bc4f1c6 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -38,7 +38,7 @@ struct amba_device spear3xx_gpio_device = {
 		.end = SPEAR3XX_ICM3_GPIO_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {SPEAR3XX_IRQ_BASIC_GPIO, NO_IRQ},
+	.irq = {SPEAR3XX_IRQ_BASIC_GPIO},
 };
 
 /* uart device registration */
@@ -51,7 +51,7 @@ struct amba_device spear3xx_uart_device = {
 		.end = SPEAR3XX_ICM1_UART_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {SPEAR3XX_IRQ_UART, NO_IRQ},
+	.irq = {SPEAR3XX_IRQ_UART},
 };
 
 /* Do spear3xx familiy common initialization part here */
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index e0f6628..b997b1b 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -34,7 +34,7 @@ struct amba_device uart_device[] = {
 			.end = SPEAR6XX_ICM1_UART0_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
-		.irq = {IRQ_UART_0, NO_IRQ},
+		.irq = {IRQ_UART_0},
 	}, {
 		.dev = {
 			.init_name = "uart1",
@@ -44,7 +44,7 @@ struct amba_device uart_device[] = {
 			.end = SPEAR6XX_ICM1_UART1_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
-		.irq = {IRQ_UART_1, NO_IRQ},
+		.irq = {IRQ_UART_1},
 	}
 };
 
@@ -73,7 +73,7 @@ struct amba_device gpio_device[] = {
 			.end = SPEAR6XX_CPU_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
-		.irq = {IRQ_LOCAL_GPIO, NO_IRQ},
+		.irq = {IRQ_LOCAL_GPIO},
 	}, {
 		.dev = {
 			.init_name = "gpio1",
@@ -84,7 +84,7 @@ struct amba_device gpio_device[] = {
 			.end = SPEAR6XX_ICM3_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
-		.irq = {IRQ_BASIC_GPIO, NO_IRQ},
+		.irq = {IRQ_BASIC_GPIO},
 	}, {
 		.dev = {
 			.init_name = "gpio2",
@@ -95,7 +95,7 @@ struct amba_device gpio_device[] = {
 			.end = SPEAR6XX_ICM2_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
-		.irq = {IRQ_APPL_GPIO, NO_IRQ},
+		.irq = {IRQ_APPL_GPIO},
 	}
 };
 
-- 
1.7.4.4

