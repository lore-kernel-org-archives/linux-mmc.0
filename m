From: Simon Horman <horms@verge.net.au>
Subject: [PATCH v8 4/4] ARM: shmobile: ag5evm, ap4: Named SDHI IRQ sources
Date: Thu, 25 Aug 2011 10:27:28 +0900
Message-ID: <1314235648-8959-5-git-send-email-horms@verge.net.au>
References: <1314235648-8959-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1314235648-8959-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This allows specific (non-multiplexed) IRQ handlers to be used.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Acked-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Requires
"mmc: sdhi: Allow specific IRQ sources to use corresponding handlers."

v7
* Rework to use named IRQs

v4
* Update for corrected ordering of SH_MOBILE_SDHI_IRQ_SDCARD and
  SH_MOBILE_SDHI_IRQ_CARD_DETECT

v2
* Initial release
---
 arch/arm/mach-shmobile/board-ag5evm.c   |    6 ++++++
 arch/arm/mach-shmobile/board-mackerel.c |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index ce5c251..e100cad 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -353,14 +353,17 @@ static struct resource sdhi0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= gic_spi(83),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= gic_spi(84),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[3] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= gic_spi(85),
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -396,14 +399,17 @@ static struct resource sdhi1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= gic_spi(87),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= gic_spi(88),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[3] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= gic_spi(89),
 		.flags	= IORESOURCE_IRQ,
 	},
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index d41c01f..492274f 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1066,14 +1066,17 @@ static struct resource sdhi1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
 		.flags	= IORESOURCE_IRQ,
 	},
 	[3] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0ec0), /* SDHI1_SDHI1I2 */
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -1117,14 +1120,17 @@ static struct resource sdhi2_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
 		.start	= evt2irq(0x1200), /* SDHI2_SDHI2I0 */
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x1220), /* SDHI2_SDHI2I1 */
 		.flags	= IORESOURCE_IRQ,
 	},
 	[3] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x1240), /* SDHI2_SDHI2I2 */
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
1.7.5.4

