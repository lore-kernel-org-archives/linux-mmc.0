From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 16/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:10:14 -0800
Message-ID: <501F2432-7895-49DC-9A47-824868A4769B@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_501F2432789549DC9A47824868A4769Bmarvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38182 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752164Ab0LVHOp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:14:45 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_501F2432789549DC9A47824868A4769Bmarvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From d0941ae7069e16c906b78141e467839e4be12504 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sun, 19 Dec 2010 21:21:03 -0800
Subject: [PATCH] sdhci: Add support PXA168, PXA910, and MMP2 controllers

Add ability to select controller based on CPU model
Platform flags taken from arch/mach-mmp/ files for board design
(brownstone, jasper, aspenite etc)
quirks for platform behavior defined in specific platform files
hooks for silicon issues added
code added to print platform specific registers

Signed-off-by: Mark F. Brown <markb@marvell.com>
Signed-off-by: Philip Rakity <prakity@marvell.com>
Tested-by: Philip Rakity <prakity@marvell.com>
Tested-by: Mark F. Brown  <markb@marvell.com>
---
 drivers/mmc/host/Kconfig        |   42 +++++-
 drivers/mmc/host/Makefile       |    5 +-
 drivers/mmc/host/sdhci-mmp2.c   |  245 +++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pxa.c    |   87 +++++------
 drivers/mmc/host/sdhci-pxa.h    |   65 ++++++++
 drivers/mmc/host/sdhci-pxa168.c |  322 +++++++++++++++++++++++++++++++++++=
++++
 drivers/mmc/host/sdhci-pxa910.c |  271 ++++++++++++++++++++++++++++++++
 7 files changed, 984 insertions(+), 53 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-mmp2.c
 create mode 100644 drivers/mmc/host/sdhci-pxa.h
 create mode 100644 drivers/mmc/host/sdhci-pxa168.c
 create mode 100644 drivers/mmc/host/sdhci-pxa910.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d42fe49..d9eddbd 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -166,18 +166,52 @@ config MMC_SDHCI_S3C

          If unsure, say N.

+
+config MMC_SDHCI_PXA_CORE
+       tristate
+       help
+         This is silent Kconfig symbol that is selected by the drivers tha=
t
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
-         This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller=
.
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
index d91364d..1de1c77 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -8,7 +8,10 @@ obj-$(CONFIG_MMC_IMX)          +=3D imxmmc.o
 obj-$(CONFIG_MMC_MXC)          +=3D mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)                +=3D sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)    +=3D sdhci-pci.o
-obj-$(CONFIG_MMC_SDHCI_PXA)    +=3D sdhci-pxa.o
+obj-$(CONFIG_MMC_SDHCI_PXA_CORE)       +=3D sdhci-pxa.o
+obj-$(CONFIG_MMC_SDHCI_PXA)    +=3D sdhci-mmp2.o
+obj-$(CONFIG_MMC_SDHCI_PXA168) +=3D sdhci-pxa168.o
+obj-$(CONFIG_MMC_SDHCI_PXA9xx) +=3D sdhci-pxa910.o
 obj-$(CONFIG_MMC_SDHCI_S3C)    +=3D sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)  +=3D sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)         +=3D wbsd.o
diff --git a/drivers/mmc/host/sdhci-mmp2.c b/drivers/mmc/host/sdhci-mmp2.c
new file mode 100644
index 0000000..6824177
--- /dev/null
+++ b/drivers/mmc/host/sdhci-mmp2.c
@@ -0,0 +1,245 @@
+/*************************************************************************=
*
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Genera=
l
+ * Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************=
/
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
+#define DEBUG
+
+#define DRIVER_NAME "sdhci-mmp2"
+
+#define HOST_CTRL_2            0x3E
+#define ASYNC_INT_EN           (1 << 14)
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
+static void generate_initial_74_clocks(struct sdhci_host *host, u8 power_m=
ode)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+       u16 tmp;
+       int count;
+
+       if (pxa->power_mode =3D=3D MMC_POWER_UP
+       && power_mode =3D=3D MMC_POWER_ON) {
+
+               pr_debug("%s:%s ENTER: slot->power_mode =3D %d,"
+                       "ios->power_mode =3D %d\n",
+                       __func__,
+                       mmc_hostname(host->mmc),
+                       pxa->power_mode,
+                       power_mode);
+
+               /* set we want notice of when 74 clocks are sent */
+               tmp =3D readw(host->ioaddr + SD_CE_ATA_2);
+               tmp |=3D SDCE_MISC_INT_EN;
+               writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+               /* start sending the 74 clocks */
+               tmp =3D readw(host->ioaddr + SD_CFG_FIFO_PARAM);
+               tmp |=3D SDCFG_GEN_PAD_CLK_ON;
+               writew(tmp, host->ioaddr + SD_CFG_FIFO_PARAM);
+
+               /* slowest speed is about 100KHz or 10usec per clock */
+               udelay(740);
+               count =3D 0;
+#define MAX_WAIT_COUNT 5
+               while (count++ < MAX_WAIT_COUNT) {
+                       if ((readw(host->ioaddr + SD_CE_ATA_2)
+                                       & SDCE_MISC_INT) =3D=3D 0)
+                               break;
+                       udelay(10);
+               }
+
+               if (count =3D=3D MAX_WAIT_COUNT)
+                       printk(KERN_WARNING"%s: %s: 74 clock interrupt "
+                               "not cleared\n",
+                               __func__, mmc_hostname(host->mmc));
+               /* clear the interrupt bit if posted */
+               tmp =3D readw(host->ioaddr + SD_CE_ATA_2);
+               tmp |=3D SDCE_MISC_INT;
+               writew(tmp, host->ioaddr + SD_CE_ATA_2);
+       }
+       pxa->power_mode =3D power_mode;
+}
+
+static void set_clock_and_burst_size(struct sdhci_host *host)
+{
+       u16 tmp;
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       pr_debug("%s:%s: adjust =3D %d\n",
+               __func__, mmc_hostname(host->mmc), pxa->pdata->adjust_clock=
s);
+
+       if (pxa->pdata->adjust_clocks) {
+               tmp =3D readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP)=
;
+               pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST =3D %04X, "
+                       "delay =3D %d, sel =3D %d\n",
+                       __func__, mmc_hostname(host->mmc), tmp,
+                       pxa->pdata->clk_delay, pxa->pdata->clk_select);
+               tmp &=3D ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+               tmp &=3D ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+               tmp |=3D (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
+                       SDCLK_DELAY_SHIFT;
+               tmp |=3D (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
+                       SDCLK_SEL_SHIFT;
+               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST_SIZE_SETUP =3D %04X=
\n",
+                       __func__, mmc_hostname(host->mmc), tmp);
+       }
+}
+
+static void programFIFO(struct sdhci_host *host, int enable)
+{
+       unsigned short tmp;
+
+       tmp =3D readw(host->ioaddr + HOST_CTRL_2);
+
+       if (enable)
+               tmp |=3D ASYNC_INT_EN;
+       else
+               tmp &=3D ~ASYNC_INT_EN;
+
+       writew(tmp, host->ioaddr + HOST_CTRL_2);
+}
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+       if (mask =3D=3D SDHCI_RESET_ALL) {
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
+       enable =3D host->mmc->clk_gated;
+       programFIFO(host, enable);
+}
+#endif
+
+static unsigned int get_f_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       pr_debug("%s:%s f_max =3D %d\n",
+                       __func__, mmc_hostname(host->mmc),
+                        pxa->pdata->max_speed);
+
+       return pxa->pdata->max_speed;
+}
+
+struct sdhci_pxa_data sdhci_platform_data =3D {
+       .ops =3D {
+               .platform_reset_exit =3D platform_reset_exit,
+               .platform_send_init_74_clocks =3D generate_initial_74_clock=
s,
+               .get_f_max_clock =3D NULL,
+#ifdef CONFIG_MMC_CLKGATE
+               .platform_hw_clk_gate =3D platform_hw_clk_gate,
+#endif
+       },
+#ifdef CONFIG_MMC_CLKGATE
+       .mmc_caps =3D MMC_CAP_HW_CLOCK_GATING | MMC_CAP_BUS_WIDTH_TEST,
+#else
+       .mmc_caps =3D MMC_CAP_BUS_WIDTH_TEST,
+#endif
+       .platform_probe =3D platform_mmp2_probe,
+       .quirks =3D 0,
+};
+EXPORT_SYMBOL_GPL(sdhci_platform_data);
+
+static int platform_mmp2_probe(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+       struct sdhci_pxa_platdata *pdata =3D pxa->pdata;
+       struct sdhci_ops *p_ops;
+
+       host->quirks |=3D sdhci_platform_data.quirks;
+       host->mmc->caps |=3D sdhci_platform_data.mmc_caps;
+
+       /* If slot design supports 8 bit data, indicate this to MMC. */
+       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
+               host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
+
+       if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+               host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;
+               host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+       }
+
+       /*
+        * we cannot directly copy our operations into host->ops
+        * since it is read only.  So we do this indirectly.
+        */
+       p_ops =3D kmalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+       if (!p_ops) {
+               printk(KERN_ERR "no memory");
+               return -ENOMEM;
+       }
+
+       memcpy((void *)p_ops, (void *)&sdhci_platform_data.ops,
+               sizeof(struct sdhci_ops));
+
+       if (pxa->pdata->max_speed)
+               p_ops->get_f_max_clock =3D get_f_max_clock;
+
+       memcpy((void *)host->ops, (void *)p_ops, sizeof(struct sdhci_ops));
+       kfree(p_ops);
+       return 0;
+}
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 1a58c7b..5a02777 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -1,42 +1,46 @@
-/* linux/drivers/mmc/host/sdhci-pxa.c
+/*************************************************************************=
*
  *
- * Copyright (C) 2010 Marvell International Ltd.
+ * Copyright (c) 2009, 2010 Marvell International Ltd.
  *             Zhangfei Gao <zhangfei.gao@marvell.com>
  *             Kevin Wang <dwang4@marvell.com>
  *             Mingwei Wang <mwwang@marvell.com>
  *             Philip Rakity <prakity@marvell.com>
  *             Mark Brown <markb@marvell.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/* Supports:
- * SDHCI support for MMP2/PXA910/PXA168
+ * This file is part of GNU program.
+ *
+ * GNU program is free software: you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation, either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * GNU program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Genera=
l
+ * Public License for more details.
  *
- * Refer to sdhci-s3c.c.
- */
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************=
/

+#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/slab.h>
 #include <plat/sdhci.h>
 #include "sdhci.h"
+#include "sdhci-pxa.h"
+#include <mach/cputype.h>

 #define DRIVER_NAME    "sdhci-pxa"

-struct sdhci_pxa {
-       struct sdhci_host               *host;
-       struct sdhci_pxa_platdata       *pdata;
-       struct clk                      *clk;
-       struct resource                 *res;
-
-       u8                              clk_enable;
-};

 /*************************************************************************=
****\
  *                                                                        =
   *
@@ -53,17 +57,6 @@ static void enable_clock(struct sdhci_host *host)
        }
 }

-static unsigned int get_f_max_clock(struct sdhci_host *host)
-{
-       struct sdhci_pxa *pxa =3D sdhci_priv(host);
-
-       return pxa->pdata->max_speed;
-}
-
-static struct sdhci_ops sdhci_pxa_ops =3D {
-       .get_f_max_clock =3D NULL,
-};
-
 /*************************************************************************=
****\
  *                                                                        =
   *
  * Device probing/removal                                                 =
   *
@@ -125,29 +118,24 @@ static int __devinit sdhci_pxa_probe(struct platform_=
device *pdev)
        }

        host->hw_name =3D "MMC";
-       host->ops =3D &sdhci_pxa_ops;
-       host->irq =3D irq;
-       host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEO=
UT_VAL;
-
-       /* enable mmc bus width testing */
-       host->mmc->caps |=3D MMC_CAP_BUS_WIDTH_TEST;
-
-       /* If slot design supports 8 bit data, indicate this to MMC. */
-       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
-               host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
-
-       if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
-               host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;
-               host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+       host->ops =3D kmalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+       if (!host->ops) {
+               dev_err(&pdev->dev, "no memory for host->ops\n");
+               ret =3D -ENOMEM;
+               goto out;
        }

+       host->irq =3D irq;
+       host->quirks =3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
        /* do not rely on u-boot to enable the clocks */
        enable_clock(host);

-       if (pxa->pdata->max_speed)
-               sdhci_pxa_ops.get_f_max_clock =3D get_f_max_clock;
-       else
-               sdhci_pxa_ops.get_f_max_clock =3D NULL;
+       if (sdhci_platform_data.platform_probe) {
+               ret =3D sdhci_platform_data.platform_probe(host);
+               if (ret)
+                       goto out;
+       }

        ret =3D sdhci_add_host(host);
        if (ret) {
@@ -161,6 +149,7 @@ static int __devinit sdhci_pxa_probe(struct platform_de=
vice *pdev)
 out:
        if (host) {
                clk_put(pxa->clk);
+               kfree(host->ops);
                if (host->ioaddr)
                        iounmap(host->ioaddr);
                if (pxa->res)
@@ -193,6 +182,7 @@ static int __devexit sdhci_pxa_remove(struct platform_d=
evice *pdev)
                                           resource_size(pxa->res));
                clk_put(pxa->clk);

+               kfree(host->ops);
                sdhci_free_host(host);
                platform_set_drvdata(pdev, NULL);
        }
@@ -251,4 +241,5 @@ module_exit(sdhci_pxa_exit);

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
+/*************************************************************************=
*
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Genera=
l
+ * Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************=
/
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
diff --git a/drivers/mmc/host/sdhci-pxa168.c b/drivers/mmc/host/sdhci-pxa16=
8.c
new file mode 100644
index 0000000..8f85d65
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa168.c
@@ -0,0 +1,322 @@
+/*************************************************************************=
*
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Genera=
l
+ * Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************=
/
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
+#define DIS_PAD_SD_CLK_GATE    (1<<10) /* Turn on/off Dynamic Clock Gating=
 */
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
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+       struct pfn_cfg *cfg =3D pxa->pdata->pfn_table;
+       mfp_cfg_t clk_pin;
+       int i;
+
+
+       if (cfg =3D=3D NULL) {
+               DBG("Cannot generate init clocks!\n");
+               return;
+       }
+
+       if (pxa->power_mode =3D=3D MMC_POWER_UP
+       && power_mode =3D=3D MMC_POWER_ON) {
+
+               DBG("%s: ENTER %s: power_mode =3D %d, ios_.power_mode =3D %=
d\n",
+                       __func__,
+                       mmc_hostname(host->mmc),
+                       pxa->power_mode,
+                       power_mode);
+               /* CMD/CLK pin to gpio mode.  */
+               mfp_config(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CMD), 1);
+               mfp_config(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CLK), 1);
+
+               /* ensure at least 1/2 period stable to prevent runt pulse.=
*/
+               udelay(3);
+
+               clk_pin =3D *(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CLK));
+               if (gpio_request(MFP_PIN(clk_pin), "MMC_CLK")) {
+                       printk(KERN_ERR "Cannot obtain MMC_CLK GPIO %ld\n",
+                               MFP_PIN(clk_pin));
+                       goto err;
+               }
+
+               DBG("Generating init clocks on pins CLK %ld\n",
+                       MFP_PIN(clk_pin));
+
+               for (i =3D 0; i < INIT_CLOCKS; i++) {
+                       gpio_direction_output(MFP_PIN(clk_pin), 0); /* low =
*/
+                       udelay(3);
+                       gpio_direction_output(MFP_PIN(clk_pin), 1); /* high=
 */
+                       udelay(3);
+               }
+
+               gpio_free(MFP_PIN(clk_pin));
+       }
+
+err:
+       pxa->power_mode =3D power_mode;
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
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       mdelay(pxa->delay_in_ms);
+       udelay(pxa->delay_in_us);
+       ndelay(pxa->delay_in_ns);
+}
+
+static void set_clock(struct sdhci_host *host, unsigned int clock)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       if (clock !=3D 0) {
+               pxa->delay_in_ns =3D (1000000000/clock);
+
+               /* need to delay 12 clocks for 8787/8786 */
+               /* need to delay 8 clocks for controller -- so just use 12 =
*/
+
+               pxa->delay_in_ns =3D pxa->delay_in_ns * 12;
+
+               pxa->delay_in_ms =3D pxa->delay_in_ns / 1000000;
+               pxa->delay_in_ns =3D pxa->delay_in_ns % 1000000;
+               pxa->delay_in_us =3D pxa->delay_in_ns / 1000;
+               pxa->delay_in_ns =3D pxa->delay_in_ns % 1000;
+       } else {
+               pxa->delay_in_ns =3D 0;
+               pxa->delay_in_us =3D 0;
+               pxa->delay_in_ms =3D 0;
+       }
+}
+
+static void set_clock_and_burst_size(struct sdhci_host *host)
+{
+       u16 tmp;
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       if (pxa->pdata->adjust_clocks) {
+               tmp =3D readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP)=
;
+               pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST =3D %04X"
+                       ", delay =3D %d, sel =3D %d\n",
+                       __func__, mmc_hostname(host->mmc), tmp,
+                       pxa->pdata->clk_delay, pxa->pdata->clk_select);
+               tmp &=3D ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+               tmp &=3D ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+               tmp |=3D (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
+                       SDCLK_DELAY_SHIFT;
+               tmp |=3D (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
+                       SDCLK_SEL_SHIFT;
+               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST =3D %04X\n",
+                       __func__, mmc_hostname(host->mmc), tmp);
+       }
+}
+
+static void programFIFO(struct sdhci_host *host, int enable)
+{
+       unsigned short tmp;
+
+       tmp =3D readw(host->ioaddr + SD_FIFO_PARAM);
+       if (enable)
+               tmp &=3D ~DIS_PAD_SD_CLK_GATE;
+       else
+               tmp |=3D DIS_PAD_SD_CLK_GATE;
+       writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+}
+
+static void platform_reset_enter(struct sdhci_host *host, u8 mask)
+{
+       /* Before RESET_DATA we need to wait at least 10 sd cycles */
+       if (mask =3D=3D SDHCI_RESET_DATA)
+               platform_specific_delay(host);
+}
+
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+       if (mask =3D=3D SDHCI_RESET_ALL) {
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
+       enable =3D host->mmc->clk_gated;
+       programFIFO(host, enable);
+}
+#endif
+
+static unsigned int get_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       pr_debug("%s:%s clk_get_rate =3D %lu\n",
+                       __func__, mmc_hostname(host->mmc),
+                        clk_get_rate(pxa->clk));
+
+       return clk_get_rate(pxa->clk);
+}
+
+static unsigned int get_f_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       pr_debug("%s:%s f_max =3D %d\n",
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
+       tmp =3D readw(host->ioaddr + SD_CE_ATA_2);
+       tmp |=3D SDCE_MMC_CARD | SDCE_MMC_WIDTH;
+       writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+       tmp =3D readw(host->ioaddr + SD_CE_ATA_2);
+       if (width !=3D 8)
+               tmp &=3D ~(SDCE_MMC_CARD | SDCE_MMC_WIDTH);
+       else
+               tmp |=3D SDCE_MMC_CARD | SDCE_MMC_WIDTH;
+       writew(tmp, host->ioaddr + SD_CE_ATA_2);
+       return 0;
+}
+
+struct sdhci_pxa_data sdhci_platform_data =3D {
+       .ops =3D {
+               .platform_reset_enter =3D platform_reset_enter,
+               .platform_reset_exit =3D platform_reset_exit,
+               .get_max_clock =3D get_max_clock,
+               .set_clock =3D set_clock,
+               .platform_specific_delay =3D platform_specific_delay,
+               .platform_send_init_74_clocks =3D NULL,
+               .get_f_max_clock =3D NULL,
+               .platform_8bit_width =3D NULL,
+#ifdef CONFIG_MMC_CLKGATE
+               .platform_hw_clk_gate =3D platform_hw_clk_gate,
+#endif
+       },
+#ifdef CONFIG_MMC_CLKGATE
+       .mmc_caps =3D MMC_CAP_HW_CLOCK_GATING | MMC_CAP_BUS_WIDTH_TEST,
+#else
+       .mmc_caps =3D MMC_CAP_BUS_WIDTH_TEST,
+#endif
+       .platform_probe =3D platform_pxa168_probe,
+       .quirks =3D SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE
+               | SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_CAP_CLOCK_BASE_BROK=
EN,
+};
+EXPORT_SYMBOL_GPL(sdhci_platform_data);
+
+static int platform_pxa168_probe(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+       struct sdhci_pxa_platdata *pdata =3D pxa->pdata;
+       struct sdhci_ops *p_ops;
+
+       host->quirks |=3D sdhci_platform_data.quirks;
+       host->mmc->caps |=3D sdhci_platform_data.mmc_caps;
+
+       /*
+        * we cannot directly copy our operations into host->ops
+        * since it is read only.  So we do this indirectly.
+        */
+       p_ops =3D kmalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+       if (!p_ops)
+               return -ENOMEM;
+
+       memcpy((void *)p_ops, (void *)&sdhci_platform_data.ops,
+               sizeof(struct sdhci_ops));
+
+       /* If slot design supports 8 bit data, indicate this to MMC. */
+       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT) {
+               host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
+               p_ops->platform_8bit_width =3D platform_supports_8_bit;
+       }
+
+       if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+               host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;
+               host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+       }
+
+       if (pxa->pdata->max_speed)
+               p_ops->get_f_max_clock =3D get_f_max_clock;
+
+       memcpy((void *)host->ops, (void *)p_ops, sizeof(struct sdhci_ops));
+       kfree(p_ops);
+       return 0;
+}
diff --git a/drivers/mmc/host/sdhci-pxa910.c b/drivers/mmc/host/sdhci-pxa91=
0.c
new file mode 100644
index 0000000..282a1e0
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pxa910.c
@@ -0,0 +1,271 @@
+/*************************************************************************=
*
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Genera=
l
+ * Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ *
+ * If not, see http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
+ *
+ *************************************************************************=
/
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
+#define DIS_PAD_SD_CLK_GATE    (1<<10) /* Turn on/off Dynamic Clock Gating=
 */
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
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+       struct pfn_cfg *cfg =3D pxa->pdata->pfn_table;
+       mfp_cfg_t clk_pin;
+       int i;
+
+
+       if (cfg =3D=3D NULL) {
+               DBG("Cannot generate init clocks!\n");
+               return;
+       }
+
+       if (pxa->power_mode =3D=3D MMC_POWER_UP
+       && power_mode =3D=3D MMC_POWER_ON) {
+
+               DBG("%s: ENTER %s: power_mode =3D %d, ios_.power_mode =3D %=
d\n",
+                       __func__,
+                       mmc_hostname(host->mmc),
+                       pxa->power_mode,
+                       power_mode);
+               /* CMD/CLK pin to gpio mode.  */
+               mfp_config(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CMD), 1);
+               mfp_config(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CLK), 1);
+
+               /* ensure at least 1/2 period stable to prevent runt pulse.=
*/
+               udelay(3);
+
+               clk_pin =3D *(pfn_lookup(cfg, PFN_GPIO, PIN_MMC_CLK));
+               if (gpio_request(MFP_PIN(clk_pin), "MMC_CLK")) {
+                       printk(KERN_ERR "Cannot obtain MMC_CLK GPIO %ld\n",
+                               MFP_PIN(clk_pin));
+                       goto err;
+               }
+
+               DBG("Generate 74 clocks on pins CLK %ld\n", MFP_PIN(clk_pin=
));
+
+               for (i =3D 0; i < INIT_CLOCKS; i++) {
+                       gpio_direction_output(MFP_PIN(clk_pin), 0); /* low =
*/
+                       udelay(3);
+                       gpio_direction_output(MFP_PIN(clk_pin), 1); /* high=
 */
+                       udelay(3);
+               }
+
+               gpio_free(MFP_PIN(clk_pin));
+       }
+
+err:
+       pxa->power_mode =3D power_mode;
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
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       if (pxa->pdata->adjust_clocks) {
+               tmp =3D readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP)=
;
+               pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST =3D %04X, "
+                       "delay =3D %d, sel =3D %d\n",
+                       __func__, mmc_hostname(host->mmc), tmp,
+                       pxa->pdata->clk_delay, pxa->pdata->clk_select);
+               tmp &=3D ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
+               tmp &=3D ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
+               tmp |=3D (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
+                       SDCLK_DELAY_SHIFT;
+               tmp |=3D (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
+                       SDCLK_SEL_SHIFT;
+               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
+               pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST =3D %04X\n",
+                       __func__, mmc_hostname(host->mmc), tmp);
+       }
+}
+
+static void programFIFO(struct sdhci_host *host, int enable)
+{
+       unsigned short tmp;
+
+       tmp =3D readw(host->ioaddr + SD_FIFO_PARAM);
+       if (enable)
+               tmp &=3D ~DIS_PAD_SD_CLK_GATE;
+       else
+               tmp |=3D DIS_PAD_SD_CLK_GATE;
+       writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+}
+
+static void platform_reset_exit(struct sdhci_host *host, u8 mask)
+{
+       if (mask =3D=3D SDHCI_RESET_ALL) {
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
+       enable =3D host->mmc->clk_gated;
+       programFIFO(host, enable);
+}
+#endif
+
+static unsigned int get_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       pr_debug("%s:%s clk_get_rate =3D %lu\n",
+                       __func__, mmc_hostname(host->mmc),
+                        clk_get_rate(pxa->clk));
+
+       return clk_get_rate(pxa->clk);
+}
+
+static unsigned int get_f_max_clock(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+
+       pr_debug("%s:%s f_max =3D %d\n",
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
+       tmp =3D readw(host->ioaddr + SD_CE_ATA_2);
+       tmp |=3D SDCE_MMC_CARD | SDCE_MMC_WIDTH;
+       writew(tmp, host->ioaddr + SD_CE_ATA_2);
+
+       tmp =3D readw(host->ioaddr + SD_CE_ATA_2);
+       if (width !=3D 8)
+               tmp &=3D ~(SDCE_MMC_CARD | SDCE_MMC_WIDTH);
+       else
+               tmp |=3D SDCE_MMC_CARD | SDCE_MMC_WIDTH;
+       writew(tmp, host->ioaddr + SD_CE_ATA_2);
+       return 0;
+}
+
+struct sdhci_pxa_data sdhci_platform_data =3D {
+       .ops =3D {
+               .platform_reset_exit =3D platform_reset_exit,
+               .get_max_clock =3D get_max_clock,
+               .platform_send_init_74_clocks =3D NULL,
+               .get_f_max_clock =3D NULL,
+               .platform_8bit_width =3D NULL,
+#ifdef CONFIG_MMC_CLKGATE
+               .platform_hw_clk_gate =3D platform_hw_clk_gate,
+#endif
+       },
+#ifdef CONFIG_MMC_CLKGATE
+       .mmc_caps =3D MMC_CAP_HW_CLOCK_GATING | MMC_CAP_BUS_WIDTH_TEST,
+#else
+       .mmc_caps =3D MMC_CAP_BUS_WIDTH_TEST,
+#endif
+       .platform_probe =3D platform_pxa910_probe,
+       .quirks =3D SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE
+               | SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_CAP_CLOCK_BASE_BROK=
EN,
+};
+EXPORT_SYMBOL_GPL(sdhci_platform_data);
+
+static int platform_pxa910_probe(struct sdhci_host *host)
+{
+       struct sdhci_pxa *pxa =3D sdhci_priv(host);
+       struct sdhci_pxa_platdata *pdata =3D pxa->pdata;
+       struct sdhci_ops *p_ops;
+
+       host->quirks |=3D sdhci_platform_data.quirks;
+       host->mmc->caps |=3D sdhci_platform_data.mmc_caps;
+
+       /*
+        * we cannot directly copy our operations into host->ops
+        * since it is read only.  So we do this indirectly.
+        */
+       p_ops =3D kmalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+       if (!p_ops)
+               return -ENOMEM;
+
+       memcpy((void *)p_ops, (void *)&sdhci_platform_data.ops,
+               sizeof(struct sdhci_ops));
+
+       /* If slot design supports 8 bit data, indicate this to MMC. */
+       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT) {
+               host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
+               p_ops->platform_8bit_width =3D platform_supports_8_bit;
+       }
+
+       if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+               host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;
+               host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+       }
+
+       if (pxa->pdata->max_speed)
+               p_ops->get_f_max_clock =3D get_f_max_clock;
+
+       memcpy((void *)host->ops, (void *)p_ops, sizeof(struct sdhci_ops));
+       kfree(p_ops);
+       return 0;
+}
--
1.6.0.4

--_002_501F2432789549DC9A47824868A4769Bmarvellcom_
Content-Type: application/octet-stream;
	name="0016-sdhci-Add-support-PXA168-PXA910-and-MMP2-controll.patch"
Content-Description: 0016-sdhci-Add-support-PXA168-PXA910-and-MMP2-controll.patch
Content-Disposition: attachment;
	filename="0016-sdhci-Add-support-PXA168-PXA910-and-MMP2-controll.patch";
	size=35334; creation-date="Tue, 21 Dec 2010 23:10:17 GMT";
	modification-date="Tue, 21 Dec 2010 23:10:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkMDk0MWFlNzA2OWUxNmM5MDZiNzgxNDFlNDY3ODM5ZTRiZTEyNTA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDE5IERlYyAyMDEwIDIxOjIxOjAzIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IEFkZCBzdXBwb3J0IFBYQTE2OCwgUFhBOTEwLCBhbmQgTU1QMiBjb250cm9sbGVycwoKQWRk
IGFiaWxpdHkgdG8gc2VsZWN0IGNvbnRyb2xsZXIgYmFzZWQgb24gQ1BVIG1vZGVsClBsYXRmb3Jt
IGZsYWdzIHRha2VuIGZyb20gYXJjaC9tYWNoLW1tcC8gZmlsZXMgZm9yIGJvYXJkIGRlc2lnbgoo
YnJvd25zdG9uZSwgamFzcGVyLCBhc3Blbml0ZSBldGMpCnF1aXJrcyBmb3IgcGxhdGZvcm0gYmVo
YXZpb3IgZGVmaW5lZCBpbiBzcGVjaWZpYyBwbGF0Zm9ybSBmaWxlcwpob29rcyBmb3Igc2lsaWNv
biBpc3N1ZXMgYWRkZWQKY29kZSBhZGRlZCB0byBwcmludCBwbGF0Zm9ybSBzcGVjaWZpYyByZWdp
c3RlcnMKClNpZ25lZC1vZmYtYnk6IE1hcmsgRi4gQnJvd24gPG1hcmtiQG1hcnZlbGwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpUZXN0ZWQt
Ynk6IFBoaWxpcCBSYWtpdHkgPHByYWtpdHlAbWFydmVsbC5jb20+ClRlc3RlZC1ieTogTWFyayBG
LiBCcm93biAgPG1hcmtiQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2hvc3QvS2NvbmZp
ZyAgICAgICAgfCAgIDQyICsrKysrLQogZHJpdmVycy9tbWMvaG9zdC9NYWtlZmlsZSAgICAgICB8
ICAgIDUgKy0KIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktbW1wMi5jICAgfCAgMjQ1ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jICAgIHwg
ICA4NyArKysrKy0tLS0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuaCAgICB8ICAgNjUg
KysrKysrKysKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhMTY4LmMgfCAgMzIyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1w
eGE5MTAuYyB8ICAyNzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDcgZmlsZXMg
Y2hhbmdlZCwgOTg0IGluc2VydGlvbnMoKyksIDUzIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktbW1wMi5jCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktcHhhMTY4LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21tYy9o
b3N0L3NkaGNpLXB4YTkxMC5jCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmln
IGIvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnCmluZGV4IGQ0MmZlNDkuLmQ5ZWRkYmQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZworKysgYi9kcml2ZXJzL21tYy9ob3N0L0tj
b25maWcKQEAgLTE2NiwxOCArMTY2LDUyIEBAIGNvbmZpZyBNTUNfU0RIQ0lfUzNDCiAKIAkgIElm
IHVuc3VyZSwgc2F5IE4uCiAKKworY29uZmlnIE1NQ19TREhDSV9QWEFfQ09SRQorCXRyaXN0YXRl
CisJaGVscAorCSAgVGhpcyBpcyBzaWxlbnQgS2NvbmZpZyBzeW1ib2wgdGhhdCBpcyBzZWxlY3Rl
ZCBieSB0aGUgZHJpdmVycyB0aGF0CisJICBuZWVkIFBYQSBkcml2ZXIgYmFzZSBzdXBwb3J0CisK
KwogY29uZmlnIE1NQ19TREhDSV9QWEEKLQl0cmlzdGF0ZSAiTWFydmVsbCBQWEExNjgvUFhBOTEw
L01NUDIgU0QgSG9zdCBDb250cm9sbGVyIHN1cHBvcnQiCi0JZGVwZW5kcyBvbiBBUkNIX1BYQSB8
fCBBUkNIX01NUAorCXRyaXN0YXRlICJNYXJ2ZWxsIE1NUDIgU0QgSG9zdCBDb250cm9sbGVyIHN1
cHBvcnQiCisJZGVwZW5kcyBvbiBDUFVfTU1QMgorCXNlbGVjdCBNTUNfU0RIQ0kKKwlzZWxlY3Qg
TU1DX1NESENJX1BYQV9DT1JFCisJaGVscAorCSAgVGhpcyBzZWxlY3RzIHRoZSBNYXJ2ZWxsKFIp
IE1NUDIgU0QgSG9zdCBDb250cm9sbGVyLgorCSAgSWYgeW91IGhhdmUgYSBNTVAyIHBsYXRmb3Jt
IHdpdGggU0QgSG9zdCBDb250cm9sbGVyCisJICBhbmQgYSBjYXJkIHNsb3QsIHNheSBZIG9yIE0g
aGVyZS4KKworCSAgSWYgdW5zdXJlLCBzYXkgTi4KKworY29uZmlnIE1NQ19TREhDSV9QWEE5eHgK
Kwl0cmlzdGF0ZSAiTWFydmVsbCBQWEE5eHggU0QgSG9zdCBDb250cm9sbGVyIHN1cHBvcnQiCisJ
ZGVwZW5kcyBvbiBDUFVfUFhBOTEwCiAJc2VsZWN0IE1NQ19TREhDSQorCXNlbGVjdCBNTUNfU0RI
Q0lfUFhBX0NPUkUKKwloZWxwCisJICBUaGlzIHNlbGVjdHMgdGhlIE1hcnZlbGwoUikgUFhBOTEw
IFNEIEhvc3QgQ29udHJvbGxlci4KKwkgIElmIHlvdSBoYXZlIGEgUFhBOTEwIHBsYXRmb3JtIHdp
dGggU0QgSG9zdCBDb250cm9sbGVyCisJICBhbmQgYSBjYXJkIHNsb3QsIHNheSBZIG9yIE0gaGVy
ZS4KKworCSAgSWYgdW5zdXJlLCBzYXkgTi4KKworY29uZmlnIE1NQ19TREhDSV9QWEExNjgKKwl0
cmlzdGF0ZSAiTWFydmVsbCBQWEExNjggU0QgSG9zdCBDb250cm9sbGVyIHN1cHBvcnQiCisJZGVw
ZW5kcyBvbiBDUFVfUFhBMTY4CisJc2VsZWN0IE1NQ19TREhDSQorCXNlbGVjdCBNTUNfU0RIQ0lf
UFhBX0NPUkUKIAlzZWxlY3QgTU1DX1NESENJX0lPX0FDQ0VTU09SUwogCWhlbHAKLQkgIFRoaXMg
c2VsZWN0cyB0aGUgTWFydmVsbChSKSBQWEExNjgvUFhBOTEwL01NUDIgU0QgSG9zdCBDb250cm9s
bGVyLgotCSAgSWYgeW91IGhhdmUgYSBQWEExNjgvUFhBOTEwL01NUDIgcGxhdGZvcm0gd2l0aCBT
RCBIb3N0IENvbnRyb2xsZXIKKwkgIFRoaXMgc2VsZWN0cyB0aGUgTWFydmVsbChSKSBQWEExNjgg
U0QgSG9zdCBDb250cm9sbGVyLgorCSAgSWYgeW91IGhhdmUgYSBQWEExNjggcGxhdGZvcm0gd2l0
aCBTRCBIb3N0IENvbnRyb2xsZXIKIAkgIGFuZCBhIGNhcmQgc2xvdCwgc2F5IFkgb3IgTSBoZXJl
LgogCiAJICBJZiB1bnN1cmUsIHNheSBOLgogCisKIGNvbmZpZyBNTUNfU0RIQ0lfU1BFQVIKIAl0
cmlzdGF0ZSAiU0RIQ0kgc3VwcG9ydCBvbiBTVCBTUEVBciBwbGF0Zm9ybSIKIAlkZXBlbmRzIG9u
IE1NQ19TREhDSSAmJiBQTEFUX1NQRUFSCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L01h
a2VmaWxlIGIvZHJpdmVycy9tbWMvaG9zdC9NYWtlZmlsZQppbmRleCBkOTEzNjRkLi4xZGUxYzc3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlCisrKyBiL2RyaXZlcnMvbW1j
L2hvc3QvTWFrZWZpbGUKQEAgLTgsNyArOCwxMCBAQCBvYmotJChDT05GSUdfTU1DX0lNWCkJCSs9
IGlteG1tYy5vCiBvYmotJChDT05GSUdfTU1DX01YQykJCSs9IG14Y21tYy5vCiBvYmotJChDT05G
SUdfTU1DX1NESENJKQkJKz0gc2RoY2kubwogb2JqLSQoQ09ORklHX01NQ19TREhDSV9QQ0kpCSs9
IHNkaGNpLXBjaS5vCi1vYmotJChDT05GSUdfTU1DX1NESENJX1BYQSkJKz0gc2RoY2ktcHhhLm8K
K29iai0kKENPTkZJR19NTUNfU0RIQ0lfUFhBX0NPUkUpCSs9IHNkaGNpLXB4YS5vCitvYmotJChD
T05GSUdfTU1DX1NESENJX1BYQSkJKz0gc2RoY2ktbW1wMi5vCitvYmotJChDT05GSUdfTU1DX1NE
SENJX1BYQTE2OCkgKz0gc2RoY2ktcHhhMTY4Lm8KK29iai0kKENPTkZJR19NTUNfU0RIQ0lfUFhB
OXh4KSArPSBzZGhjaS1weGE5MTAubwogb2JqLSQoQ09ORklHX01NQ19TREhDSV9TM0MpCSs9IHNk
aGNpLXMzYy5vCiBvYmotJChDT05GSUdfTU1DX1NESENJX1NQRUFSKQkrPSBzZGhjaS1zcGVhci5v
CiBvYmotJChDT05GSUdfTU1DX1dCU0QpCQkrPSB3YnNkLm8KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktbW1wMi5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1tbXAyLmMKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNjgyNDE3NwotLS0gL2Rldi9udWxsCisr
KyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktbW1wMi5jCkBAIC0wLDAgKzEsMjQ1IEBACisvKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioKKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMDksIDIwMTAgTWFydmVsbCBJ
bnRlcm5hdGlvbmFsIEx0ZC4KKyAqCQkJCVBoaWxpcCBSYWtpdHkgPHByYWtpdHlAbWFydmVsbC5j
b20+CisgKgkJCQlNYXJrIEYuIEJyb3duIDxtYXJrYkBtYXJ2ZWxsLmNvbT4KKyAqCisgKiBUaGlz
IGZpbGUgaXMgcGFydCBvZiBHTlUgcHJvZ3JhbS4KKyAqCisgKiBHTlUgcHJvZ3JhbSBpcyBmcmVl
IHNvZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CisgKiB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieSB0aGUKKyAqIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24g
MiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIKKyAqIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uCisgKgorICogR05VIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBp
dCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisgKiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVT
UyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuIFNlZSB0aGUgR05VIEdlbmVyYWwKKyAqIFB1Ymxp
YyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogWW91IHNob3VsZCBoYXZlIHJlY2Vp
dmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKKyAqIHdp
dGggdGhpcyBwcm9ncmFtLgorICoKKyAqIElmIG5vdCwgc2VlIGh0dHA6Ly93d3cuZ251Lm9yZy9s
aWNlbnNlcy9vbGQtbGljZW5zZXMvZ3BsLTIuMC5odG1sCisgKgorICoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiov
CisKKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9k
ZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9tbWMvaG9zdC5oPgorI2luY2x1ZGUgPGxpbnV4L2Ns
ay5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+CisjaW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5j
bHVkZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CisjaW5jbHVkZSA8
cGxhdC9zZGhjaS5oPgorI2luY2x1ZGUgInNkaGNpLXB4YS5oIgorI2luY2x1ZGUgInNkaGNpLmgi
CisKKyNkZWZpbmUgREVCVUcKKworI2RlZmluZSBEUklWRVJfTkFNRSAic2RoY2ktbW1wMiIKKwor
I2RlZmluZSBIT1NUX0NUUkxfMgkJMHgzRQorI2RlZmluZSBBU1lOQ19JTlRfRU4JCSgxIDw8IDE0
KQorCisjZGVmaW5lIFNEX0NGR19GSUZPX1BBUkFNICAgICAgIDB4MTAwCisjZGVmaW5lIFNEQ0ZH
X0dFTl9QQURfQ0xLX09OCSgxPDw2KQorCisjZGVmaW5lIFNEX0NMT0NLX0FORF9CVVJTVF9TSVpF
X1NFVFVQICAgMHgxMEEKKyNkZWZpbmUgU0RDTEtfREVMQVlfTUFTSyAgICAgMHgxRgorI2RlZmlu
ZSBTRENMS19TRUxfTUFTSyAgICAgICAweDEKKyNkZWZpbmUgU0RDTEtfREVMQVlfU0hJRlQgICAg
OQorI2RlZmluZSBTRENMS19TRUxfU0hJRlQgICAgICA4CisKKyNkZWZpbmUgU0RfQ0VfQVRBXzIg
ICAgICAgICAgMHgxMEUKKyNkZWZpbmUgU0RDRV9NSVNDX0lOVAkJKDE8PDIpCisjZGVmaW5lIFNE
Q0VfTUlTQ19JTlRfRU4JKDE8PDEpCisKKyNkZWZpbmUgRElTQUJMRV9DTE9DS19HQVRJTkcgMAor
CisKK3N0YXRpYyBpbnQgcGxhdGZvcm1fbW1wMl9wcm9iZShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9z
dCk7CisKKy8qCisgKiBNTUMgc3BlYyBjYWxscyBmb3IgdGhlIGhvc3QgdG8gc2VuZCA3NCBjbG9j
a3MgdG8gdGhlIGNhcmQKKyAqIGR1cmluZyBpbml0aWFsaXphdGlvbiwgcmlnaHQgYWZ0ZXIgdm9s
dGFnZSBzdGFiaWxpemF0aW9uLgorICogdGhlIHB4YTE2OCBjb250cm9sbGVyIGhhcyBubyBlYXN5
IHdheSB0byBnZW5lcmF0ZSB0aG9zZSBjbG9ja3MuCisgKiBjcmVhdGUgdGhlIGNsb2NrcyBtYW51
YWxseSByaWdodCBoZXJlLgorICovCitzdGF0aWMgdm9pZCBnZW5lcmF0ZV9pbml0aWFsXzc0X2Ns
b2NrcyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTggcG93ZXJfbW9kZSkKK3sKKwlzdHJ1Y3Qg
c2RoY2lfcHhhICpweGEgPSBzZGhjaV9wcml2KGhvc3QpOworCXUxNiB0bXA7CisJaW50IGNvdW50
OworCisJaWYgKHB4YS0+cG93ZXJfbW9kZSA9PSBNTUNfUE9XRVJfVVAKKwkmJiBwb3dlcl9tb2Rl
ID09IE1NQ19QT1dFUl9PTikgeworCisJCXByX2RlYnVnKCIlczolcyBFTlRFUjogc2xvdC0+cG93
ZXJfbW9kZSA9ICVkLCIKKwkJCSJpb3MtPnBvd2VyX21vZGUgPSAlZFxuIiwKKwkJCV9fZnVuY19f
LAorCQkJbW1jX2hvc3RuYW1lKGhvc3QtPm1tYyksCisJCQlweGEtPnBvd2VyX21vZGUsCisJCQlw
b3dlcl9tb2RlKTsKKworCQkvKiBzZXQgd2Ugd2FudCBub3RpY2Ugb2Ygd2hlbiA3NCBjbG9ja3Mg
YXJlIHNlbnQgKi8KKwkJdG1wID0gcmVhZHcoaG9zdC0+aW9hZGRyICsgU0RfQ0VfQVRBXzIpOwor
CQl0bXAgfD0gU0RDRV9NSVNDX0lOVF9FTjsKKwkJd3JpdGV3KHRtcCwgaG9zdC0+aW9hZGRyICsg
U0RfQ0VfQVRBXzIpOworCisJCS8qIHN0YXJ0IHNlbmRpbmcgdGhlIDc0IGNsb2NrcyAqLworCQl0
bXAgPSByZWFkdyhob3N0LT5pb2FkZHIgKyBTRF9DRkdfRklGT19QQVJBTSk7CisJCXRtcCB8PSBT
RENGR19HRU5fUEFEX0NMS19PTjsKKwkJd3JpdGV3KHRtcCwgaG9zdC0+aW9hZGRyICsgU0RfQ0ZH
X0ZJRk9fUEFSQU0pOworCisJCS8qIHNsb3dlc3Qgc3BlZWQgaXMgYWJvdXQgMTAwS0h6IG9yIDEw
dXNlYyBwZXIgY2xvY2sgKi8KKwkJdWRlbGF5KDc0MCk7CisJCWNvdW50ID0gMDsKKyNkZWZpbmUg
TUFYX1dBSVRfQ09VTlQJNQorCQl3aGlsZSAoY291bnQrKyA8IE1BWF9XQUlUX0NPVU5UKSB7CisJ
CQlpZiAoKHJlYWR3KGhvc3QtPmlvYWRkciArIFNEX0NFX0FUQV8yKQorCQkJCQkmIFNEQ0VfTUlT
Q19JTlQpID09IDApCisJCQkJYnJlYWs7CisJCQl1ZGVsYXkoMTApOworCQl9CisKKwkJaWYgKGNv
dW50ID09IE1BWF9XQUlUX0NPVU5UKQorCQkJcHJpbnRrKEtFUk5fV0FSTklORyIlczogJXM6IDc0
IGNsb2NrIGludGVycnVwdCAiCisJCQkJIm5vdCBjbGVhcmVkXG4iLAorCQkJCV9fZnVuY19fLCBt
bWNfaG9zdG5hbWUoaG9zdC0+bW1jKSk7CisJCS8qIGNsZWFyIHRoZSBpbnRlcnJ1cHQgYml0IGlm
IHBvc3RlZCAqLworCQl0bXAgPSByZWFkdyhob3N0LT5pb2FkZHIgKyBTRF9DRV9BVEFfMik7CisJ
CXRtcCB8PSBTRENFX01JU0NfSU5UOworCQl3cml0ZXcodG1wLCBob3N0LT5pb2FkZHIgKyBTRF9D
RV9BVEFfMik7CisJfQorCXB4YS0+cG93ZXJfbW9kZSA9IHBvd2VyX21vZGU7Cit9CisKK3N0YXRp
YyB2b2lkIHNldF9jbG9ja19hbmRfYnVyc3Rfc2l6ZShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkK
K3sKKwl1MTYgdG1wOworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7
CisKKwlwcl9kZWJ1ZygiJXM6JXM6IGFkanVzdCA9ICVkXG4iLAorCQlfX2Z1bmNfXywgbW1jX2hv
c3RuYW1lKGhvc3QtPm1tYyksIHB4YS0+cGRhdGEtPmFkanVzdF9jbG9ja3MpOworCisJaWYgKHB4
YS0+cGRhdGEtPmFkanVzdF9jbG9ja3MpIHsKKwkJdG1wID0gcmVhZHcoaG9zdC0+aW9hZGRyICsg
U0RfQ0xPQ0tfQU5EX0JVUlNUX1NJWkVfU0VUVVApOworCQlwcl9kZWJ1ZygiJXM6JXM6IChCKSBT
RF9DTE9DS19BTkRfQlVSU1QgPSAlMDRYLCAiCisJCQkiZGVsYXkgPSAlZCwgc2VsID0gJWRcbiIs
CisJCQlfX2Z1bmNfXywgbW1jX2hvc3RuYW1lKGhvc3QtPm1tYyksIHRtcCwKKwkJCXB4YS0+cGRh
dGEtPmNsa19kZWxheSwgcHhhLT5wZGF0YS0+Y2xrX3NlbGVjdCk7CisJCXRtcCAmPSB+KFNEQ0xL
X0RFTEFZX01BU0sgPDwgU0RDTEtfREVMQVlfU0hJRlQpOworCQl0bXAgJj0gfihTRENMS19TRUxf
TUFTSyA8PCBTRENMS19TRUxfU0hJRlQpOworCQl0bXAgfD0gKHB4YS0+cGRhdGEtPmNsa19kZWxh
eSAmIFNEQ0xLX0RFTEFZX01BU0spIDw8CisJCQlTRENMS19ERUxBWV9TSElGVDsKKwkJdG1wIHw9
IChweGEtPnBkYXRhLT5jbGtfc2VsZWN0ICYgU0RDTEtfU0VMX01BU0spIDw8CisJCQlTRENMS19T
RUxfU0hJRlQ7CisJCXdyaXRldyh0bXAsIGhvc3QtPmlvYWRkciArIFNEX0NMT0NLX0FORF9CVVJT
VF9TSVpFX1NFVFVQKTsKKwkJcHJfZGVidWcoIiVzOiVzOiAoQSkgU0RfQ0xPQ0tfQU5EX0JVUlNU
X1NJWkVfU0VUVVAgPSAlMDRYXG4iLAorCQkJX19mdW5jX18sIG1tY19ob3N0bmFtZShob3N0LT5t
bWMpLCB0bXApOworCX0KK30KKworc3RhdGljIHZvaWQgcHJvZ3JhbUZJRk8oc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QsIGludCBlbmFibGUpCit7CisJdW5zaWduZWQgc2hvcnQgdG1wOworCisJdG1w
ID0gcmVhZHcoaG9zdC0+aW9hZGRyICsgSE9TVF9DVFJMXzIpOworCisJaWYgKGVuYWJsZSkKKwkJ
dG1wIHw9IEFTWU5DX0lOVF9FTjsKKwllbHNlCisJCXRtcCAmPSB+QVNZTkNfSU5UX0VOOworCisJ
d3JpdGV3KHRtcCwgaG9zdC0+aW9hZGRyICsgSE9TVF9DVFJMXzIpOworfQorCitzdGF0aWMgdm9p
ZCBwbGF0Zm9ybV9yZXNldF9leGl0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1OCBtYXNrKQor
eworCWlmIChtYXNrID09IFNESENJX1JFU0VUX0FMTCkgeworCQkvKiByZXNldCBwcml2YXRlIHJl
Z2lzdGVycyAqLworCQlwcm9ncmFtRklGTyhob3N0LCBESVNBQkxFX0NMT0NLX0dBVElORyk7CisJ
CXNldF9jbG9ja19hbmRfYnVyc3Rfc2l6ZShob3N0KTsKKwl9Cit9CisKKworI2lmZGVmIENPTkZJ
R19NTUNfQ0xLR0FURQorc3RhdGljIHZvaWQgcGxhdGZvcm1faHdfY2xrX2dhdGUoc3RydWN0IHNk
aGNpX2hvc3QgKmhvc3QpCit7CisJaW50IGVuYWJsZTsKKworCWVuYWJsZSA9IGhvc3QtPm1tYy0+
Y2xrX2dhdGVkOworCXByb2dyYW1GSUZPKGhvc3QsIGVuYWJsZSk7Cit9CisjZW5kaWYKKworc3Rh
dGljIHVuc2lnbmVkIGludCBnZXRfZl9tYXhfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Qp
Cit7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdihob3N0KTsKKworCXByX2Rl
YnVnKCIlczolcyBmX21heCA9ICVkXG4iLAorCQkJX19mdW5jX18sIG1tY19ob3N0bmFtZShob3N0
LT5tbWMpLAorCQkJIHB4YS0+cGRhdGEtPm1heF9zcGVlZCk7CisKKwlyZXR1cm4gcHhhLT5wZGF0
YS0+bWF4X3NwZWVkOworfQorCitzdHJ1Y3Qgc2RoY2lfcHhhX2RhdGEgc2RoY2lfcGxhdGZvcm1f
ZGF0YSA9IHsKKwkub3BzID0geworCQkucGxhdGZvcm1fcmVzZXRfZXhpdCA9IHBsYXRmb3JtX3Jl
c2V0X2V4aXQsCisJCS5wbGF0Zm9ybV9zZW5kX2luaXRfNzRfY2xvY2tzID0gZ2VuZXJhdGVfaW5p
dGlhbF83NF9jbG9ja3MsCisJCS5nZXRfZl9tYXhfY2xvY2sgPSBOVUxMLAorI2lmZGVmIENPTkZJ
R19NTUNfQ0xLR0FURQorCQkucGxhdGZvcm1faHdfY2xrX2dhdGUgPSBwbGF0Zm9ybV9od19jbGtf
Z2F0ZSwKKyNlbmRpZgorCX0sCisjaWZkZWYgQ09ORklHX01NQ19DTEtHQVRFCisJLm1tY19jYXBz
ID0gTU1DX0NBUF9IV19DTE9DS19HQVRJTkcgfCBNTUNfQ0FQX0JVU19XSURUSF9URVNULAorI2Vs
c2UKKwkubW1jX2NhcHMgPSBNTUNfQ0FQX0JVU19XSURUSF9URVNULAorI2VuZGlmCisJLnBsYXRm
b3JtX3Byb2JlID0gcGxhdGZvcm1fbW1wMl9wcm9iZSwKKwkucXVpcmtzID0gMCwKK307CitFWFBP
UlRfU1lNQk9MX0dQTChzZGhjaV9wbGF0Zm9ybV9kYXRhKTsKKworc3RhdGljIGludCBwbGF0Zm9y
bV9tbXAyX3Byb2JlKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQoreworCXN0cnVjdCBzZGhjaV9w
eGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSAq
cGRhdGEgPSBweGEtPnBkYXRhOworCXN0cnVjdCBzZGhjaV9vcHMgKnBfb3BzOworCisJaG9zdC0+
cXVpcmtzIHw9IHNkaGNpX3BsYXRmb3JtX2RhdGEucXVpcmtzOworCWhvc3QtPm1tYy0+Y2FwcyB8
PSBzZGhjaV9wbGF0Zm9ybV9kYXRhLm1tY19jYXBzOworCisJLyogSWYgc2xvdCBkZXNpZ24gc3Vw
cG9ydHMgOCBiaXQgZGF0YSwgaW5kaWNhdGUgdGhpcyB0byBNTUMuICovCisJaWYgKHBkYXRhLT5m
bGFncyAmIFBYQV9GTEFHX1NEXzhfQklUX0NBUEFCTEVfU0xPVCkKKwkJaG9zdC0+bW1jLT5jYXBz
IHw9IE1NQ19DQVBfOF9CSVRfREFUQTsKKworCWlmIChwZGF0YS0+ZmxhZ3MgJiBQWEFfRkxBR19D
QVJEX1BFUk1BTkVOVCkgeworCQlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9OT05SRU1PVkFC
TEU7CisJCWhvc3QtPnF1aXJrcyB8PSBTREhDSV9RVUlSS19CUk9LRU5fQ0FSRF9ERVRFQ1RJT047
CisJfQorCisJLyoKKwkgKiB3ZSBjYW5ub3QgZGlyZWN0bHkgY29weSBvdXIgb3BlcmF0aW9ucyBp
bnRvIGhvc3QtPm9wcworCSAqIHNpbmNlIGl0IGlzIHJlYWQgb25seS4gIFNvIHdlIGRvIHRoaXMg
aW5kaXJlY3RseS4KKwkgKi8KKwlwX29wcyA9IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCBzZGhjaV9v
cHMpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIXBfb3BzKSB7CisJCXByaW50ayhLRVJOX0VSUiAibm8g
bWVtb3J5Iik7CisJCXJldHVybiAtRU5PTUVNOworCX0KKworCW1lbWNweSgodm9pZCAqKXBfb3Bz
LCAodm9pZCAqKSZzZGhjaV9wbGF0Zm9ybV9kYXRhLm9wcywKKwkJc2l6ZW9mKHN0cnVjdCBzZGhj
aV9vcHMpKTsKKworCWlmIChweGEtPnBkYXRhLT5tYXhfc3BlZWQpCisJCXBfb3BzLT5nZXRfZl9t
YXhfY2xvY2sgPSBnZXRfZl9tYXhfY2xvY2s7CisKKwltZW1jcHkoKHZvaWQgKilob3N0LT5vcHMs
ICh2b2lkICopcF9vcHMsIHNpemVvZihzdHJ1Y3Qgc2RoY2lfb3BzKSk7CisJa2ZyZWUocF9vcHMp
OworCXJldHVybiAwOworfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEu
YyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMKaW5kZXggMWE1OGM3Yi4uNWEwMjc3NyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYworKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLXB4YS5jCkBAIC0xLDQyICsxLDQ2IEBACi0vKiBsaW51eC9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLXB4YS5jCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKICAqCi0gKiBDb3B5cmlnaHQg
KEMpIDIwMTAgTWFydmVsbCBJbnRlcm5hdGlvbmFsIEx0ZC4KKyAqIENvcHlyaWdodCAoYykgMjAw
OSwgMjAxMCBNYXJ2ZWxsIEludGVybmF0aW9uYWwgTHRkLgogICoJCVpoYW5nZmVpIEdhbyA8emhh
bmdmZWkuZ2FvQG1hcnZlbGwuY29tPgogICoJCUtldmluIFdhbmcgPGR3YW5nNEBtYXJ2ZWxsLmNv
bT4KICAqCQlNaW5nd2VpIFdhbmcgPG13d2FuZ0BtYXJ2ZWxsLmNvbT4KICAqCQlQaGlsaXAgUmFr
aXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgogICoJCU1hcmsgQnJvd24gPG1hcmtiQG1hcnZlbGwu
Y29tPgogICoKLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5Ci0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcwotICogcHVibGlzaGVkIGJ5IHRo
ZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCi0gKi8KLQotLyogU3VwcG9ydHM6Ci0gKiBTREhD
SSBzdXBwb3J0IGZvciBNTVAyL1BYQTkxMC9QWEExNjgKKyAqIFRoaXMgZmlsZSBpcyBwYXJ0IG9m
IEdOVSBwcm9ncmFtLgorICoKKyAqIEdOVSBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU6IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQKKyAqIHVuZGVyIHRoZSB0ZXJtcyBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZQorICog
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNl
LCBvciAoYXQgeW91cgorICogb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiBHTlUg
cHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVs
LCBidXQKKyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQg
d2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VM
QVIgUFVSUE9TRS4gU2VlIHRoZSBHTlUgR2VuZXJhbAorICogUHVibGljIExpY2Vuc2UgZm9yIG1v
cmUgZGV0YWlscy4KICAqCi0gKiBSZWZlciB0byBzZGhjaS1zM2MuYy4KLSAqLworICogWW91IHNo
b3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgYWxvbmcKKyAqIHdpdGggdGhpcyBwcm9ncmFtLgorICoKKyAqIElmIG5vdCwgc2VlIGh0dHA6
Ly93d3cuZ251Lm9yZy9saWNlbnNlcy9vbGQtbGljZW5zZXMvZ3BsLTIuMC5odG1sCisgKgorICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKiovCiAKKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxs
aW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgogI2luY2x1
ZGUgPGxpbnV4L21tYy9ob3N0Lmg+CiAjaW5jbHVkZSA8bGludXgvY2xrLmg+CiAjaW5jbHVkZSA8
bGludXgvaW8uaD4KICNpbmNsdWRlIDxsaW51eC9lcnIuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+CiAjaW5jbHVkZSA8cGxhdC9zZGhjaS5oPgogI2luY2x1ZGUgInNkaGNpLmgiCisjaW5jbHVk
ZSAic2RoY2ktcHhhLmgiCisjaW5jbHVkZSA8bWFjaC9jcHV0eXBlLmg+CiAKICNkZWZpbmUgRFJJ
VkVSX05BTUUJInNkaGNpLXB4YSIKIAotc3RydWN0IHNkaGNpX3B4YSB7Ci0Jc3RydWN0IHNkaGNp
X2hvc3QJCSpob3N0OwotCXN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEJKnBkYXRhOwotCXN0cnVj
dCBjbGsJCQkqY2xrOwotCXN0cnVjdCByZXNvdXJjZQkJCSpyZXM7Ci0KLQl1OAkJCQljbGtfZW5h
YmxlOwotfTsKIAogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqXAogICogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
CkBAIC01MywxNyArNTcsNiBAQCBzdGF0aWMgdm9pZCBlbmFibGVfY2xvY2soc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QpCiAJfQogfQogCi1zdGF0aWMgdW5zaWduZWQgaW50IGdldF9mX21heF9jbG9j
ayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKLXsKLQlzdHJ1Y3Qgc2RoY2lfcHhhICpweGEgPSBz
ZGhjaV9wcml2KGhvc3QpOwotCi0JcmV0dXJuIHB4YS0+cGRhdGEtPm1heF9zcGVlZDsKLX0KLQot
c3RhdGljIHN0cnVjdCBzZGhjaV9vcHMgc2RoY2lfcHhhX29wcyA9IHsKLQkuZ2V0X2ZfbWF4X2Ns
b2NrID0gTlVMTCwKLX07Ci0KIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKlwKICAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKgogICogRGV2aWNlIHByb2JpbmcvcmVtb3ZhbCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqCkBAIC0xMjUsMjkgKzExOCwyNCBAQCBzdGF0
aWMgaW50IF9fZGV2aW5pdCBzZGhjaV9weGFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKIAl9CiAKIAlob3N0LT5od19uYW1lID0gIk1NQyI7Ci0JaG9zdC0+b3BzID0gJnNkaGNp
X3B4YV9vcHM7Ci0JaG9zdC0+aXJxID0gaXJxOwotCWhvc3QtPnF1aXJrcyA9IFNESENJX1FVSVJL
X0JST0tFTl9BRE1BIHwgU0RIQ0lfUVVJUktfQlJPS0VOX1RJTUVPVVRfVkFMOwotCi0JLyogZW5h
YmxlIG1tYyBidXMgd2lkdGggdGVzdGluZyAqLwotCWhvc3QtPm1tYy0+Y2FwcyB8PSBNTUNfQ0FQ
X0JVU19XSURUSF9URVNUOwotCi0JLyogSWYgc2xvdCBkZXNpZ24gc3VwcG9ydHMgOCBiaXQgZGF0
YSwgaW5kaWNhdGUgdGhpcyB0byBNTUMuICovCi0JaWYgKHBkYXRhLT5mbGFncyAmIFBYQV9GTEFH
X1NEXzhfQklUX0NBUEFCTEVfU0xPVCkKLQkJaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19DQVBfOF9C
SVRfREFUQTsKLQotCWlmIChwZGF0YS0+ZmxhZ3MgJiBQWEFfRkxBR19DQVJEX1BFUk1BTkVOVCkg
ewotCQlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9OT05SRU1PVkFCTEU7Ci0JCWhvc3QtPnF1
aXJrcyB8PSBTREhDSV9RVUlSS19CUk9LRU5fQ0FSRF9ERVRFQ1RJT047CisJaG9zdC0+b3BzID0g
a21hbGxvYyhzaXplb2Yoc3RydWN0IHNkaGNpX29wcyksIEdGUF9LRVJORUwpOworCWlmICghaG9z
dC0+b3BzKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIG1lbW9yeSBmb3IgaG9zdC0+b3Bz
XG4iKTsKKwkJcmV0ID0gLUVOT01FTTsKKwkJZ290byBvdXQ7CiAJfQogCisJaG9zdC0+aXJxID0g
aXJxOworCWhvc3QtPnF1aXJrcyA9IFNESENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTDsKKwog
CS8qIGRvIG5vdCByZWx5IG9uIHUtYm9vdCB0byBlbmFibGUgdGhlIGNsb2NrcyAqLwogCWVuYWJs
ZV9jbG9jayhob3N0KTsKIAotCWlmIChweGEtPnBkYXRhLT5tYXhfc3BlZWQpCi0JCXNkaGNpX3B4
YV9vcHMuZ2V0X2ZfbWF4X2Nsb2NrID0gZ2V0X2ZfbWF4X2Nsb2NrOwotCWVsc2UKLQkJc2RoY2lf
cHhhX29wcy5nZXRfZl9tYXhfY2xvY2sgPSBOVUxMOworCWlmIChzZGhjaV9wbGF0Zm9ybV9kYXRh
LnBsYXRmb3JtX3Byb2JlKSB7CisJCXJldCA9IHNkaGNpX3BsYXRmb3JtX2RhdGEucGxhdGZvcm1f
cHJvYmUoaG9zdCk7CisJCWlmIChyZXQpCisJCQlnb3RvIG91dDsKKwl9CiAKIAlyZXQgPSBzZGhj
aV9hZGRfaG9zdChob3N0KTsKIAlpZiAocmV0KSB7CkBAIC0xNjEsNiArMTQ5LDcgQEAgc3RhdGlj
IGludCBfX2RldmluaXQgc2RoY2lfcHhhX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCiBvdXQ6CiAJaWYgKGhvc3QpIHsKIAkJY2xrX3B1dChweGEtPmNsayk7CisJCWtmcmVlKGhv
c3QtPm9wcyk7CiAJCWlmIChob3N0LT5pb2FkZHIpCiAJCQlpb3VubWFwKGhvc3QtPmlvYWRkcik7
CiAJCWlmIChweGEtPnJlcykKQEAgLTE5Myw2ICsxODIsNyBAQCBzdGF0aWMgaW50IF9fZGV2ZXhp
dCBzZGhjaV9weGFfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCQkJCSAg
IHJlc291cmNlX3NpemUocHhhLT5yZXMpKTsKIAkJY2xrX3B1dChweGEtPmNsayk7CiAKKwkJa2Zy
ZWUoaG9zdC0+b3BzKTsKIAkJc2RoY2lfZnJlZV9ob3N0KGhvc3QpOwogCQlwbGF0Zm9ybV9zZXRf
ZHJ2ZGF0YShwZGV2LCBOVUxMKTsKIAl9CkBAIC0yNTEsNCArMjQxLDUgQEAgbW9kdWxlX2V4aXQo
c2RoY2lfcHhhX2V4aXQpOwogCiBNT0RVTEVfREVTQ1JJUFRJT04oIlNESCBjb250cm9sbGVyIGRy
aXZlciBmb3IgUFhBMTY4L1BYQTkxMC9NTVAyIik7CiBNT0RVTEVfQVVUSE9SKCJaaGFuZ2ZlaSBH
YW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4iKTsKK01PRFVMRV9BVVRIT1IoIlBoaWxwIFJh
a2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4iKTsKIE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmggYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLXB4YS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjQxNjFm
YzEKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5oCkBAIC0w
LDAgKzEsNjUgQEAKKy8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorICoKKyAqIENvcHlyaWdodCAoYykgMjAw
OSwgMjAxMCBNYXJ2ZWxsIEludGVybmF0aW9uYWwgTHRkLgorICoJCQkJUGhpbGlwIFJha2l0eSA8
cHJha2l0eUBtYXJ2ZWxsLmNvbT4KKyAqCQkJCU1hcmsgRi4gQnJvd24gPG1hcmtiQG1hcnZlbGwu
Y29tPgorICoKKyAqIFRoaXMgZmlsZSBpcyBwYXJ0IG9mIEdOVSBwcm9ncmFtLgorICoKKyAqIEdO
VSBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU6IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9v
ciBtb2RpZnkgaXQKKyAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZQorICogRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
LCBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvciAoYXQgeW91cgorICogb3B0aW9u
KSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiBHTlUgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBp
biB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQKKyAqIFdJVEhPVVQgQU5ZIFdB
UlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5U
QUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gU2VlIHRoZSBHTlUg
R2VuZXJhbAorICogUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiBZb3Ug
c2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBhbG9uZworICogd2l0aCB0aGlzIHByb2dyYW0uCisgKgorICogSWYgbm90LCBzZWUgaHR0
cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzL29sZC1saWNlbnNlcy9ncGwtMi4wLmh0bWwKKyAqCisg
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKi8KKworLyogU3VwcG9ydHM6CisgKiBTREhDSSBzdXBwb3J0IGZvciBN
TVAyL1BYQTkxMC9QWEExNjgKKyAqCisgKiBSZWZlciB0byBzZGhjaS1zM2MuYy4KKyAqLworCisj
aWZuZGVmIF9fU0RIQ0lfUFhBX0gKKyNkZWZpbmUgX19TREhDSV9QWEFfSAorCisjaW5jbHVkZSA8
bGludXgvdHlwZXMuaD4KKyNpbmNsdWRlICJzZGhjaS5oIgorCitzdHJ1Y3Qgc2RoY2lfcHhhIHsK
KwlzdHJ1Y3Qgc2RoY2lfaG9zdAkJKmhvc3Q7CisJc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YQkq
cGRhdGE7CisJc3RydWN0IGNsawkJCSpjbGs7CisJc3RydWN0IHJlc291cmNlCSpyZXM7CisKKwl1
MzIJCWRlbGF5X2luX21zOworCXUzMgkJZGVsYXlfaW5fdXM7CisJdTMyCQlkZWxheV9pbl9uczsK
KworCXU4CQljbGtfZW5hYmxlOworCXU4CQlwb3dlcl9tb2RlOworfTsKKworc3RydWN0IHNkaGNp
X3B4YV9kYXRhIHsKKwlzdHJ1Y3Qgc2RoY2lfb3BzIG9wczsKKwl1bnNpZ25lZCBpbnQgcXVpcmtz
OworCXVuc2lnbmVkIGludCBtbWNfY2FwczsKKwlpbnQgKCpwbGF0Zm9ybV9wcm9iZSkgKHN0cnVj
dCBzZGhjaV9ob3N0ICpob3N0KTsKK307CisKK2V4dGVybiBzdHJ1Y3Qgc2RoY2lfcHhhX2RhdGEg
c2RoY2lfcGxhdGZvcm1fZGF0YTsKK2V4dGVybiB2b2lkIHNkaGNpX2ZyZWVfaG9zdChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCk7CitleHRlcm4gdm9pZCBzZGhjaV9yZW1vdmVfaG9zdChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCwgaW50IGRlYWQpOworZXh0ZXJuIHN0cnVjdCBzZGhjaV9ob3N0ICpz
ZGhjaV9hbGxvY19ob3N0KHN0cnVjdCBkZXZpY2UgKmRldiwKKwlzaXplX3QgcHJpdl9zaXplKTsK
KworI2VuZGlmIC8qIF9fU0RIQ0lfUFhBX0ggKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktcHhhMTY4LmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YTE2OC5jCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjhmODVkNjUKLS0tIC9kZXYvbnVsbAorKysg
Yi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YTE2OC5jCkBAIC0wLDAgKzEsMzIyIEBACisvKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioKKyAqCisgKiBDb3B5cmlnaHQgKGMpIDIwMDksIDIwMTAgTWFydmVsbCBJ
bnRlcm5hdGlvbmFsIEx0ZC4KKyAqCQkJCVBoaWxpcCBSYWtpdHkgPHByYWtpdHlAbWFydmVsbC5j
b20+CisgKgkJCQlNYXJrIEYuIEJyb3duIDxtYXJrYkBtYXJ2ZWxsLmNvbT4KKyAqCisgKiBUaGlz
IGZpbGUgaXMgcGFydCBvZiBHTlUgcHJvZ3JhbS4KKyAqCisgKiBHTlUgcHJvZ3JhbSBpcyBmcmVl
IHNvZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CisgKiB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieSB0aGUKKyAqIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24g
MiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIKKyAqIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uCisgKgorICogR05VIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBp
dCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisgKiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVT
UyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuIFNlZSB0aGUgR05VIEdlbmVyYWwKKyAqIFB1Ymxp
YyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogWW91IHNob3VsZCBoYXZlIHJlY2Vp
dmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKKyAqIHdp
dGggdGhpcyBwcm9ncmFtLgorICoKKyAqIElmIG5vdCwgc2VlIGh0dHA6Ly93d3cuZ251Lm9yZy9s
aWNlbnNlcy9vbGQtbGljZW5zZXMvZ3BsLTIuMC5odG1sCisgKgorICoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiov
CisKKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9k
ZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9tbWMvaG9zdC5oPgorI2luY2x1ZGUgPGxpbnV4L2Ns
ay5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+CisjaW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5j
bHVkZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CisjaW5jbHVkZSA8
cGxhdC9zZGhjaS5oPgorI2luY2x1ZGUgInNkaGNpLXB4YS5oIgorI2luY2x1ZGUgInNkaGNpLmgi
CisKKyNkZWZpbmUgRFJJVkVSX05BTUUgInNkaGNpLXB4YTE2OCIKKworI2RlZmluZSBTRF9GSUZP
X1BBUkFNCQkweEUwCisjZGVmaW5lIERJU19QQURfU0RfQ0xLX0dBVEUJKDE8PDEwKSAvKiBUdXJu
IG9uL29mZiBEeW5hbWljIENsb2NrIEdhdGluZyAqLworCisjZGVmaW5lIFNEX0NMT0NLX0FORF9C
VVJTVF9TSVpFX1NFVFVQCTB4RTYKKyNkZWZpbmUgU0RDTEtfREVMQVlfTUFTSwkweEYKKyNkZWZp
bmUgU0RDTEtfU0VMX01BU0sJCTB4MworI2RlZmluZSBTRENMS19ERUxBWV9TSElGVAkxMAorI2Rl
ZmluZSBTRENMS19TRUxfU0hJRlQJCTgKKworI2RlZmluZSBTRF9DRV9BVEFfMgkJCTB4RUEKKyNk
ZWZpbmUgU0RDRV9NTUNfV0lEVEgJCSgxPDw4KQorI2RlZmluZSBTRENFX01NQ19DQVJECQkoMTw8
MTIpCisKKyNkZWZpbmUgRElTQUJMRV9DTE9DS19HQVRJTkcgMAorCitzdGF0aWMgaW50IHBsYXRm
b3JtX3B4YTE2OF9wcm9iZShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CisKKy8qCisgKiBNTUMg
c3BlYyBjYWxscyBmb3IgdGhlIGhvc3QgdG8gc2VuZCA3NCBjbG9ja3MgdG8gdGhlIGNhcmQKKyAq
IGR1cmluZyBpbml0aWFsaXphdGlvbiwgcmlnaHQgYWZ0ZXIgdm9sdGFnZSBzdGFiaWxpemF0aW9u
LgorICogdGhlIHB4YTE2OCBjb250cm9sbGVyIGhhcyBubyBlYXN5IHdheSB0byBnZW5lcmF0ZSB0
aG9zZSBjbG9ja3MuCisgKiBjcmVhdGUgdGhlIGNsb2NrcyBtYW51YWxseSByaWdodCBoZXJlLgor
ICovCisjaWYgMAorc3RhdGljIHZvaWQgZ2VuZXJhdGVfaW5pdF9jbG9ja3Moc3RydWN0IHNkaGNp
X2hvc3QgKmhvc3QsIHU4IHBvd2VyX21vZGUpCit7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0g
c2RoY2lfcHJpdihob3N0KTsKKwlzdHJ1Y3QgcGZuX2NmZyAqY2ZnID0gcHhhLT5wZGF0YS0+cGZu
X3RhYmxlOworCW1mcF9jZmdfdCBjbGtfcGluOworCWludCBpOworCisKKwlpZiAoY2ZnID09IE5V
TEwpIHsKKwkJREJHKCJDYW5ub3QgZ2VuZXJhdGUgaW5pdCBjbG9ja3MhXG4iKTsKKwkJcmV0dXJu
OworCX0KKworCWlmIChweGEtPnBvd2VyX21vZGUgPT0gTU1DX1BPV0VSX1VQCisJJiYgcG93ZXJf
bW9kZSA9PSBNTUNfUE9XRVJfT04pIHsKKworCQlEQkcoIiVzOiBFTlRFUiAlczogcG93ZXJfbW9k
ZSA9ICVkLCBpb3NfLnBvd2VyX21vZGUgPSAlZFxuIiwKKwkJCV9fZnVuY19fLAorCQkJbW1jX2hv
c3RuYW1lKGhvc3QtPm1tYyksCisJCQlweGEtPnBvd2VyX21vZGUsCisJCQlwb3dlcl9tb2RlKTsK
KwkJLyogQ01EL0NMSyBwaW4gdG8gZ3BpbyBtb2RlLiAgKi8KKwkJbWZwX2NvbmZpZyhwZm5fbG9v
a3VwKGNmZywgUEZOX0dQSU8sIFBJTl9NTUNfQ01EKSwgMSk7CisJCW1mcF9jb25maWcocGZuX2xv
b2t1cChjZmcsIFBGTl9HUElPLCBQSU5fTU1DX0NMSyksIDEpOworCisJCS8qIGVuc3VyZSBhdCBs
ZWFzdCAxLzIgcGVyaW9kIHN0YWJsZSB0byBwcmV2ZW50IHJ1bnQgcHVsc2UuKi8KKwkJdWRlbGF5
KDMpOworCisJCWNsa19waW4gPSAqKHBmbl9sb29rdXAoY2ZnLCBQRk5fR1BJTywgUElOX01NQ19D
TEspKTsKKwkJaWYgKGdwaW9fcmVxdWVzdChNRlBfUElOKGNsa19waW4pLCAiTU1DX0NMSyIpKSB7
CisJCQlwcmludGsoS0VSTl9FUlIgIkNhbm5vdCBvYnRhaW4gTU1DX0NMSyBHUElPICVsZFxuIiwK
KwkJCQlNRlBfUElOKGNsa19waW4pKTsKKwkJCWdvdG8gZXJyOworCQl9CisKKwkJREJHKCJHZW5l
cmF0aW5nIGluaXQgY2xvY2tzIG9uIHBpbnMgQ0xLICVsZFxuIiwKKwkJCU1GUF9QSU4oY2xrX3Bp
bikpOworCisJCWZvciAoaSA9IDA7IGkgPCBJTklUX0NMT0NLUzsgaSsrKSB7CisJCQlncGlvX2Rp
cmVjdGlvbl9vdXRwdXQoTUZQX1BJTihjbGtfcGluKSwgMCk7IC8qIGxvdyAqLworCQkJdWRlbGF5
KDMpOworCQkJZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KE1GUF9QSU4oY2xrX3BpbiksIDEpOyAvKiBo
aWdoICovCisJCQl1ZGVsYXkoMyk7CisJCX0KKworCQlncGlvX2ZyZWUoTUZQX1BJTihjbGtfcGlu
KSk7CisJfQorCitlcnI6CisJcHhhLT5wb3dlcl9tb2RlID0gcG93ZXJfbW9kZTsKKworCS8qIENN
RC9DTEsgcGluIGJhY2sgTU1DIG1vZGUuICAgKi8KKwltZnBfY29uZmlnKHBmbl9sb29rdXAoY2Zn
LCBQRk5fRk4sIFBJTl9NTUNfQ01EKSwgMSk7CisJbWZwX2NvbmZpZyhwZm5fbG9va3VwKGNmZywg
UEZOX0ZOLCBQSU5fTU1DX0NMSyksIDEpOworfQorI2VuZGlmCisKKy8qCisgKiB3ZSBjYW5ub3Qg
dGFsayB0byBjb250cm9sbGVyIGZvciA4IGJ1cyBjeWNsZXMgYWNjb3JkaW5nIHRvIHNkaW8gc3Bl
YworICogYXQgbG93ZXN0IHNwZWVkIHRoaXMgaXMgMTAwLDAwMCBIWiBwZXIgY3ljbGUgb3IgODAw
LDAwMCBjeWNsZXMKKyAqIHdoaWNoIGlzIHF1aXRlIGEgTE9ORyBUSU1FIG9uIGEgZmFzdCBjcHUg
LS0gc28gZGVsYXkgaWYgbmVlZGVkCisgKi8KK3N0YXRpYyB2b2lkIHBsYXRmb3JtX3NwZWNpZmlj
X2RlbGF5KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQoreworCXN0cnVjdCBzZGhjaV9weGEgKnB4
YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisKKwltZGVsYXkocHhhLT5kZWxheV9pbl9tcyk7CisJdWRl
bGF5KHB4YS0+ZGVsYXlfaW5fdXMpOworCW5kZWxheShweGEtPmRlbGF5X2luX25zKTsKK30KKwor
c3RhdGljIHZvaWQgc2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCBp
bnQgY2xvY2spCit7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdihob3N0KTsK
KworCWlmIChjbG9jayAhPSAwKSB7CisJCXB4YS0+ZGVsYXlfaW5fbnMgPSAoMTAwMDAwMDAwMC9j
bG9jayk7CisKKwkJLyogbmVlZCB0byBkZWxheSAxMiBjbG9ja3MgZm9yIDg3ODcvODc4NiAqLwor
CQkvKiBuZWVkIHRvIGRlbGF5IDggY2xvY2tzIGZvciBjb250cm9sbGVyIC0tIHNvIGp1c3QgdXNl
IDEyICovCisKKwkJcHhhLT5kZWxheV9pbl9ucyA9IHB4YS0+ZGVsYXlfaW5fbnMgKiAxMjsKKwor
CQlweGEtPmRlbGF5X2luX21zID0gcHhhLT5kZWxheV9pbl9ucyAvIDEwMDAwMDA7CisJCXB4YS0+
ZGVsYXlfaW5fbnMgPSBweGEtPmRlbGF5X2luX25zICUgMTAwMDAwMDsKKwkJcHhhLT5kZWxheV9p
bl91cyA9IHB4YS0+ZGVsYXlfaW5fbnMgLyAxMDAwOworCQlweGEtPmRlbGF5X2luX25zID0gcHhh
LT5kZWxheV9pbl9ucyAlIDEwMDA7CisJfSBlbHNlIHsKKwkJcHhhLT5kZWxheV9pbl9ucyA9IDA7
CisJCXB4YS0+ZGVsYXlfaW5fdXMgPSAwOworCQlweGEtPmRlbGF5X2luX21zID0gMDsKKwl9Cit9
CisKK3N0YXRpYyB2b2lkIHNldF9jbG9ja19hbmRfYnVyc3Rfc2l6ZShzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCkKK3sKKwl1MTYgdG1wOworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3By
aXYoaG9zdCk7CisKKwlpZiAocHhhLT5wZGF0YS0+YWRqdXN0X2Nsb2NrcykgeworCQl0bXAgPSBy
ZWFkdyhob3N0LT5pb2FkZHIgKyBTRF9DTE9DS19BTkRfQlVSU1RfU0laRV9TRVRVUCk7CisJCXBy
X2RlYnVnKCIlczolczogKEIpIFNEX0NMT0NLX0FORF9CVVJTVCA9ICUwNFgiCisJCQkiLCBkZWxh
eSA9ICVkLCBzZWwgPSAlZFxuIiwKKwkJCV9fZnVuY19fLCBtbWNfaG9zdG5hbWUoaG9zdC0+bW1j
KSwgdG1wLAorCQkJcHhhLT5wZGF0YS0+Y2xrX2RlbGF5LCBweGEtPnBkYXRhLT5jbGtfc2VsZWN0
KTsKKwkJdG1wICY9IH4oU0RDTEtfREVMQVlfTUFTSyA8PCBTRENMS19ERUxBWV9TSElGVCk7CisJ
CXRtcCAmPSB+KFNEQ0xLX1NFTF9NQVNLIDw8IFNEQ0xLX1NFTF9TSElGVCk7CisJCXRtcCB8PSAo
cHhhLT5wZGF0YS0+Y2xrX2RlbGF5ICYgU0RDTEtfREVMQVlfTUFTSykgPDwKKwkJCVNEQ0xLX0RF
TEFZX1NISUZUOworCQl0bXAgfD0gKHB4YS0+cGRhdGEtPmNsa19zZWxlY3QgJiBTRENMS19TRUxf
TUFTSykgPDwKKwkJCVNEQ0xLX1NFTF9TSElGVDsKKwkJd3JpdGV3KHRtcCwgaG9zdC0+aW9hZGRy
ICsgU0RfQ0xPQ0tfQU5EX0JVUlNUX1NJWkVfU0VUVVApOworCQlwcl9kZWJ1ZygiJXM6JXM6IChB
KSBTRF9DTE9DS19BTkRfQlVSU1QgPSAlMDRYXG4iLAorCQkJX19mdW5jX18sIG1tY19ob3N0bmFt
ZShob3N0LT5tbWMpLCB0bXApOworCX0KK30KKworc3RhdGljIHZvaWQgcHJvZ3JhbUZJRk8oc3Ry
dWN0IHNkaGNpX2hvc3QgKmhvc3QsIGludCBlbmFibGUpCit7CisJdW5zaWduZWQgc2hvcnQgdG1w
OworCisJdG1wID0gcmVhZHcoaG9zdC0+aW9hZGRyICsgU0RfRklGT19QQVJBTSk7CisJaWYgKGVu
YWJsZSkKKwkJdG1wICY9IH5ESVNfUEFEX1NEX0NMS19HQVRFOworCWVsc2UKKwkJdG1wIHw9IERJ
U19QQURfU0RfQ0xLX0dBVEU7CisJd3JpdGV3KHRtcCwgaG9zdC0+aW9hZGRyICsgU0RfRklGT19Q
QVJBTSk7Cit9CisKK3N0YXRpYyB2b2lkIHBsYXRmb3JtX3Jlc2V0X2VudGVyKHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0LCB1OCBtYXNrKQoreworCS8qIEJlZm9yZSBSRVNFVF9EQVRBIHdlIG5lZWQg
dG8gd2FpdCBhdCBsZWFzdCAxMCBzZCBjeWNsZXMgKi8KKwlpZiAobWFzayA9PSBTREhDSV9SRVNF
VF9EQVRBKQorCQlwbGF0Zm9ybV9zcGVjaWZpY19kZWxheShob3N0KTsKK30KKworCitzdGF0aWMg
dm9pZCBwbGF0Zm9ybV9yZXNldF9leGl0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1OCBtYXNr
KQoreworCWlmIChtYXNrID09IFNESENJX1JFU0VUX0FMTCkgeworCQkvKiByZXNldCBwcml2YXRl
IHJlZ2lzdGVycyAqLworCQlwcm9ncmFtRklGTyhob3N0LCBESVNBQkxFX0NMT0NLX0dBVElORyk7
CisJCXNldF9jbG9ja19hbmRfYnVyc3Rfc2l6ZShob3N0KTsKKwl9Cit9CisKKworI2lmZGVmIENP
TkZJR19NTUNfQ0xLR0FURQorc3RhdGljIHZvaWQgcGxhdGZvcm1faHdfY2xrX2dhdGUoc3RydWN0
IHNkaGNpX2hvc3QgKmhvc3QpCit7CisJaW50IGVuYWJsZTsKKworCWVuYWJsZSA9IGhvc3QtPm1t
Yy0+Y2xrX2dhdGVkOworCXByb2dyYW1GSUZPKGhvc3QsIGVuYWJsZSk7Cit9CisjZW5kaWYKKwor
c3RhdGljIHVuc2lnbmVkIGludCBnZXRfbWF4X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0
KQoreworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisKKwlwcl9k
ZWJ1ZygiJXM6JXMgY2xrX2dldF9yYXRlID0gJWx1XG4iLAorCQkJX19mdW5jX18sIG1tY19ob3N0
bmFtZShob3N0LT5tbWMpLAorCQkJIGNsa19nZXRfcmF0ZShweGEtPmNsaykpOworCisJcmV0dXJu
IGNsa19nZXRfcmF0ZShweGEtPmNsayk7Cit9CisKK3N0YXRpYyB1bnNpZ25lZCBpbnQgZ2V0X2Zf
bWF4X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQoreworCXN0cnVjdCBzZGhjaV9weGEg
KnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisKKwlwcl9kZWJ1ZygiJXM6JXMgZl9tYXggPSAlZFxu
IiwKKwkJCV9fZnVuY19fLCBtbWNfaG9zdG5hbWUoaG9zdC0+bW1jKSwKKwkJCSBweGEtPnBkYXRh
LT5tYXhfc3BlZWQpOworCisJcmV0dXJuIHB4YS0+cGRhdGEtPm1heF9zcGVlZDsKK30KKworc3Rh
dGljIGludCBwbGF0Zm9ybV9zdXBwb3J0c184X2JpdChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwg
aW50IHdpZHRoKQoreworCXUxNiB0bXA7CisKKwl0bXAgPSByZWFkdyhob3N0LT5pb2FkZHIgKyBT
RF9DRV9BVEFfMik7CisJdG1wIHw9IFNEQ0VfTU1DX0NBUkQgfCBTRENFX01NQ19XSURUSDsKKwl3
cml0ZXcodG1wLCBob3N0LT5pb2FkZHIgKyBTRF9DRV9BVEFfMik7CisKKwl0bXAgPSByZWFkdyho
b3N0LT5pb2FkZHIgKyBTRF9DRV9BVEFfMik7CisJaWYgKHdpZHRoICE9IDgpCisJCXRtcCAmPSB+
KFNEQ0VfTU1DX0NBUkQgfCBTRENFX01NQ19XSURUSCk7CisJZWxzZQorCQl0bXAgfD0gU0RDRV9N
TUNfQ0FSRCB8IFNEQ0VfTU1DX1dJRFRIOworCXdyaXRldyh0bXAsIGhvc3QtPmlvYWRkciArIFNE
X0NFX0FUQV8yKTsKKwlyZXR1cm4gMDsKK30KKworc3RydWN0IHNkaGNpX3B4YV9kYXRhIHNkaGNp
X3BsYXRmb3JtX2RhdGEgPSB7CisJLm9wcyA9IHsKKwkJLnBsYXRmb3JtX3Jlc2V0X2VudGVyID0g
cGxhdGZvcm1fcmVzZXRfZW50ZXIsCisJCS5wbGF0Zm9ybV9yZXNldF9leGl0ID0gcGxhdGZvcm1f
cmVzZXRfZXhpdCwKKwkJLmdldF9tYXhfY2xvY2sgPSBnZXRfbWF4X2Nsb2NrLAorCQkuc2V0X2Ns
b2NrID0gc2V0X2Nsb2NrLAorCQkucGxhdGZvcm1fc3BlY2lmaWNfZGVsYXkgPSBwbGF0Zm9ybV9z
cGVjaWZpY19kZWxheSwKKwkJLnBsYXRmb3JtX3NlbmRfaW5pdF83NF9jbG9ja3MgPSBOVUxMLAor
CQkuZ2V0X2ZfbWF4X2Nsb2NrID0gTlVMTCwKKwkJLnBsYXRmb3JtXzhiaXRfd2lkdGggPSBOVUxM
LAorI2lmZGVmIENPTkZJR19NTUNfQ0xLR0FURQorCQkucGxhdGZvcm1faHdfY2xrX2dhdGUgPSBw
bGF0Zm9ybV9od19jbGtfZ2F0ZSwKKyNlbmRpZgorCX0sCisjaWZkZWYgQ09ORklHX01NQ19DTEtH
QVRFCisJLm1tY19jYXBzID0gTU1DX0NBUF9IV19DTE9DS19HQVRJTkcgfCBNTUNfQ0FQX0JVU19X
SURUSF9URVNULAorI2Vsc2UKKwkubW1jX2NhcHMgPSBNTUNfQ0FQX0JVU19XSURUSF9URVNULAor
I2VuZGlmCisJLnBsYXRmb3JtX3Byb2JlID0gcGxhdGZvcm1fcHhhMTY4X3Byb2JlLAorCS5xdWly
a3MgPSBTREhDSV9RVUlSS18zMkJJVF9ETUFfQUREUiB8IFNESENJX1FVSVJLXzMyQklUX0RNQV9T
SVpFCisJCXwgU0RIQ0lfUVVJUktfTk9fQlVTWV9JUlEgfCBTREhDSV9RVUlSS19DQVBfQ0xPQ0tf
QkFTRV9CUk9LRU4sCit9OworRVhQT1JUX1NZTUJPTF9HUEwoc2RoY2lfcGxhdGZvcm1fZGF0YSk7
CisKK3N0YXRpYyBpbnQgcGxhdGZvcm1fcHhhMTY4X3Byb2JlKHN0cnVjdCBzZGhjaV9ob3N0ICpo
b3N0KQoreworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJc3Ry
dWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSAqcGRhdGEgPSBweGEtPnBkYXRhOworCXN0cnVjdCBzZGhj
aV9vcHMgKnBfb3BzOworCisJaG9zdC0+cXVpcmtzIHw9IHNkaGNpX3BsYXRmb3JtX2RhdGEucXVp
cmtzOworCWhvc3QtPm1tYy0+Y2FwcyB8PSBzZGhjaV9wbGF0Zm9ybV9kYXRhLm1tY19jYXBzOwor
CisJLyoKKwkgKiB3ZSBjYW5ub3QgZGlyZWN0bHkgY29weSBvdXIgb3BlcmF0aW9ucyBpbnRvIGhv
c3QtPm9wcworCSAqIHNpbmNlIGl0IGlzIHJlYWQgb25seS4gIFNvIHdlIGRvIHRoaXMgaW5kaXJl
Y3RseS4KKwkgKi8KKwlwX29wcyA9IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCBzZGhjaV9vcHMpLCBH
RlBfS0VSTkVMKTsKKwlpZiAoIXBfb3BzKQorCQlyZXR1cm4gLUVOT01FTTsKKworCW1lbWNweSgo
dm9pZCAqKXBfb3BzLCAodm9pZCAqKSZzZGhjaV9wbGF0Zm9ybV9kYXRhLm9wcywKKwkJc2l6ZW9m
KHN0cnVjdCBzZGhjaV9vcHMpKTsKKworCS8qIElmIHNsb3QgZGVzaWduIHN1cHBvcnRzIDggYml0
IGRhdGEsIGluZGljYXRlIHRoaXMgdG8gTU1DLiAqLworCWlmIChwZGF0YS0+ZmxhZ3MgJiBQWEFf
RkxBR19TRF84X0JJVF9DQVBBQkxFX1NMT1QpIHsKKwkJaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19D
QVBfOF9CSVRfREFUQTsKKwkJcF9vcHMtPnBsYXRmb3JtXzhiaXRfd2lkdGggPSBwbGF0Zm9ybV9z
dXBwb3J0c184X2JpdDsKKwl9CisKKwlpZiAocGRhdGEtPmZsYWdzICYgUFhBX0ZMQUdfQ0FSRF9Q
RVJNQU5FTlQpIHsKKwkJaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19DQVBfTk9OUkVNT1ZBQkxFOwor
CQlob3N0LT5xdWlya3MgfD0gU0RIQ0lfUVVJUktfQlJPS0VOX0NBUkRfREVURUNUSU9OOworCX0K
KworCWlmIChweGEtPnBkYXRhLT5tYXhfc3BlZWQpCisJCXBfb3BzLT5nZXRfZl9tYXhfY2xvY2sg
PSBnZXRfZl9tYXhfY2xvY2s7CisKKwltZW1jcHkoKHZvaWQgKilob3N0LT5vcHMsICh2b2lkICop
cF9vcHMsIHNpemVvZihzdHJ1Y3Qgc2RoY2lfb3BzKSk7CisJa2ZyZWUocF9vcHMpOworCXJldHVy
biAwOworfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGE5MTAuYyBiL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhOTEwLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMC4uMjgyYTFlMAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktcHhhOTEwLmMKQEAgLTAsMCArMSwyNzEgQEAKKy8qKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorICoKKyAq
IENvcHlyaWdodCAoYykgMjAwOSwgMjAxMCBNYXJ2ZWxsIEludGVybmF0aW9uYWwgTHRkLgorICoJ
CQkJUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KKyAqCQkJCU1hcmsgRi4gQnJv
d24gPG1hcmtiQG1hcnZlbGwuY29tPgorICoKKyAqIFRoaXMgZmlsZSBpcyBwYXJ0IG9mIEdOVSBw
cm9ncmFtLgorICoKKyAqIEdOVSBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU6IHlvdSBjYW4gcmVk
aXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQKKyAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZQorICogRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uLCBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvciAo
YXQgeW91cgorICogb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiBHTlUgcHJvZ3Jh
bSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQK
KyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFu
dHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVS
UE9TRS4gU2VlIHRoZSBHTlUgR2VuZXJhbAorICogUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0
YWlscy4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZworICogd2l0aCB0aGlzIHByb2dyYW0uCisgKgor
ICogSWYgbm90LCBzZWUgaHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzL29sZC1saWNlbnNlcy9n
cGwtMi4wLmh0bWwKKyAqCisgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KKworI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxp
bnV4L21tYy9ob3N0Lmg+CisjaW5jbHVkZSA8bGludXgvY2xrLmg+CisjaW5jbHVkZSA8bGludXgv
aW8uaD4KKyNpbmNsdWRlIDxsaW51eC9lcnIuaD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgor
I2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxwbGF0L3NkaGNpLmg+CisjaW5jbHVk
ZSAic2RoY2ktcHhhLmgiCisjaW5jbHVkZSAic2RoY2kuaCIKKworI2RlZmluZSBEUklWRVJfTkFN
RSAic2RoY2ktcHhhOTEwIgorCisjZGVmaW5lIFNEX0ZJRk9fUEFSQU0JCTB4RTAKKyNkZWZpbmUg
RElTX1BBRF9TRF9DTEtfR0FURQkoMTw8MTApIC8qIFR1cm4gb24vb2ZmIER5bmFtaWMgQ2xvY2sg
R2F0aW5nICovCisKKyNkZWZpbmUgU0RfQ0xPQ0tfQU5EX0JVUlNUX1NJWkVfU0VUVVAJMHhFNgor
I2RlZmluZSBTRENMS19ERUxBWV9NQVNLCTB4RgorI2RlZmluZSBTRENMS19TRUxfTUFTSwkJMHgz
CisjZGVmaW5lIFNEQ0xLX0RFTEFZX1NISUZUCTEwCisjZGVmaW5lIFNEQ0xLX1NFTF9TSElGVAkJ
OAorCisjZGVmaW5lIFNEX0NFX0FUQV8yCQkweEVBCisjZGVmaW5lIFNEQ0VfTU1DX1dJRFRICQko
MTw8OCkKKyNkZWZpbmUgU0RDRV9NTUNfQ0FSRAkJKDE8PDEyKQorCisjZGVmaW5lIERJU0FCTEVf
Q0xPQ0tfR0FUSU5HIDAKKworc3RhdGljIGludCBwbGF0Zm9ybV9weGE5MTBfcHJvYmUoc3RydWN0
IHNkaGNpX2hvc3QgKmhvc3QpOworCisvKgorICogTU1DIHNwZWMgY2FsbHMgZm9yIHRoZSBob3N0
IHRvIHNlbmQgNzQgY2xvY2tzIHRvIHRoZSBjYXJkCisgKiBkdXJpbmcgaW5pdGlhbGl6YXRpb24s
IHJpZ2h0IGFmdGVyIHZvbHRhZ2Ugc3RhYmlsaXphdGlvbi4KKyAqIHRoZSBweGExNjggY29udHJv
bGxlciBoYXMgbm8gZWFzeSB3YXkgdG8gZ2VuZXJhdGUgdGhvc2UgY2xvY2tzLgorICogY3JlYXRl
IHRoZSBjbG9ja3MgbWFudWFsbHkgcmlnaHQgaGVyZS4KKyAqLworI2lmIDAKK3N0YXRpYyB2b2lk
IGdlbmVyYXRlX2luaXRfY2xvY2tzKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1OCBwb3dlcl9t
b2RlKQoreworCXN0cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJc3Ry
dWN0IHBmbl9jZmcgKmNmZyA9IHB4YS0+cGRhdGEtPnBmbl90YWJsZTsKKwltZnBfY2ZnX3QgY2xr
X3BpbjsKKwlpbnQgaTsKKworCisJaWYgKGNmZyA9PSBOVUxMKSB7CisJCURCRygiQ2Fubm90IGdl
bmVyYXRlIGluaXQgY2xvY2tzIVxuIik7CisJCXJldHVybjsKKwl9CisKKwlpZiAocHhhLT5wb3dl
cl9tb2RlID09IE1NQ19QT1dFUl9VUAorCSYmIHBvd2VyX21vZGUgPT0gTU1DX1BPV0VSX09OKSB7
CisKKwkJREJHKCIlczogRU5URVIgJXM6IHBvd2VyX21vZGUgPSAlZCwgaW9zXy5wb3dlcl9tb2Rl
ID0gJWRcbiIsCisJCQlfX2Z1bmNfXywKKwkJCW1tY19ob3N0bmFtZShob3N0LT5tbWMpLAorCQkJ
cHhhLT5wb3dlcl9tb2RlLAorCQkJcG93ZXJfbW9kZSk7CisJCS8qIENNRC9DTEsgcGluIHRvIGdw
aW8gbW9kZS4gICovCisJCW1mcF9jb25maWcocGZuX2xvb2t1cChjZmcsIFBGTl9HUElPLCBQSU5f
TU1DX0NNRCksIDEpOworCQltZnBfY29uZmlnKHBmbl9sb29rdXAoY2ZnLCBQRk5fR1BJTywgUElO
X01NQ19DTEspLCAxKTsKKworCQkvKiBlbnN1cmUgYXQgbGVhc3QgMS8yIHBlcmlvZCBzdGFibGUg
dG8gcHJldmVudCBydW50IHB1bHNlLiovCisJCXVkZWxheSgzKTsKKworCQljbGtfcGluID0gKihw
Zm5fbG9va3VwKGNmZywgUEZOX0dQSU8sIFBJTl9NTUNfQ0xLKSk7CisJCWlmIChncGlvX3JlcXVl
c3QoTUZQX1BJTihjbGtfcGluKSwgIk1NQ19DTEsiKSkgeworCQkJcHJpbnRrKEtFUk5fRVJSICJD
YW5ub3Qgb2J0YWluIE1NQ19DTEsgR1BJTyAlbGRcbiIsCisJCQkJTUZQX1BJTihjbGtfcGluKSk7
CisJCQlnb3RvIGVycjsKKwkJfQorCisJCURCRygiR2VuZXJhdGUgNzQgY2xvY2tzIG9uIHBpbnMg
Q0xLICVsZFxuIiwgTUZQX1BJTihjbGtfcGluKSk7CisKKwkJZm9yIChpID0gMDsgaSA8IElOSVRf
Q0xPQ0tTOyBpKyspIHsKKwkJCWdwaW9fZGlyZWN0aW9uX291dHB1dChNRlBfUElOKGNsa19waW4p
LCAwKTsgLyogbG93ICovCisJCQl1ZGVsYXkoMyk7CisJCQlncGlvX2RpcmVjdGlvbl9vdXRwdXQo
TUZQX1BJTihjbGtfcGluKSwgMSk7IC8qIGhpZ2ggKi8KKwkJCXVkZWxheSgzKTsKKwkJfQorCisJ
CWdwaW9fZnJlZShNRlBfUElOKGNsa19waW4pKTsKKwl9CisKK2VycjoKKwlweGEtPnBvd2VyX21v
ZGUgPSBwb3dlcl9tb2RlOworCisJLyogQ01EL0NMSyBwaW4gYmFjayBNTUMgbW9kZS4gICAqLwor
CW1mcF9jb25maWcocGZuX2xvb2t1cChjZmcsIFBGTl9GTiwgUElOX01NQ19DTUQpLCAxKTsKKwlt
ZnBfY29uZmlnKHBmbl9sb29rdXAoY2ZnLCBQRk5fRk4sIFBJTl9NTUNfQ0xLKSwgMSk7Cit9Cisj
ZW5kaWYKKworc3RhdGljIHZvaWQgc2V0X2Nsb2NrX2FuZF9idXJzdF9zaXplKHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0KQoreworCXUxNiB0bXA7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2Ro
Y2lfcHJpdihob3N0KTsKKworCWlmIChweGEtPnBkYXRhLT5hZGp1c3RfY2xvY2tzKSB7CisJCXRt
cCA9IHJlYWR3KGhvc3QtPmlvYWRkciArIFNEX0NMT0NLX0FORF9CVVJTVF9TSVpFX1NFVFVQKTsK
KwkJcHJfZGVidWcoIiVzOiVzOiAoQikgU0RfQ0xPQ0tfQU5EX0JVUlNUID0gJTA0WCwgIgorCQkJ
ImRlbGF5ID0gJWQsIHNlbCA9ICVkXG4iLAorCQkJX19mdW5jX18sIG1tY19ob3N0bmFtZShob3N0
LT5tbWMpLCB0bXAsCisJCQlweGEtPnBkYXRhLT5jbGtfZGVsYXksIHB4YS0+cGRhdGEtPmNsa19z
ZWxlY3QpOworCQl0bXAgJj0gfihTRENMS19ERUxBWV9NQVNLIDw8IFNEQ0xLX0RFTEFZX1NISUZU
KTsKKwkJdG1wICY9IH4oU0RDTEtfU0VMX01BU0sgPDwgU0RDTEtfU0VMX1NISUZUKTsKKwkJdG1w
IHw9IChweGEtPnBkYXRhLT5jbGtfZGVsYXkgJiBTRENMS19ERUxBWV9NQVNLKSA8PAorCQkJU0RD
TEtfREVMQVlfU0hJRlQ7CisJCXRtcCB8PSAocHhhLT5wZGF0YS0+Y2xrX3NlbGVjdCAmIFNEQ0xL
X1NFTF9NQVNLKSA8PAorCQkJU0RDTEtfU0VMX1NISUZUOworCQl3cml0ZXcodG1wLCBob3N0LT5p
b2FkZHIgKyBTRF9DTE9DS19BTkRfQlVSU1RfU0laRV9TRVRVUCk7CisJCXByX2RlYnVnKCIlczol
czogKEEpIFNEX0NMT0NLX0FORF9CVVJTVCA9ICUwNFhcbiIsCisJCQlfX2Z1bmNfXywgbW1jX2hv
c3RuYW1lKGhvc3QtPm1tYyksIHRtcCk7CisJfQorfQorCitzdGF0aWMgdm9pZCBwcm9ncmFtRklG
TyhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgaW50IGVuYWJsZSkKK3sKKwl1bnNpZ25lZCBzaG9y
dCB0bXA7CisKKwl0bXAgPSByZWFkdyhob3N0LT5pb2FkZHIgKyBTRF9GSUZPX1BBUkFNKTsKKwlp
ZiAoZW5hYmxlKQorCQl0bXAgJj0gfkRJU19QQURfU0RfQ0xLX0dBVEU7CisJZWxzZQorCQl0bXAg
fD0gRElTX1BBRF9TRF9DTEtfR0FURTsKKwl3cml0ZXcodG1wLCBob3N0LT5pb2FkZHIgKyBTRF9G
SUZPX1BBUkFNKTsKK30KKworc3RhdGljIHZvaWQgcGxhdGZvcm1fcmVzZXRfZXhpdChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCwgdTggbWFzaykKK3sKKwlpZiAobWFzayA9PSBTREhDSV9SRVNFVF9B
TEwpIHsKKwkJcHJvZ3JhbUZJRk8oaG9zdCwgRElTQUJMRV9DTE9DS19HQVRJTkcpOworCQlzZXRf
Y2xvY2tfYW5kX2J1cnN0X3NpemUoaG9zdCk7CisJfQorfQorCisjaWZkZWYgQ09ORklHX01NQ19D
TEtHQVRFCitzdGF0aWMgdm9pZCBwbGF0Zm9ybV9od19jbGtfZ2F0ZShzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCkKK3sKKwlpbnQgZW5hYmxlOworCisJZW5hYmxlID0gaG9zdC0+bW1jLT5jbGtfZ2F0
ZWQ7CisJcHJvZ3JhbUZJRk8oaG9zdCwgZW5hYmxlKTsKK30KKyNlbmRpZgorCitzdGF0aWMgdW5z
aWduZWQgaW50IGdldF9tYXhfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCit7CisJc3Ry
dWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdihob3N0KTsKKworCXByX2RlYnVnKCIlczol
cyBjbGtfZ2V0X3JhdGUgPSAlbHVcbiIsCisJCQlfX2Z1bmNfXywgbW1jX2hvc3RuYW1lKGhvc3Qt
Pm1tYyksCisJCQkgY2xrX2dldF9yYXRlKHB4YS0+Y2xrKSk7CisKKwlyZXR1cm4gY2xrX2dldF9y
YXRlKHB4YS0+Y2xrKTsKK30KKworc3RhdGljIHVuc2lnbmVkIGludCBnZXRfZl9tYXhfY2xvY2so
c3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCit7CisJc3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2Ro
Y2lfcHJpdihob3N0KTsKKworCXByX2RlYnVnKCIlczolcyBmX21heCA9ICVkXG4iLAorCQkJX19m
dW5jX18sIG1tY19ob3N0bmFtZShob3N0LT5tbWMpLAorCQkJIHB4YS0+cGRhdGEtPm1heF9zcGVl
ZCk7CisKKwlyZXR1cm4gcHhhLT5wZGF0YS0+bWF4X3NwZWVkOworfQorCitzdGF0aWMgaW50IHBs
YXRmb3JtX3N1cHBvcnRzXzhfYml0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBpbnQgd2lkdGgp
Cit7CisJdTE2IHRtcDsKKworCXRtcCA9IHJlYWR3KGhvc3QtPmlvYWRkciArIFNEX0NFX0FUQV8y
KTsKKwl0bXAgfD0gU0RDRV9NTUNfQ0FSRCB8IFNEQ0VfTU1DX1dJRFRIOworCXdyaXRldyh0bXAs
IGhvc3QtPmlvYWRkciArIFNEX0NFX0FUQV8yKTsKKworCXRtcCA9IHJlYWR3KGhvc3QtPmlvYWRk
ciArIFNEX0NFX0FUQV8yKTsKKwlpZiAod2lkdGggIT0gOCkKKwkJdG1wICY9IH4oU0RDRV9NTUNf
Q0FSRCB8IFNEQ0VfTU1DX1dJRFRIKTsKKwllbHNlCisJCXRtcCB8PSBTRENFX01NQ19DQVJEIHwg
U0RDRV9NTUNfV0lEVEg7CisJd3JpdGV3KHRtcCwgaG9zdC0+aW9hZGRyICsgU0RfQ0VfQVRBXzIp
OworCXJldHVybiAwOworfQorCitzdHJ1Y3Qgc2RoY2lfcHhhX2RhdGEgc2RoY2lfcGxhdGZvcm1f
ZGF0YSA9IHsKKwkub3BzID0geworCQkucGxhdGZvcm1fcmVzZXRfZXhpdCA9IHBsYXRmb3JtX3Jl
c2V0X2V4aXQsCisJCS5nZXRfbWF4X2Nsb2NrID0gZ2V0X21heF9jbG9jaywKKwkJLnBsYXRmb3Jt
X3NlbmRfaW5pdF83NF9jbG9ja3MgPSBOVUxMLAorCQkuZ2V0X2ZfbWF4X2Nsb2NrID0gTlVMTCwK
KwkJLnBsYXRmb3JtXzhiaXRfd2lkdGggPSBOVUxMLAorI2lmZGVmIENPTkZJR19NTUNfQ0xLR0FU
RQorCQkucGxhdGZvcm1faHdfY2xrX2dhdGUgPSBwbGF0Zm9ybV9od19jbGtfZ2F0ZSwKKyNlbmRp
ZgorCX0sCisjaWZkZWYgQ09ORklHX01NQ19DTEtHQVRFCisJLm1tY19jYXBzID0gTU1DX0NBUF9I
V19DTE9DS19HQVRJTkcgfCBNTUNfQ0FQX0JVU19XSURUSF9URVNULAorI2Vsc2UKKwkubW1jX2Nh
cHMgPSBNTUNfQ0FQX0JVU19XSURUSF9URVNULAorI2VuZGlmCisJLnBsYXRmb3JtX3Byb2JlID0g
cGxhdGZvcm1fcHhhOTEwX3Byb2JlLAorCS5xdWlya3MgPSBTREhDSV9RVUlSS18zMkJJVF9ETUFf
QUREUiB8IFNESENJX1FVSVJLXzMyQklUX0RNQV9TSVpFCisJCXwgU0RIQ0lfUVVJUktfTk9fQlVT
WV9JUlEgfCBTREhDSV9RVUlSS19DQVBfQ0xPQ0tfQkFTRV9CUk9LRU4sCit9OworRVhQT1JUX1NZ
TUJPTF9HUEwoc2RoY2lfcGxhdGZvcm1fZGF0YSk7CisKK3N0YXRpYyBpbnQgcGxhdGZvcm1fcHhh
OTEwX3Byb2JlKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQoreworCXN0cnVjdCBzZGhjaV9weGEg
KnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7CisJc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSAqcGRh
dGEgPSBweGEtPnBkYXRhOworCXN0cnVjdCBzZGhjaV9vcHMgKnBfb3BzOworCisJaG9zdC0+cXVp
cmtzIHw9IHNkaGNpX3BsYXRmb3JtX2RhdGEucXVpcmtzOworCWhvc3QtPm1tYy0+Y2FwcyB8PSBz
ZGhjaV9wbGF0Zm9ybV9kYXRhLm1tY19jYXBzOworCisJLyoKKwkgKiB3ZSBjYW5ub3QgZGlyZWN0
bHkgY29weSBvdXIgb3BlcmF0aW9ucyBpbnRvIGhvc3QtPm9wcworCSAqIHNpbmNlIGl0IGlzIHJl
YWQgb25seS4gIFNvIHdlIGRvIHRoaXMgaW5kaXJlY3RseS4KKwkgKi8KKwlwX29wcyA9IGttYWxs
b2Moc2l6ZW9mKHN0cnVjdCBzZGhjaV9vcHMpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIXBfb3BzKQor
CQlyZXR1cm4gLUVOT01FTTsKKworCW1lbWNweSgodm9pZCAqKXBfb3BzLCAodm9pZCAqKSZzZGhj
aV9wbGF0Zm9ybV9kYXRhLm9wcywKKwkJc2l6ZW9mKHN0cnVjdCBzZGhjaV9vcHMpKTsKKworCS8q
IElmIHNsb3QgZGVzaWduIHN1cHBvcnRzIDggYml0IGRhdGEsIGluZGljYXRlIHRoaXMgdG8gTU1D
LiAqLworCWlmIChwZGF0YS0+ZmxhZ3MgJiBQWEFfRkxBR19TRF84X0JJVF9DQVBBQkxFX1NMT1Qp
IHsKKwkJaG9zdC0+bW1jLT5jYXBzIHw9IE1NQ19DQVBfOF9CSVRfREFUQTsKKwkJcF9vcHMtPnBs
YXRmb3JtXzhiaXRfd2lkdGggPSBwbGF0Zm9ybV9zdXBwb3J0c184X2JpdDsKKwl9CisKKwlpZiAo
cGRhdGEtPmZsYWdzICYgUFhBX0ZMQUdfQ0FSRF9QRVJNQU5FTlQpIHsKKwkJaG9zdC0+bW1jLT5j
YXBzIHw9IE1NQ19DQVBfTk9OUkVNT1ZBQkxFOworCQlob3N0LT5xdWlya3MgfD0gU0RIQ0lfUVVJ
UktfQlJPS0VOX0NBUkRfREVURUNUSU9OOworCX0KKworCWlmIChweGEtPnBkYXRhLT5tYXhfc3Bl
ZWQpCisJCXBfb3BzLT5nZXRfZl9tYXhfY2xvY2sgPSBnZXRfZl9tYXhfY2xvY2s7CisKKwltZW1j
cHkoKHZvaWQgKilob3N0LT5vcHMsICh2b2lkICopcF9vcHMsIHNpemVvZihzdHJ1Y3Qgc2RoY2lf
b3BzKSk7CisJa2ZyZWUocF9vcHMpOworCXJldHVybiAwOworfQotLSAKMS42LjAuNAoK

--_002_501F2432789549DC9A47824868A4769Bmarvellcom_--
