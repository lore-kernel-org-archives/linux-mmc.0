From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 27/31] ARM: amba: lpc32xx: use common amba device
 initializers
Date: Fri, 20 Jan 2012 09:31:31 +0000
Message-ID: <E1RoAol-0005G6-5V@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-lpc32xx/phy3250.c |   32 ++++----------------------------
 1 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 025eb21..5d51c10 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -149,20 +149,8 @@ static struct clcd_board lpc32xx_clcd_data = {
 	.remove		= lpc32xx_clcd_remove,
 };
 
-static struct amba_device lpc32xx_clcd_device = {
-	.dev				= {
-		.coherent_dma_mask	= ~0,
-		.init_name		= "dev:clcd",
-		.platform_data		= &lpc32xx_clcd_data,
-	},
-	.res				= {
-		.start			= LPC32XX_LCD_BASE,
-		.end			= (LPC32XX_LCD_BASE + SZ_4K - 1),
-		.flags			= IORESOURCE_MEM,
-	},
-	.dma_mask			= ~0,
-	.irq				= {IRQ_LPC32XX_LCD},
-};
+static AMBA_AHB_DEVICE(lpc32xx_clcd, "dev:clcd", 0,
+	LPC32XX_LCD_BASE, { IRQ_LPC32XX_LCD }, &lpc32xx_clcd_data);
 
 /*
  * AMBA SSP (SPI)
@@ -191,20 +179,8 @@ static struct pl022_ssp_controller lpc32xx_ssp0_data = {
 	.enable_dma		= 0,
 };
 
-static struct amba_device lpc32xx_ssp0_device = {
-	.dev				= {
-		.coherent_dma_mask	= ~0,
-		.init_name		= "dev:ssp0",
-		.platform_data		= &lpc32xx_ssp0_data,
-	},
-	.res				= {
-		.start			= LPC32XX_SSP0_BASE,
-		.end			= (LPC32XX_SSP0_BASE + SZ_4K - 1),
-		.flags			= IORESOURCE_MEM,
-	},
-	.dma_mask			= ~0,
-	.irq				= {IRQ_LPC32XX_SSP0},
-};
+static AMBA_APB_DEVICE(lpc32xx_ssp0, "dev:ssp0", 0,
+	LPC32XX_SSP0_BASE, { IRQ_LPC32XX_SSP0 }, &lpc32xx_ssp0_data);
 
 /* AT25 driver registration */
 static int __init phy3250_spi_board_register(void)
-- 
1.7.4.4
