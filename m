From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 30/31] ARM: amba: spear: use common amba device initializers
Date: Fri, 20 Jan 2012 09:32:31 +0000
Message-ID: <E1RoApj-0005GI-HJ@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-spear3xx/spear300.c |   14 ++------------
 arch/arm/mach-spear3xx/spear3xx.c |   27 ++++-----------------------
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 6fdeec9..9da50e281 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -430,18 +430,8 @@ static struct pl061_platform_data gpio1_plat_data = {
 	.irq_base	= SPEAR300_GPIO1_INT_BASE,
 };
 
-struct amba_device spear300_gpio1_device = {
-	.dev = {
-		.init_name = "gpio1",
-		.platform_data = &gpio1_plat_data,
-	},
-	.res = {
-		.start = SPEAR300_GPIO_BASE,
-		.end = SPEAR300_GPIO_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {SPEAR300_VIRQ_GPIO1},
-};
+AMBA_APB_DEVICE(spear300_gpio1, "gpio1", 0, SPEAR300_GPIO_BASE,
+	{SPEAR300_VIRQ_GPIO1}, &gpio1_plat_data);
 
 /* spear300 routines */
 void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index bc4f1c6..b1733c3 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -28,31 +28,12 @@ static struct pl061_platform_data gpio_plat_data = {
 	.irq_base	= SPEAR3XX_GPIO_INT_BASE,
 };
 
-struct amba_device spear3xx_gpio_device = {
-	.dev = {
-		.init_name = "gpio",
-		.platform_data = &gpio_plat_data,
-	},
-	.res = {
-		.start = SPEAR3XX_ICM3_GPIO_BASE,
-		.end = SPEAR3XX_ICM3_GPIO_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {SPEAR3XX_IRQ_BASIC_GPIO},
-};
+AMBA_APB_DEVICE(spear3xx_gpio, "gpio", 0, SPEAR3XX_ICM3_GPIO_BASE,
+	{SPEAR3XX_IRQ_BASIC_GPIO}, &gpio_plat_data);
 
 /* uart device registration */
-struct amba_device spear3xx_uart_device = {
-	.dev = {
-		.init_name = "uart",
-	},
-	.res = {
-		.start = SPEAR3XX_ICM1_UART_BASE,
-		.end = SPEAR3XX_ICM1_UART_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {SPEAR3XX_IRQ_UART},
-};
+AMBA_APB_DEVICE(spear3xx_uart, "uart", 0, SPEAR3XX_ICM1_UART_BASE,
+	{SPEAR3XX_IRQ_UART}, NULL);
 
 /* Do spear3xx familiy common initialization part here */
 void __init spear3xx_init(void)
-- 
1.7.4.4
