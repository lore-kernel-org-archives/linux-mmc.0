From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/2] mach-mmp: Support for SD/MMC clock adjustment in
	brownstone
Date: Mon, 14 Feb 2011 09:44:37 -0800
Message-ID: <1771BD0F-20B5-4711-A4E8-ED0E15FDD92B@marvell.com>
References: <9C2307EC-8314-40D5-A33B-38834F0F4698@marvell.com>
 <20110214154601.GA31103@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35241 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877Ab1BNRpA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 12:45:00 -0500
In-Reply-To: <20110214154601.GA31103@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>


The two patches that use this change are enclosed -- submitted to linux-mmc mailing list.

MMP2 / PXA168 / PXA910 have private registers that allow us to fine grain adjust the
SD clock internal delay and method of feedback.  RESET_ALL clears the private
registers so they need resetting. The values needed for fine grain adjustment
depend on the board design.  Sometimes no adjustment is needed; sometimes
other values are needed.  Doing SDR50 (100 mbps) and DDR (Dual Data Rate) makes
it sometimes necessary to set these values.

One change not enclosed was the modification to sdhci.c to allow pre and post callbacks
when a reset was done.  It added call backs into the platform specific driver.

Philip

====

[PATCH 2/2] sdhci: sdhci-pxa.c: Add post reset processing for chip specific registers

RESET_ALL resets chips private registers.
Reset to values specified in board file.

depends on board specific mach-mmp/plat-pxa sdhci.h definitions

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
drivers/mmc/host/sdhci-pxa.c |   42 ++++++++++++++++++++++++++++++++++++++++++
1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 215517f..0e64d66 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -29,6 +29,13 @@

#define DRIVER_NAME     "sdhci-pxa"

+#define SD_CLOCK_AND_BURST_SIZE_SETUP   0x10A
+#define SDCLK_DELAY_MASK     0x1F
+#define SDCLK_SEL_MASK       0x1
+#define SDCLK_DELAY_SHIFT    9
+#define SDCLK_SEL_SHIFT      8
+
+
struct sdhci_pxa {
        struct sdhci_host               *host;
        struct sdhci_pxa_platdata       *pdata;
@@ -53,7 +60,42 @@ static void enable_clock(struct sdhci_host *host)
        }
}

+static void set_clock_and_burst_size(struct sdhci_host *host)
+{
+       u16 tmp;
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       pr_debug("%s:%s: adjust = %d\n",
+               __func__, mmc_hostname(host->mmc), pxa->pdata->adjust_clocks);
+
+       if (pxa->pdata->adjust_clocks) {
+               tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST = %04X, "
+                       "delay = %d, sel = %d\n",
+                       __func__, mmc_hostname(host->mmc), tmp,
+                       pxa->pdata->clk_delay, pxa->pdata->clk_select);
+               tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+               tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+               tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
+                       SDCLK_DELAY_SHIFT;
+               tmp |= (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
+                       SDCLK_SEL_SHIFT;
+               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = %04X\n",
+                       __func__, mmc_hostname(host->mmc), tmp);
+       }
+}
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+       if (mask == SDHCI_RESET_ALL) {
+               /* reset private registers */
+               set_clock_and_burst_size(host);
+       }
+}
+
static struct sdhci_ops sdhci_pxa_ops = {
+       .platform_reset_exit = platform_reset_exit,
};

/*****************************************************************************\
--
1.7.0.4

========

[PATCH] sdhci: Add support PXA168, PXA910, and MMP2 controllers

======

Select pxa controller based on CPU model: MMP2, PXA168, PXA910

Three new SoC specific files added:
sdhci-pxa168.c
sdhci-pxa910.c
sdhci-mmp2.c

These files control the platform specific behavior of the SD controller.
MMP2 and the PXAxxx controllers use different hardware registers
to control platform specific behavior. Platform flags come from
arch/mach-mmp/ files for board design (brownstone, jasper, aspenite etc)
settings (8 bit capable slot / card permanent).

quirks for SD/SoC specific behaviro defined in specific platform files
(sdhci-pxa168.c, sdhci-pxa910.c, sdhci-mmp2.c)

The correct SD controller is now shown Kconfig.

sdhci-pxa.c changed to act as a shim for the platform specific code.
Only generic operations are handled in sdhci-pxa.c. All
platform operations are passed to the platform code.

reset_enter() and reset_exit() used for silicon control.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
drivers/mmc/host/Kconfig        |   42 +++++-
drivers/mmc/host/Makefile       |    5 +-
drivers/mmc/host/sdhci-mmp2.c   |  268 ++++++++++++++++++++++++++++++
drivers/mmc/host/sdhci-pxa.c    |  154 +++---------------
drivers/mmc/host/sdhci-pxa.h    |   65 ++++++++
drivers/mmc/host/sdhci-pxa168.c |  344 +++++++++++++++++++++++++++++++++++++++
drivers/mmc/host/sdhci-pxa910.c |  273 +++++++++++++++++++++++++++++++
7 files changed, 1012 insertions(+), 139 deletions(-)
create mode 100644 drivers/mmc/host/sdhci-mmp2.c
create mode 100644 drivers/mmc/host/sdhci-pxa.h
create mode 100644 drivers/mmc/host/sdhci-pxa168.c
create mode 100644 drivers/mmc/host/sdhci-pxa910.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 21c21d2..577e7ed 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -178,18 +178,52 @@ config MMC_SDHCI_S3C

         If unsure, say N.

+
+config MMC_SDHCI_PXA_CORE
+       tristate
+       help
+         This is silent Kconfig symbol that is selected by the drivers that
+         need PXA driver base support
+
+
config MMC_SDHCI_PXA
-       tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
-       depends on ARCH_PXA || ARCH_MMP
+       tristate "Marvell MMP2 SD Host Controller support"
+       depends on CPU_MMP2
+       select MMC_SDHCI
+       select MMC_SDHCI_PXA_CORE
+       help
+         This selects the Marvell(R) MMP2 SD Host Controller.
+         If you have a MMP2 platform with SD Host Controller
+         and a card slot, say Y or M here.
+
+         If unsure, say N.
+
+config MMC_SDHCI_PXA9xx
+       tristate "Marvell PXA9xx SD Host Controller support"
+       depends on CPU_PXA910
       select MMC_SDHCI
+       select MMC_SDHCI_PXA_CORE
+       help
+         This selects the Marvell(R) PXA910 SD Host Controller.
+         If you have a PXA910 platform with SD Host Controller
+         and a card slot, say Y or M here.
+
+         If unsure, say N.
+
+config MMC_SDHCI_PXA168
+       tristate "Marvell PXA168 SD Host Controller support"
+       depends on CPU_PXA168
+       select MMC_SDHCI
+       select MMC_SDHCI_PXA_CORE
       select MMC_SDHCI_IO_ACCESSORS
       help
-         This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
-         If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
+         This selects the Marvell(R) PXA168 SD Host Controller.
+         If you have a PXA168 platform with SD Host Controller
         and a card slot, say Y or M here.

         If unsure, say N.

+
config MMC_SDHCI_SPEAR
       tristate "SDHCI support on ST SPEAr platform"
       depends on MMC_SDHCI && PLAT_SPEAR
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e834fb2..2d61850 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -8,7 +8,10 @@ obj-$(CONFIG_MMC_IMX)          += imxmmc.o
obj-$(CONFIG_MMC_MXC)          += mxcmmc.o
obj-$(CONFIG_MMC_SDHCI)                += sdhci.o
obj-$(CONFIG_MMC_SDHCI_PCI)    += sdhci-pci.o
-obj-$(CONFIG_MMC_SDHCI_PXA)    += sdhci-pxa.o
+obj-$(CONFIG_MMC_SDHCI_PXA_CORE)       += sdhci-pxa.o
+obj-$(CONFIG_MMC_SDHCI_PXA)    += sdhci-mmp2.o
+obj-$(CONFIG_MMC_SDHCI_PXA168) += sdhci-pxa168.o
+obj-$(CONFIG_MMC_SDHCI_PXA9xx) += sdhci-pxa910.o
obj-$(CONFIG_MMC_SDHCI_S3C)    += sdhci-s3c.o
obj-$(CONFIG_MMC_SDHCI_SPEAR)  += sdhci-spear.o
obj-$(CONFIG_MMC_WBSD)         += wbsd.o
diff --git a/drivers/mmc/host/sdhci-mmp2.c b/drivers/mmc/host/sdhci-mmp2.c
new file mode 100644
index 0000000..fbe5e28
--- /dev/null
+++ b/drivers/mmc/host/sdhci-mmp2.c
@@ -0,0 +1,268 @@
+/**************************************************************************
+ *
+ * Copyright (c) 2009, 2010 Marvell International Ltd.
+ *                             Philip Rakity <prakity@marvell.com>
+ *                             Mark F. Brown <markb@marvell.com>
+ *
+ * This file is part of GNU program.
+ *
+ * GNU program is free software: you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation, either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * GNU program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+ * Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************/
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <plat/sdhci.h>
+#include "sdhci-pxa.h"
+#include "sdhci.h"
+
+#define DRIVER_NAME "sdhci-mmp2"
+
+#define SD_CFG_FIFO_PARAM       0x100
+#define SDCFG_GEN_PAD_CLK_ON   (1<<6)
+
+#define SD_CLOCK_AND_BURST_SIZE_SETUP   0x10A
+#define SDCLK_DELAY_MASK     0x1F
+#define SDCLK_SEL_MASK       0x1
+#define SDCLK_DELAY_SHIFT    9
+#define SDCLK_SEL_SHIFT      8
+
+#define SD_CE_ATA_2          0x10E
+#define SDCE_MISC_INT          (1<<2)
+#define SDCE_MISC_INT_EN       (1<<1)
+
+#define DISABLE_CLOCK_GATING 0
+
+
+static int platform_mmp2_probe(struct sdhci_host *host);
+
+/*
+ * MMC spec calls for the host to send 74 clocks to the card
+ * during initialization, right after voltage stabilization.
+ * the pxa168 controller has no easy way to generate those clocks.
+ * create the clocks manually right here.
+ */
+static void generate_initial_74_clocks(struct sdhci_host *host, u8 power_mode)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+       u16 tmp;
+       int count;
+
+       if (pxa->power_mode == MMC_POWER_UP
+       && power_mode == MMC_POWER_ON) {
+
+               pr_debug("%s:%s ENTER: slot->power_mode = %d,"
+                       "ios->power_mode = %d\n",
+                       __func__,
+                       mmc_hostname(host->mmc),
+                       pxa->power_mode,
+                       power_mode);
+
+               /* set we want notice of when 74 clocks are sent */
+               tmp = readw(host->ioaddr + SD_CE_ATA_2);
+               tmp |= SDCE_MISC_INT_EN;
+               writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+               /* start sending the 74 clocks */
+               tmp = readw(host->ioaddr + SD_CFG_FIFO_PARAM);
+               tmp |= SDCFG_GEN_PAD_CLK_ON;
+               writew(tmp, host->ioaddr + SD_CFG_FIFO_PARAM);
+
+               /* slowest speed is about 100KHz or 10usec per clock */
+               udelay(740);
+               count = 0;
+#define MAX_WAIT_COUNT 5
+               while (count++ < MAX_WAIT_COUNT) {
+                       if ((readw(host->ioaddr + SD_CE_ATA_2)
+                                       & SDCE_MISC_INT) == 0)
+                               break;
+                       udelay(10);
+               }
+
+               if (count == MAX_WAIT_COUNT)
+                       printk(KERN_WARNING"%s: %s: 74 clock interrupt "
+                               "not cleared\n",
+                               __func__, mmc_hostname(host->mmc));
+               /* clear the interrupt bit if posted */
+               tmp = readw(host->ioaddr + SD_CE_ATA_2);
+               tmp |= SDCE_MISC_INT;
+               writew(tmp, host->ioaddr + SD_CE_ATA_2);
+       }
+       pxa->power_mode = power_mode;
+}
+
+static void set_clock_and_burst_size(struct sdhci_host *host)
+{
+       u16 tmp;
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       pr_debug("%s:%s: adjust = %d\n",
+               __func__, mmc_hostname(host->mmc), pxa->pdata->adjust_clocks);
+
+       if (pxa->pdata->adjust_clocks) {
+               tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST = %04X, "
+                       "delay = %d, sel = %d\n",
+                       __func__, mmc_hostname(host->mmc), tmp,
+                       pxa->pdata->clk_delay, pxa->pdata->clk_select);
+               tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+               tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+               tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
+                       SDCLK_DELAY_SHIFT;
+               tmp |= (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
+                       SDCLK_SEL_SHIFT;
+               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = %04X\n",
+                       __func__, mmc_hostname(host->mmc), tmp);
+       }
+}
+
+static void programFIFO(struct sdhci_host *host, int enable)
+{
+       unsigned short tmp;
+
+       tmp = readw(host->ioaddr + SDHCI_HOST_CONTROL_2);
+
+       if (enable)
+               tmp |= SDCTRL_2_ASYNC_INT_EN;
+       else
+               tmp &= ~SDCTRL_2_ASYNC_INT_EN;
+
+       writew(tmp, host->ioaddr + SDHCI_HOST_CONTROL_2);
+}
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+       if (mask == SDHCI_RESET_ALL) {
+               /* reset private registers */
+               programFIFO(host, DISABLE_CLOCK_GATING);
+               set_clock_and_burst_size(host);
+       }
+}
+
+
+#ifdef CONFIG_MMC_CLKGATE
+static void platform_hw_clk_gate(struct sdhci_host *host)
+{
+       int enable;
+
+       enable = host->mmc->clk_gated;
+       programFIFO(host, enable);
+       pr_debug("%s:%s: enable = %d\n",
+               __func__, mmc_hostname(host->mmc), enable);
+}
+#endif
+
+static unsigned int get_f_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       pr_debug("%s:%s f_max = %d\n",
+                       __func__, mmc_hostname(host->mmc),
+                        pxa->pdata->max_speed);
+
+       return pxa->pdata->max_speed;
+}
+
+static unsigned int set_signaling_voltage(struct sdhci_host *host,
+       unsigned int uhs)
+{
+       u16 con;
+
+       pr_debug("%s:%s\n", __func__, mmc_hostname(host->mmc));
+       /*
+        * Set V18_EN -- DDR does not work without this.
+        * does not change signaling voltage
+        */
+       con = readw(host->ioaddr + SDHCI_HOST_CONTROL_2);
+       if (uhs != MMC_SDR_MODE)
+               con |= SDCTRL_2_SDH_V18_EN;
+       else
+               con &= ~SDCTRL_2_SDH_V18_EN;
+       writew(con, host->ioaddr + SDHCI_HOST_CONTROL_2);
+       return 0;
+}
+
+struct sdhci_pxa_data sdhci_platform_data = {
+       .ops = {
+               .platform_reset_exit = platform_reset_exit,
+               .platform_send_init_74_clocks = generate_initial_74_clocks,
+               .set_signaling_voltage = set_signaling_voltage,
+               .get_f_max_clock = NULL,
+#ifdef CONFIG_MMC_CLKGATE
+               .platform_hw_clk_gate = platform_hw_clk_gate,
+#endif
+       },
+#ifdef CONFIG_MMC_CLKGATE
+       .mmc_caps = MMC_CAP_HW_CLOCK_GATING | MMC_CAP_BUS_WIDTH_TEST,
+#else
+       .mmc_caps = MMC_CAP_BUS_WIDTH_TEST,
+#endif
+       .platform_probe = platform_mmp2_probe,
+       .quirks = SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE
+               | SDHCI_QUIRK_32BIT_ADMA_SIZE
+               | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+};
+EXPORT_SYMBOL_GPL(sdhci_platform_data);
+
+static int platform_mmp2_probe(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+       struct sdhci_pxa_platdata *pdata = pxa->pdata;
+       struct sdhci_ops *p_ops;
+
+       p_ops = kmalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+       if (!p_ops) {
+               printk(KERN_ERR "no memory");
+               return -ENOMEM;
+       }
+
+       /*
+        * we cannot directly copy our operations into host->ops
+        * since it is read only.  So we do this indirectly.
+        */
+       memcpy((void *)p_ops, (void *)&sdhci_platform_data.ops,
+               sizeof(struct sdhci_ops));
+
+       if (pxa->pdata->max_speed)
+               p_ops->get_f_max_clock = get_f_max_clock;
+
+       host->quirks |= sdhci_platform_data.quirks;
+       host->mmc->caps |= sdhci_platform_data.mmc_caps;
+
+       /* If slot design supports 8 bit data, indicate this to MMC. */
+       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
+               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
+       if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+               host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+               host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+       }
+
+       pr_debug("%s:%s: host->quirks = %08X, mmc->caps = %08lX\n",
+                __func__, mmc_hostname(host->mmc),
+               host->quirks, host->mmc->caps);
+
+       memcpy((void *)host->ops, (void *)p_ops, sizeof(struct sdhci_ops));
+       kfree(p_ops);
+       return 0;
+}
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index e736727..55774cb 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -18,33 +18,21 @@
 * Refer to sdhci-s3c.c.
 */

+#include <linux/module.h>
#include <linux/delay.h>
#include <linux/platform_device.h>
#include <linux/mmc/host.h>
#include <linux/clk.h>
#include <linux/io.h>
#include <linux/err.h>
+#include <linux/slab.h>
#include <plat/sdhci.h>
+#include "sdhci-pxa.h"
+#include <mach/cputype.h>
#include "sdhci.h"

#define DRIVER_NAME    "sdhci-pxa"

-#define SD_CLOCK_AND_BURST_SIZE_SETUP   0x10A
-#define SDCLK_DELAY_MASK     0x1F
-#define SDCLK_SEL_MASK       0x1
-#define SDCLK_DELAY_SHIFT    9
-#define SDCLK_SEL_SHIFT      8
-
-#define DISABLE_CLOCK_GATING 0
-
-struct sdhci_pxa {
-       struct sdhci_host               *host;
-       struct sdhci_pxa_platdata       *pdata;
-       struct clk                      *clk;
-       struct resource                 *res;
-
-       u8                              clk_enable;
-};

/*****************************************************************************\
 *                                                                           *
@@ -61,97 +49,6 @@ static void enable_clock(struct sdhci_host *host)
       }
}

-static void set_clock_and_burst_size(struct sdhci_host *host)
-{
-       u16 tmp;
-       struct sdhci_pxa *pxa = sdhci_priv(host);
-
-       pr_debug("%s:%s: adjust = %d\n",
-               __func__, mmc_hostname(host->mmc), pxa->pdata->adjust_clocks);
-
-       if (pxa->pdata->adjust_clocks) {
-               tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
-               pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST = %04X, "
-                       "delay = %d, sel = %d\n",
-                       __func__, mmc_hostname(host->mmc), tmp,
-                       pxa->pdata->clk_delay, pxa->pdata->clk_select);
-               tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
-               tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
-               tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
-                       SDCLK_DELAY_SHIFT;
-               tmp |= (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
-                       SDCLK_SEL_SHIFT;
-               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
-               pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST_SIZE_SETUP = %04X\n",
-                       __func__, mmc_hostname(host->mmc), tmp);
-       }
-}
-
-static void programFIFO(struct sdhci_host *host, int enable)
-{
-       unsigned short tmp;
-
-       tmp = readw(host->ioaddr + SDHCI_HOST_CONTROL_2);
-
-       if (enable)
-               tmp |= SDCTRL_2_ASYNC_INT_EN;
-       else
-               tmp &= ~SDCTRL_2_ASYNC_INT_EN;
-
-       writew(tmp, host->ioaddr + SDHCI_HOST_CONTROL_2);
-}
-
-static void platform_reset_exit(struct sdhci_host *host, u8 mask)
-{
-       if (mask == SDHCI_RESET_ALL) {
-               /* reset private registers */
-               programFIFO(host, DISABLE_CLOCK_GATING);
-               set_clock_and_burst_size(host);
-       }
-}
-
-static unsigned int get_f_max_clock(struct sdhci_host *host)
-{
-       struct sdhci_pxa *pxa = sdhci_priv(host);
-
-       return pxa->pdata->max_speed;
-}
-
-static unsigned int set_signaling_voltage(struct sdhci_host *host,
-       unsigned int ddr)
-{
-       u16 con;
-
-       pr_debug("%s:%s\n", __func__, mmc_hostname(host->mmc));
-       /*
-        * Set V18_EN -- DDR does not work without this.
-        * does not change signaling voltage
-        */
-       con = readw(host->ioaddr + SDHCI_HOST_CONTROL_2);
-       con |= SDCTRL_2_SDH_V18_EN;
-       writew(con, host->ioaddr + SDHCI_HOST_CONTROL_2);
-       return 0;
-}
-
-#ifdef CONFIG_MMC_CLKGATE
-static void platform_hw_clk_gate(struct sdhci_host *host)
-{
-       int enable;
-
-       enable = host->mmc->clk_gated;
-       programFIFO(host, enable);
-}
-#endif
-
-static struct sdhci_ops sdhci_pxa_ops = {
-       .platform_reset_exit = platform_reset_exit,
-       .set_signaling_voltage = set_signaling_voltage,
-       .get_f_max_clock = NULL,
-#ifdef CONFIG_MMC_CLKGATE
-       .platform_hw_clk_gate = platform_hw_clk_gate,
-#endif
-};
-
/*****************************************************************************\
 *                                                                           *
 * Device probing/removal                                                    *
@@ -213,38 +110,23 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
       }

       host->hw_name = "MMC";
-       host->ops = &sdhci_pxa_ops;
-       host->irq = irq;
-       host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
-       host->quirks |= SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE
-               | SDHCI_QUIRK_32BIT_ADMA_SIZE
-               | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
-
-       if (pdata->quirks)
-               host->quirks |= pdata->quirks;
-
-#ifdef CONFIG_MMC_CLKGATE
-       host->mmc->caps |= MMC_CAP_HW_CLOCK_GATING | MMC_CAP_BUS_WIDTH_TEST;
-#else
-       host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST;
-#endif
-
-       /* If slot design supports 8 bit data, indicate this to MMC. */
-       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
-               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
-
-       if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
-               host->mmc->caps |= MMC_CAP_NONREMOVABLE;
-               host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+       host->ops = kmalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+       if (!host->ops) {
+               dev_err(&pdev->dev, "no memory for host->ops\n");
+               ret = -ENOMEM;
+               goto out;
       }
+       host->irq = irq;
+       host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

       /* do not rely on u-boot to enable the clocks */
       enable_clock(host);

-       if (pxa->pdata->max_speed)
-               sdhci_pxa_ops.get_f_max_clock = get_f_max_clock;
-       else
-               sdhci_pxa_ops.get_f_max_clock = NULL;
+       if (sdhci_platform_data.platform_probe) {
+               ret = sdhci_platform_data.platform_probe(host);
+               if (ret)
+                       goto out;
+       }

       ret = sdhci_add_host(host);
       if (ret) {
@@ -258,6 +140,7 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
out:
       if (host) {
               clk_put(pxa->clk);
+               kfree(host->ops);
               if (host->ioaddr)
                       iounmap(host->ioaddr);
               if (pxa->res)
@@ -290,6 +173,7 @@ static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
                                          resource_size(pxa->res));
               clk_put(pxa->clk);

+               kfree(host->ops);
               sdhci_free_host(host);
               platform_set_drvdata(pdev, NULL);
       }
@@ -297,6 +181,7 @@ static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
       return 0;
}

+
#ifdef CONFIG_PM
static int sdhci_pxa_suspend(struct platform_device *dev, pm_message_t state)
{
@@ -348,4 +233,5 @@ module_exit(sdhci_pxa_exit);

MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
+MODULE_AUTHOR("Philp Rakity <prakity@marvell.com>");
MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-pxa.h b/drivers/mmc/host/sdhci-pxa.h
new file mode 100644
index 0000000..4161fc1
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa.h
@@ -0,0 +1,65 @@
+/**************************************************************************
+ *
+ * Copyright (c) 2009, 2010 Marvell International Ltd.
+ *                             Philip Rakity <prakity@marvell.com>
+ *                             Mark F. Brown <markb@marvell.com>
+ *
+ * This file is part of GNU program.
+ *
+ * GNU program is free software: you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation, either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * GNU program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+ * Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************/
+
+/* Supports:
+ * SDHCI support for MMP2/PXA910/PXA168
+ *
+ * Refer to sdhci-s3c.c.
+ */
+
+#ifndef __SDHCI_PXA_H
+#define __SDHCI_PXA_H
+
+#include <linux/types.h>
+#include "sdhci.h"
+
+struct sdhci_pxa {
+       struct sdhci_host               *host;
+       struct sdhci_pxa_platdata       *pdata;
+       struct clk                      *clk;
+       struct resource *res;
+
+       u32             delay_in_ms;
+       u32             delay_in_us;
+       u32             delay_in_ns;
+
+       u8              clk_enable;
+       u8              power_mode;
+};
+
+struct sdhci_pxa_data {
+       struct sdhci_ops ops;
+       unsigned int quirks;
+       unsigned int mmc_caps;
+       int (*platform_probe) (struct sdhci_host *host);
+};
+
+extern struct sdhci_pxa_data sdhci_platform_data;
+extern void sdhci_free_host(struct sdhci_host *host);
+extern void sdhci_remove_host(struct sdhci_host *host, int dead);
+extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
+       size_t priv_size);
+
+#endif /* __SDHCI_PXA_H */
diff --git a/drivers/mmc/host/sdhci-pxa168.c b/drivers/mmc/host/sdhci-pxa168.c
new file mode 100644
index 0000000..e6ae146
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa168.c
@@ -0,0 +1,344 @@
+/**************************************************************************
+ *
+ * Copyright (c) 2009, 2010 Marvell International Ltd.
+ *                             Philip Rakity <prakity@marvell.com>
+ *                             Mark F. Brown <markb@marvell.com>
+ *
+ * This file is part of GNU program.
+ *
+ * GNU program is free software: you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation, either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * GNU program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+ * Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************/
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <plat/sdhci.h>
+#include "sdhci-pxa.h"
+#include "sdhci.h"
+
+#define DRIVER_NAME "sdhci-pxa168"
+
+#define SD_FIFO_PARAM          0xE0
+#define DIS_PAD_SD_CLK_GATE    (1<<10) /* Turn on/off Dynamic Clock Gating */
+
+#define SD_CLOCK_AND_BURST_SIZE_SETUP  0xE6
+#define SDCLK_DELAY_MASK       0xF
+#define SDCLK_SEL_MASK         0x3
+#define SDCLK_DELAY_SHIFT      10
+#define SDCLK_SEL_SHIFT                8
+
+#define SD_CE_ATA_2                    0xEA
+#define SDCE_MMC_WIDTH         (1<<8)
+#define SDCE_MMC_CARD          (1<<12)
+
+#define DISABLE_CLOCK_GATING 0
+
+static int platform_pxa168_probe(struct sdhci_host *host);
+
+/*
+ * MMC spec calls for the host to send 74 clocks to the card
+ * during initialization, right after voltage stabilization.
+ * the pxa168 controller has no easy way to generate those clocks.
+ * create the clocks manually right here.
+ */
+#if 0
+static void generate_init_clocks(struct sdhci_host *host, u8 power_mode)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+       struct pfn_cfg *cfg = pxa->pdata->pfn_table;
+       mfp_cfg_t clk_pin;
+       int i;
+
+
+       if (cfg == NULL) {
+               DBG("Cannot generate init clocks!\n");
+               return;
+       }
+
+       if (pxa->power_mode == MMC_POWER_UP
+       && power_mode == MMC_POWER_ON) {
+
+               DBG("%s: ENTER %s: power_mode = %d, ios_.power_mode = %d\n",
+                       __func__,
+                       mmc_hostname(host->mmc),
+                       pxa->power_mode,
+                       power_mode);
+               /* CMD/CLK pin to gpio mode.  */
+               mfp_config(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CMD), 1);
+               mfp_config(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CLK), 1);
+
+               /* ensure at least 1/2 period stable to prevent runt pulse.*/
+               udelay(3);
+
+               clk_pin = *(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CLK));
+               if (gpio_request(MFP_PIN(clk_pin), "MMC_CLK")) {
+                       printk(KERN_ERR "Cannot obtain MMC_CLK GPIO %ld\n",
+                               MFP_PIN(clk_pin));
+                       goto err;
+               }
+
+               DBG("Generating init clocks on pins CLK %ld\n",
+                       MFP_PIN(clk_pin));
+
+               for (i = 0; i < INIT_CLOCKS; i++) {
+                       gpio_direction_output(MFP_PIN(clk_pin), 0); /* low */
+                       udelay(3);
+                       gpio_direction_output(MFP_PIN(clk_pin), 1); /* high */
+                       udelay(3);
+               }
+
+               gpio_free(MFP_PIN(clk_pin));
+       }
+
+err:
+       pxa->power_mode = power_mode;
+
+       /* CMD/CLK pin back MMC mode.   */
+       mfp_config(pfn_lookup(cfg, PFN_FN, PIN_MMC_CMD), 1);
+       mfp_config(pfn_lookup(cfg, PFN_FN, PIN_MMC_CLK), 1);
+}
+#endif
+
+/*
+ * we cannot talk to controller for 8 bus cycles according to sdio spec
+ * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
+ * which is quite a LONG TIME on a fast cpu -- so delay if needed
+ */
+static void platform_specific_delay(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       mdelay(pxa->delay_in_ms);
+       udelay(pxa->delay_in_us);
+       ndelay(pxa->delay_in_ns);
+}
+
+static void set_clock(struct sdhci_host *host, unsigned int clock)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       if (clock != 0) {
+               pxa->delay_in_ns = (1000000000/clock);
+
+               /* need to delay 12 clocks for 8787/8786 */
+               /* need to delay 8 clocks for controller -- so just use 12 */
+
+               pxa->delay_in_ns = pxa->delay_in_ns * 12;
+
+               pxa->delay_in_ms = pxa->delay_in_ns / 1000000;
+               pxa->delay_in_ns = pxa->delay_in_ns % 1000000;
+               pxa->delay_in_us = pxa->delay_in_ns / 1000;
+               pxa->delay_in_ns = pxa->delay_in_ns % 1000;
+       } else {
+               pxa->delay_in_ns = 0;
+               pxa->delay_in_us = 0;
+               pxa->delay_in_ms = 0;
+       }
+}
+
+static void set_clock_and_burst_size(struct sdhci_host *host)
+{
+       u16 tmp;
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       if (pxa->pdata->adjust_clocks) {
+               tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST = %04X"
+                       ", delay = %d, sel = %d\n",
+                       __func__, mmc_hostname(host->mmc), tmp,
+                       pxa->pdata->clk_delay, pxa->pdata->clk_select);
+               tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+               tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+               tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
+                       SDCLK_DELAY_SHIFT;
+               tmp |= (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
+                       SDCLK_SEL_SHIFT;
+               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST = %04X\n",
+                       __func__, mmc_hostname(host->mmc), tmp);
+       }
+}
+
+static void programFIFO(struct sdhci_host *host, int enable)
+{
+       unsigned short tmp;
+
+       tmp = readw(host->ioaddr + SD_FIFO_PARAM);
+       if (enable)
+               tmp &= ~DIS_PAD_SD_CLK_GATE;
+       else
+               tmp |= DIS_PAD_SD_CLK_GATE;
+       writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+}
+
+static void platform_reset_enter(struct sdhci_host *host, u8 mask)
+{
+       /* Before RESET_DATA we need to wait at least 10 sd cycles */
+       if (mask == SDHCI_RESET_DATA)
+               platform_specific_delay(host);
+}
+
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+       if (mask == SDHCI_RESET_ALL) {
+               /* reset private registers */
+               programFIFO(host, DISABLE_CLOCK_GATING);
+               set_clock_and_burst_size(host);
+       }
+}
+
+
+#ifdef CONFIG_MMC_CLKGATE
+static void platform_hw_clk_gate(struct sdhci_host *host)
+{
+       int enable;
+
+       enable = host->mmc->clk_gated;
+       programFIFO(host, enable);
+       pr_debug("%s:%s: enable = %d\n",
+               __func__, mmc_hostname(host->mmc), enable);
+}
+#endif
+
+static unsigned int get_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       pr_debug("%s:%s clk_get_rate = %lu\n",
+                       __func__, mmc_hostname(host->mmc),
+                        clk_get_rate(pxa->clk));
+
+       return clk_get_rate(pxa->clk);
+}
+
+static unsigned int get_f_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       pr_debug("%s:%s f_max = %d\n",
+                       __func__, mmc_hostname(host->mmc),
+                        pxa->pdata->max_speed);
+
+       return pxa->pdata->max_speed;
+}
+
+static int platform_supports_8_bit(struct sdhci_host *host, int width)
+{
+       u16 tmp;
+
+       tmp = readw(host->ioaddr + SD_CE_ATA_2);
+       tmp |= SDCE_MMC_CARD | SDCE_MMC_WIDTH;
+       writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+       tmp = readw(host->ioaddr + SD_CE_ATA_2);
+       if (width != 8)
+               tmp &= ~(SDCE_MMC_CARD | SDCE_MMC_WIDTH);
+       else
+               tmp |= SDCE_MMC_CARD | SDCE_MMC_WIDTH;
+       writew(tmp, host->ioaddr + SD_CE_ATA_2);
+       return 0;
+}
+
+static u16 pxa168_readw(struct sdhci_host *host, int reg)
+{
+       u32 temp;
+
+       if (reg == SDHCI_HOST_VERSION) {
+               temp = readl(host->ioaddr + SDHCI_HOST_VERSION - 2) >> 16;
+               return temp & 0xffff;
+       }
+
+       return readw(host->ioaddr + reg);
+}
+
+struct sdhci_pxa_data sdhci_platform_data = {
+       .ops = {
+               .platform_reset_enter = platform_reset_enter,
+               .platform_reset_exit = platform_reset_exit,
+               .get_max_clock = get_max_clock,
+               .set_clock = set_clock,
+               .platform_specific_delay = platform_specific_delay,
+               .platform_send_init_74_clocks = NULL,
+               .get_f_max_clock = NULL,
+               .platform_8bit_width = NULL,
+#ifdef CONFIG_MMC_CLKGATE
+               .platform_hw_clk_gate = platform_hw_clk_gate,
+#endif
+               .read_w = pxa168_readw,
+       },
+#ifdef CONFIG_MMC_CLKGATE
+       .mmc_caps = MMC_CAP_HW_CLOCK_GATING | MMC_CAP_BUS_WIDTH_TEST,
+#else
+       .mmc_caps = MMC_CAP_BUS_WIDTH_TEST,
+#endif
+       .platform_probe = platform_pxa168_probe,
+       .quirks = SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE
+               | SDHCI_QUIRK_32BIT_ADMA_SIZE
+               | SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
+               | SDHCI_QUIRK_NO_HISPD_BIT | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+
+};
+EXPORT_SYMBOL_GPL(sdhci_platform_data);
+
+static int platform_pxa168_probe(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+       struct sdhci_pxa_platdata *pdata = pxa->pdata;
+       struct sdhci_ops *p_ops;
+
+       p_ops = kmalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+       if (!p_ops)
+               return -ENOMEM;
+
+       /*
+        * we cannot directly copy our operations into host->ops
+        * since it is read only.  So we do this indirectly.
+        */
+       memcpy((void *)p_ops, (void *)&sdhci_platform_data.ops,
+               sizeof(struct sdhci_ops));
+
+       if (pxa->pdata->max_speed)
+               p_ops->get_f_max_clock = get_f_max_clock;
+
+       host->quirks |= sdhci_platform_data.quirks;
+       host->mmc->caps |= sdhci_platform_data.mmc_caps;
+
+       /* If slot design supports 8 bit data, indicate this to MMC. */
+       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT) {
+               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+               p_ops->platform_8bit_width = platform_supports_8_bit;
+       }
+
+       if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+               host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+               host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+       }
+
+       pr_debug("%s:%s: host->quirks = %08X, mmc->caps = %08lX\n",
+                __func__, mmc_hostname(host->mmc),
+               host->quirks, host->mmc->caps);
+
+       memcpy((void *)host->ops, (void *)p_ops, sizeof(struct sdhci_ops));
+       kfree(p_ops);
+       return 0;
+}
diff --git a/drivers/mmc/host/sdhci-pxa910.c b/drivers/mmc/host/sdhci-pxa910.c
new file mode 100644
index 0000000..fcd80a2
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa910.c
@@ -0,0 +1,273 @@
+/**************************************************************************
+ *
+ * Copyright (c) 2009, 2010 Marvell International Ltd.
+ *                             Philip Rakity <prakity@marvell.com>
+ *                             Mark F. Brown <markb@marvell.com>
+ *
+ * This file is part of GNU program.
+ *
+ * GNU program is free software: you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation, either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * GNU program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
+ * Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************/
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <plat/sdhci.h>
+#include "sdhci-pxa.h"
+#include "sdhci.h"
+
+#define DRIVER_NAME "sdhci-pxa910"
+
+#define SD_FIFO_PARAM          0xE0
+#define DIS_PAD_SD_CLK_GATE    (1<<10) /* Turn on/off Dynamic Clock Gating */
+
+#define SD_CLOCK_AND_BURST_SIZE_SETUP  0xE6
+#define SDCLK_DELAY_MASK       0xF
+#define SDCLK_SEL_MASK         0x3
+#define SDCLK_DELAY_SHIFT      10
+#define SDCLK_SEL_SHIFT                8
+
+#define SD_CE_ATA_2            0xEA
+#define SDCE_MMC_WIDTH         (1<<8)
+#define SDCE_MMC_CARD          (1<<12)
+
+#define DISABLE_CLOCK_GATING 0
+
+static int platform_pxa910_probe(struct sdhci_host *host);
+
+/*
+ * MMC spec calls for the host to send 74 clocks to the card
+ * during initialization, right after voltage stabilization.
+ * the pxa168 controller has no easy way to generate those clocks.
+ * create the clocks manually right here.
+ */
+#if 0
+static void generate_init_clocks(struct sdhci_host *host, u8 power_mode)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+       struct pfn_cfg *cfg = pxa->pdata->pfn_table;
+       mfp_cfg_t clk_pin;
+       int i;
+
+
+       if (cfg == NULL) {
+               DBG("Cannot generate init clocks!\n");
+               return;
+       }
+
+       if (pxa->power_mode == MMC_POWER_UP
+       && power_mode == MMC_POWER_ON) {
+
+               DBG("%s: ENTER %s: power_mode = %d, ios_.power_mode = %d\n",
+                       __func__,
+                       mmc_hostname(host->mmc),
+                       pxa->power_mode,
+                       power_mode);
+               /* CMD/CLK pin to gpio mode.  */
+               mfp_config(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CMD), 1);
+               mfp_config(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CLK), 1);
+
+               /* ensure at least 1/2 period stable to prevent runt pulse.*/
+               udelay(3);
+
+               clk_pin = *(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CLK));
+               if (gpio_request(MFP_PIN(clk_pin), "MMC_CLK")) {
+                       printk(KERN_ERR "Cannot obtain MMC_CLK GPIO %ld\n",
+                               MFP_PIN(clk_pin));
+                       goto err;
+               }
+
+               DBG("Generate 74 clocks on pins CLK %ld\n", MFP_PIN(clk_pin));
+
+               for (i = 0; i < INIT_CLOCKS; i++) {
+                       gpio_direction_output(MFP_PIN(clk_pin), 0); /* low */
+                       udelay(3);
+                       gpio_direction_output(MFP_PIN(clk_pin), 1); /* high */
+                       udelay(3);
+               }
+
+               gpio_free(MFP_PIN(clk_pin));
+       }
+
+err:
+       pxa->power_mode = power_mode;
+
+       /* CMD/CLK pin back MMC mode.   */
+       mfp_config(pfn_lookup(cfg, PFN_FN, PIN_MMC_CMD), 1);
+       mfp_config(pfn_lookup(cfg, PFN_FN, PIN_MMC_CLK), 1);
+}
+#endif
+
+static void set_clock_and_burst_size(struct sdhci_host *host)
+{
+       u16 tmp;
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       if (pxa->pdata->adjust_clocks) {
+               tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST = %04X, "
+                       "delay = %d, sel = %d\n",
+                       __func__, mmc_hostname(host->mmc), tmp,
+                       pxa->pdata->clk_delay, pxa->pdata->clk_select);
+               tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+               tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+               tmp |= (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
+                       SDCLK_DELAY_SHIFT;
+               tmp |= (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
+                       SDCLK_SEL_SHIFT;
+               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST = %04X\n",
+                       __func__, mmc_hostname(host->mmc), tmp);
+       }
+}
+
+static void programFIFO(struct sdhci_host *host, int enable)
+{
+       unsigned short tmp;
+
+       tmp = readw(host->ioaddr + SD_FIFO_PARAM);
+       if (enable)
+               tmp &= ~DIS_PAD_SD_CLK_GATE;
+       else
+               tmp |= DIS_PAD_SD_CLK_GATE;
+       writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+}
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+       if (mask == SDHCI_RESET_ALL) {
+               programFIFO(host, DISABLE_CLOCK_GATING);
+               set_clock_and_burst_size(host);
+       }
+}
+
+#ifdef CONFIG_MMC_CLKGATE
+static void platform_hw_clk_gate(struct sdhci_host *host)
+{
+       int enable;
+
+       enable = host->mmc->clk_gated;
+       programFIFO(host, enable);
+}
+#endif
+
+static unsigned int get_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       pr_debug("%s:%s clk_get_rate = %lu\n",
+                       __func__, mmc_hostname(host->mmc),
+                        clk_get_rate(pxa->clk));
+
+       return clk_get_rate(pxa->clk);
+}
+
+static unsigned int get_f_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+
+       pr_debug("%s:%s f_max = %d\n",
+                       __func__, mmc_hostname(host->mmc),
+                        pxa->pdata->max_speed);
+
+       return pxa->pdata->max_speed;
+}
+
+static int platform_supports_8_bit(struct sdhci_host *host, int width)
+{
+       u16 tmp;
+
+       tmp = readw(host->ioaddr + SD_CE_ATA_2);
+       tmp |= SDCE_MMC_CARD | SDCE_MMC_WIDTH;
+       writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+       tmp = readw(host->ioaddr + SD_CE_ATA_2);
+       if (width != 8)
+               tmp &= ~(SDCE_MMC_CARD | SDCE_MMC_WIDTH);
+       else
+               tmp |= SDCE_MMC_CARD | SDCE_MMC_WIDTH;
+       writew(tmp, host->ioaddr + SD_CE_ATA_2);
+       return 0;
+}
+
+struct sdhci_pxa_data sdhci_platform_data = {
+       .ops = {
+               .platform_reset_exit = platform_reset_exit,
+               .get_max_clock = get_max_clock,
+               .platform_send_init_74_clocks = NULL,
+               .get_f_max_clock = NULL,
+               .platform_8bit_width = NULL,
+#ifdef CONFIG_MMC_CLKGATE
+               .platform_hw_clk_gate = platform_hw_clk_gate,
+#endif
+       },
+#ifdef CONFIG_MMC_CLKGATE
+       .mmc_caps = MMC_CAP_HW_CLOCK_GATING | MMC_CAP_BUS_WIDTH_TEST,
+#else
+       .mmc_caps = MMC_CAP_BUS_WIDTH_TEST,
+#endif
+       .platform_probe = platform_pxa910_probe,
+       .quirks = SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE
+               | SDHCI_QUIRK_32BIT_ADMA_SIZE
+               | SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
+               | SDHCI_QUIRK_NO_HISPD_BIT | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+};
+EXPORT_SYMBOL_GPL(sdhci_platform_data);
+
+static int platform_pxa910_probe(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa = sdhci_priv(host);
+       struct sdhci_pxa_platdata *pdata = pxa->pdata;
+       struct sdhci_ops *p_ops;
+
+       /*
+        * we cannot directly copy our operations into host->ops
+        * since it is read only.  So we do this indirectly.
+        */
+       p_ops = kmalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+       if (!p_ops)
+               return -ENOMEM;
+
+       memcpy((void *)p_ops, (void *)&sdhci_platform_data.ops,
+               sizeof(struct sdhci_ops));
+
+       host->quirks |= sdhci_platform_data.quirks;
+       host->mmc->caps |= sdhci_platform_data.mmc_caps;
+
+       /* If slot design supports 8 bit data, indicate this to MMC. */
+       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT) {
+               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+               p_ops->platform_8bit_width = platform_supports_8_bit;
+       }
+
+       if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+               host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+               host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+       }
+
+       if (pxa->pdata->max_speed)
+               p_ops->get_f_max_clock = get_f_max_clock;
+
+       memcpy((void *)host->ops, (void *)p_ops, sizeof(struct sdhci_ops));
+       kfree(p_ops);
+       return 0;
+}
--
1.7.0.4




On Feb 14, 2011, at 7:46 AM, Russell King - ARM Linux wrote:

> On Sun, Feb 13, 2011 at 10:56:22PM -0800, Philip Rakity wrote:
>>
>> Set timing for brownstone for SD/MMC cards to enable detection
>> timing adjustments are needed when speed > 25MHz
>> remove limitation on maximum speed of 25MHz
>>
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>> arch/arm/mach-mmp/brownstone.c |   10 +++++++++-
>> 1 files changed, 9 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
>> index 0e92fd7..35afe60 100644
>> --- a/arch/arm/mach-mmp/brownstone.c
>> +++ b/arch/arm/mach-mmp/brownstone.c
>> @@ -178,14 +178,22 @@ static struct i2c_board_info brownstone_twsi1_info[] = {
>> };
>>
>> static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
>> -    .max_speed      = 25000000,
>> +    .adjust_clocks  = 1,
>> +    .clk_select     = 1,
>> +    .clk_delay      = 31,
>> };
>>
>> static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
>> +    .adjust_clocks  = 1,
>> +    .clk_select     = 1,
>> +    .clk_delay      = 15,
>>      .flags          = PXA_FLAG_CARD_PERMANENT,
>> };
>>
>> static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
>> +    .adjust_clocks  = 1,
>> +    .clk_select     = 1,
>> +    .clk_delay      = 31,
>
> You create the new fields in patch 1 and then add values to them in patch 2.
> However, they remain unused, so it's impossible to see what the point of
> creating them was.

