From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index enum
Date: Tue, 16 Aug 2011 19:11:26 +0900
Message-ID: <1313489486-831-5-git-send-email-horms@verge.net.au>
References: <1313489486-831-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313489486-831-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This is intended to make it easier to correctly order IRQs.

As suggested by Guennadi Liakhovetski.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Depends on "mmc: sdhi: Make use of per-source irq handlers"
---
 arch/arm/mach-shmobile/board-ag5evm.c   |   12 ++++++------
 arch/arm/mach-shmobile/board-mackerel.c |   18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index ce5c251..c687f67 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -352,15 +352,15 @@ static struct resource sdhi0_resources[] = {
 		.end	= 0xee1000ff,
 		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
 		.start	= gic_spi(83),
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
+	[1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] = {
 		.start	= gic_spi(84),
 		.flags	= IORESOURCE_IRQ,
 	},
-	[3] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDIO] = {
 		.start	= gic_spi(85),
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -395,15 +395,15 @@ static struct resource sdhi1_resources[] = {
 		.end	= 0xee1200ff,
 		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
 		.start	= gic_spi(87),
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
+	[1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] = {
 		.start	= gic_spi(88),
 		.flags	= IORESOURCE_IRQ,
 	},
-	[3] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDIO] = {
 		.start	= gic_spi(89),
 		.flags	= IORESOURCE_IRQ,
 	},
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index d41c01f..bc575eb 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1022,15 +1022,15 @@ static struct resource sdhi0_resources[] = {
 		.end	= 0xe68500ff,
 		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
 		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
+	[1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] = {
 		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[3] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDIO] = {
 		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -1065,15 +1065,15 @@ static struct resource sdhi1_resources[] = {
 		.end	= 0xe68600ff,
 		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
 		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
+	[1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] = {
 		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
 		.flags	= IORESOURCE_IRQ,
 	},
-	[3] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDIO] = {
 		.start	= evt2irq(0x0ec0), /* SDHI1_SDHI1I2 */
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -1116,15 +1116,15 @@ static struct resource sdhi2_resources[] = {
 		.end	= 0xe68700ff,
 		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
 		.start	= evt2irq(0x1200), /* SDHI2_SDHI2I0 */
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
+	[1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] = {
 		.start	= evt2irq(0x1220), /* SDHI2_SDHI2I1 */
 		.flags	= IORESOURCE_IRQ,
 	},
-	[3] = {
+	[1 + SH_MOBILE_SDHI_IRQ_SDIO] = {
 		.start	= evt2irq(0x1240), /* SDHI2_SDHI2I2 */
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
1.7.5.4

