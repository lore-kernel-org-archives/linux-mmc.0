From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/16] ARM: OMAP: Split plat/mmc.h into local headers and
 platform_data
Date: Thu, 04 Oct 2012 15:04:54 -0700
Message-ID: <20121004220454.26676.10131.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11222 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752187Ab2JDWE4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Oct 2012 18:04:56 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>

We need to remove this from plat for ARM common zImage
support.

Cc: Chris Ball <cjb@laptop.org>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-h2-mmc.c         |    5 +--
 arch/arm/mach-omap1/board-h3-mmc.c         |    3 +-
 arch/arm/mach-omap1/board-htcherald.c      |    2 +
 arch/arm/mach-omap1/board-innovator.c      |    2 +
 arch/arm/mach-omap1/board-nokia770.c       |    2 +
 arch/arm/mach-omap1/board-sx1-mmc.c        |    3 +-
 arch/arm/mach-omap1/devices.c              |    2 +
 arch/arm/mach-omap1/mmc.h                  |   18 +++++++++++
 arch/arm/mach-omap2/board-4430sdp.c        |    2 +
 arch/arm/mach-omap2/board-n8x0.c           |    2 +
 arch/arm/mach-omap2/board-omap4panda.c     |    2 +
 arch/arm/mach-omap2/board-rm680.c          |    2 +
 arch/arm/mach-omap2/hsmmc.c                |    2 +
 arch/arm/mach-omap2/mmc.h                  |   23 ++++++++++++++
 arch/arm/mach-omap2/msdi.c                 |    2 +
 arch/arm/mach-omap2/omap4-common.c         |    2 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +
 drivers/mmc/host/omap.c                    |    3 +-
 drivers/mmc/host/omap_hsmmc.c              |    2 +
 include/linux/platform_data/mmc-omap.h     |   45 +---------------------------
 24 files changed, 67 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm/mach-omap1/mmc.h
 create mode 100644 arch/arm/mach-omap2/mmc.h
 rename arch/arm/plat-omap/include/plat/mmc.h => include/linux/platform_data/mmc-omap.h (80%)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index e1362ce..7119ef2 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -13,12 +13,11 @@
  */
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
-
+#include <linux/platform_data/gpio-omap.h>
 #include <linux/i2c/tps65010.h>
 
-#include <plat/mmc.h>
-
 #include "board-h2.h"
+#include "mmc.h"
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index c74daac..17d7791 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -16,9 +16,8 @@
 
 #include <linux/i2c/tps65010.h>
 
-#include <plat/mmc.h>
-
 #include "board-h3.h"
+#include "mmc.h"
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 87ab208..f23200c 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -43,7 +43,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/omap7xx.h>
-#include <plat/mmc.h>
+#include "mmc.h"
 
 #include <mach/irqs.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 06eb4e6..2b8977f 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -36,13 +36,13 @@
 #include <../plat-omap/fpga.h>
 #include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
-#include <plat/mmc.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
 #include "iomap.h"
 #include "common.h"
+#include "mmc.h"
 
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
 #define INNOVATOR1610_ETHR_START	0x04000300
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 7d5c06d..cb72f24 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -29,13 +29,13 @@
 #include <asm/mach/map.h>
 
 #include <mach/mux.h>
-#include <plat/mmc.h>
 #include <plat/clock.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
 #include "common.h"
+#include "mmc.h"
 
 #define ADS7846_PENDOWN_GPIO	15
 
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index 5932d56..4fcf19c 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -16,9 +16,10 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
-#include <plat/mmc.h>
 #include <mach/board-sx1.h>
 
+#include "mmc.h"
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
 static int mmc_set_power(struct device *dev, int slot, int power_on,
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 552bda0..1cc4e18 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -22,7 +22,6 @@
 #include <mach/tc.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
-#include <plat/mmc.h>
 
 #include <mach/omap7xx.h>
 #include <mach/camera.h>
@@ -32,6 +31,7 @@
 
 #include "common.h"
 #include "clock.h"
+#include "mmc.h"
 
 #if defined(CONFIG_SND_SOC) || defined(CONFIG_SND_SOC_MODULE)
 
diff --git a/arch/arm/mach-omap1/mmc.h b/arch/arm/mach-omap1/mmc.h
new file mode 100644
index 0000000..39c2b13
--- /dev/null
+++ b/arch/arm/mach-omap1/mmc.h
@@ -0,0 +1,18 @@
+#include <linux/mmc/host.h>
+#include <linux/platform_data/mmc-omap.h>
+
+#define OMAP15XX_NR_MMC		1
+#define OMAP16XX_NR_MMC		2
+#define OMAP1_MMC_SIZE		0x080
+#define OMAP1_MMC1_BASE		0xfffb7800
+#define OMAP1_MMC2_BASE		0xfffb7c00	/* omap16xx only */
+
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
+				int nr_controllers);
+#else
+static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
+				int nr_controllers)
+{
+}
+#endif
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 50188b6..1de82f8 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -35,7 +35,7 @@
 
 #include "common.h"
 #include <plat/usb.h>
-#include <plat/mmc.h>
+#include "mmc.h"
 #include "omap4-keypad.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-nokia-dsi.h>
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e3e8325..b36b158 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -29,7 +29,7 @@
 #include <asm/mach-types.h>
 
 #include "common.h"
-#include <plat/mmc.h>
+#include "mmc.h"
 
 #include "mux.h"
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9d83780..9c49030 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -40,7 +40,7 @@
 
 #include "common.h"
 #include <plat/usb.h>
-#include <plat/mmc.h>
+#include "mmc.h"
 #include <video/omap-panel-tfp410.h>
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index a57ed21..4250229 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -22,7 +22,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
-#include <plat/mmc.h>
+#include "mmc.h"
 #include <plat/usb.h>
 #include <plat/gpmc.h>
 #include "common.h"
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 03ebf47..dd8e694 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -17,7 +17,7 @@
 #include <mach/hardware.h>
 #include <linux/platform_data/gpio-omap.h>
 
-#include <plat/mmc.h>
+#include "mmc.h"
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 
diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
new file mode 100644
index 0000000..0cd4b08
--- /dev/null
+++ b/arch/arm/mach-omap2/mmc.h
@@ -0,0 +1,23 @@
+#include <linux/mmc/host.h>
+#include <linux/platform_data/mmc-omap.h>
+
+#define OMAP24XX_NR_MMC		2
+#define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
+#define OMAP2_MMC1_BASE		0x4809c000
+
+#define OMAP4_MMC_REG_OFFSET	0x100
+
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
+#else
+static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
+{
+}
+#endif
+
+struct omap_hwmod;
+int omap_msdi_reset(struct omap_hwmod *oh);
+
+/* called from board-specific card detection service routine */
+extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
+					int is_closed);
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index 9e57b4a..4c80334 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -27,7 +27,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
-#include <plat/mmc.h>
+#include "mmc.h"
 
 #include "common.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 21992d8..9895574 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -26,7 +26,7 @@
 #include <asm/memblock.h>
 
 #include <plat/omap-secure.h>
-#include <plat/mmc.h>
+#include "mmc.h"
 
 #include "../plat-omap/sram.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 1821109..b913ddf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -22,7 +22,7 @@
 #include <plat/dmtimer.h>
 #include "l3_2xxx.h"
 #include "l4_2xxx.h"
-#include <plat/mmc.h>
+#include "mmc.h"
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index f902a18..bcda2fa5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -21,7 +21,7 @@
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/dmtimer.h>
-#include <plat/mmc.h>
+#include "mmc.h"
 #include "l3_2xxx.h"
 
 #include "soc.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 67f1ac4..76449f9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -21,7 +21,7 @@
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <plat/dma.h>
-#include <plat/mmc.h>
+#include "mmc.h"
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index e72ccdc..d8aa3c1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -24,7 +24,7 @@
 #include <plat/serial.h>
 #include "l3_3xxx.h"
 #include "l4_3xxx.h"
-#include <plat/mmc.h>
+#include "mmc.h"
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index d59c5ea..8364cc9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,7 +27,7 @@
 #include <plat/dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <plat/mmc.h>
+#include "mmc.h"
 #include <plat/dmtimer.h>
 #include <plat/iommu.h>
 #include "../plat-omap/common.h"
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 48ad361..e7c61b9 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -28,8 +28,9 @@
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/platform_data/mmc-omap.h>
 
-#include <plat/mmc.h>
+#include <plat/cpu.h>
 #include <plat/dma.h>
 
 #define	OMAP_MMC_REG_CMD	0x00
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 54bfd0c..85b164e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -38,8 +38,8 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_data/mmc-omap.h>
 #include <mach/hardware.h>
-#include <plat/mmc.h>
 #include <plat/cpu.h>
 
 /* OMAP HSMMC Host Controller Registers */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/include/linux/platform_data/mmc-omap.h
similarity index 80%
rename from arch/arm/plat-omap/include/plat/mmc.h
rename to include/linux/platform_data/mmc-omap.h
index 8b4e4f2..39a7abc 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -8,27 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __OMAP2_MMC_H
-#define __OMAP2_MMC_H
-
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/mmc/host.h>
-
-#include <plat/omap_hwmod.h>
-
-#define OMAP15XX_NR_MMC		1
-#define OMAP16XX_NR_MMC		2
-#define OMAP1_MMC_SIZE		0x080
-#define OMAP1_MMC1_BASE		0xfffb7800
-#define OMAP1_MMC2_BASE		0xfffb7c00	/* omap16xx only */
-
-#define OMAP24XX_NR_MMC		2
-#define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
-#define OMAP2_MMC1_BASE		0x4809c000
-
-#define OMAP4_MMC_REG_OFFSET	0x100
-
 #define OMAP_MMC_MAX_SLOTS	2
 
 /*
@@ -50,6 +29,8 @@
 #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
 #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
 
+struct mmc_card;
+
 struct omap_mmc_dev_attr {
 	u8 flags;
 };
@@ -164,25 +145,3 @@ struct omap_mmc_platform_data {
 
 	} slots[OMAP_MMC_MAX_SLOTS];
 };
-
-/* called from board-specific card detection service routine */
-extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
-					int is_closed);
-
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
-void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
-				int nr_controllers);
-void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
-#else
-static inline void omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
-				int nr_controllers)
-{
-}
-static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
-{
-}
-#endif
-
-extern int omap_msdi_reset(struct omap_hwmod *oh);
-
-#endif

