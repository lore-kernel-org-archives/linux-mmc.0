From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 2/2 v4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Sat,  1 Jan 2011 18:37:33 -0600
Message-ID: <1293928653-20001-2-git-send-email-olof@lixom.net>
References: <1293928339-19373-1-git-send-email-olof@lixom.net>
 <1293928653-20001-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:44378 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab1ABAiB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 1 Jan 2011 19:38:01 -0500
In-Reply-To: <1293928653-20001-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>, Yvonne Yip <y@palm.com>

SDHCI driver for Tegra. This driver plugs in as a new variant of
sdhci-pltfm, using the platform data structure passed in to specify the
GPIOs to use for card detect, write protect and card power enablement.

Original driver (of which only the header file is left):
Signed-off-by: Yvonne Yip <y@palm.com>

The rest, which has been rewritten by now:
Signed-off-by: Olof Johansson <olof@lixom.net>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Mike Rapoport <mike@compulab.co.il>

---

SDHCI driver for Tegra. Pretty straight forward, a few pieces of
functionality left to fill in but nothing that stops it from going
upstream. Board enablement submitted separately.

Changes since v1:
	* Rewrote for sdhci-pltfm

Changes since v2:
	* Whitespace fixes
	* Changed order of test in get_ro
	* 8-bit support
	* Set gpio directions

Changes since v3:
	* Add platform structure member for 8bit capabilities

Change-Id: I18b322b57a7285d80c530bafaba04a6d84f668d5
---
 arch/arm/mach-tegra/include/mach/sdhci.h |   29 ++++
 drivers/mmc/host/Kconfig                 |   10 ++
 drivers/mmc/host/Makefile                |    1 +
 drivers/mmc/host/sdhci-pltfm.c           |    3 +
 drivers/mmc/host/sdhci-pltfm.h           |    1 +
 drivers/mmc/host/sdhci-tegra.c           |  257 ++++++++++++++++++++++++++++++
 6 files changed, 301 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/sdhci.h
 create mode 100644 drivers/mmc/host/sdhci-tegra.c

diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/arch/arm/mach-tegra/include/mach/sdhci.h
new file mode 100644
index 0000000..3ad086e
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/sdhci.h
@@ -0,0 +1,29 @@
+/*
+ * include/asm-arm/arch-tegra/include/mach/sdhci.h
+ *
+ * Copyright (C) 2009 Palm, Inc.
+ * Author: Yvonne Yip <y@palm.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
+#define __ASM_ARM_ARCH_TEGRA_SDHCI_H
+
+#include <linux/mmc/host.h>
+
+struct tegra_sdhci_platform_data {
+	int cd_gpio;
+	int wp_gpio;
+	int power_gpio;
+	int is_8bit;
+};
+
+#endif
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d618e86..25c6a2a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -140,6 +140,16 @@ config MMC_SDHCI_ESDHC_IMX
 
 	  If unsure, say N.
 
+config MMC_SDHCI_TEGRA
+	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
+	depends on MMC_SDHCI_PLTFM && ARCH_TEGRA
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Tegra SD/MMC controller. If you have a Tegra
+	  platform with SD or MMC devices, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
 	depends on MMC_SDHCI && PLAT_SAMSUNG
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 7b645ff..fc8f8f0 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
 sdhci-platform-y				:= sdhci-pltfm.o
 sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
 sdhci-platform-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
+sdhci-platform-$(CONFIG_MMC_SDHCI_TEGRA)	+= sdhci-tegra.o
 
 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 0502f89..d9e6e88 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -170,6 +170,9 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
 #ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
 	{ "sdhci-esdhc-imx", (kernel_ulong_t)&sdhci_esdhc_imx_pdata },
 #endif
+#ifdef CONFIG_MMC_SDHCI_TEGRA
+	{ "sdhci-tegra", (kernel_ulong_t)&sdhci_tegra_pdata },
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index c1bfe48..6f631e3 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -22,5 +22,6 @@ struct sdhci_pltfm_host {
 
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
 extern struct sdhci_pltfm_data sdhci_esdhc_imx_pdata;
+extern struct sdhci_pltfm_data sdhci_tegra_pdata;
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
new file mode 100644
index 0000000..50abda8
--- /dev/null
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -0,0 +1,257 @@
+/*
+ * Copyright (C) 2010 The Chromium OS Authors <chromium-os-dev@chromium.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include <mach/gpio.h>
+#include <mach/sdhci.h>
+
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+
+static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
+{
+	u32 val;
+
+	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
+		/* Use wp_gpio here instead? */
+		val = readl(host->ioaddr + reg);
+		return val | SDHCI_WRITE_PROTECT;
+	}
+
+	return readl(host->ioaddr + reg);
+}
+
+static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
+{
+	if (unlikely(reg == SDHCI_HOST_VERSION)) {
+		/* Erratum: Version register is invalid in HW. */
+		return SDHCI_SPEC_200;
+	}
+
+	return readw(host->ioaddr + reg);
+}
+
+static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	/* Seems like we're getting spurious timeout and crc errors, so
+	 * disable signalling of them. In case of real errors software
+	 * timers should take care of eventually detecting them.
+	 */
+	if (unlikely(reg == SDHCI_SIGNAL_ENABLE))
+		val &= ~(SDHCI_INT_TIMEOUT|SDHCI_INT_CRC);
+
+	writel(val, host->ioaddr + reg);
+
+	if (unlikely(reg == SDHCI_INT_ENABLE)) {
+		/* Erratum: Must enable block gap interrupt detection */
+		u8 gap_ctrl = readb(host->ioaddr + SDHCI_BLOCK_GAP_CONTROL);
+		if (val & SDHCI_INT_CARD_INT)
+			gap_ctrl |= 0x8;
+		else
+			gap_ctrl &= ~0x8;
+		writeb(gap_ctrl, host->ioaddr + SDHCI_BLOCK_GAP_CONTROL);
+	}
+}
+
+static unsigned int tegra_sdhci_get_ro(struct sdhci_host *sdhci)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(sdhci->mmc));
+	struct tegra_sdhci_platform_data *plat;
+
+	plat = pdev->dev.platform_data;
+
+	if (!gpio_is_valid(plat->wp_gpio))
+		return -1;
+
+	return gpio_get_value(plat->wp_gpio);
+}
+
+static irqreturn_t carddetect_irq(int irq, void *data)
+{
+	struct sdhci_host *sdhost = (struct sdhci_host *)data;
+
+	tasklet_schedule(&sdhost->card_tasklet);
+	return IRQ_HANDLED;
+};
+
+static int tegra_sdhci_8bit(struct sdhci_host *host, int bus_width)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct tegra_sdhci_platform_data *plat;
+	u32 ctrl;
+
+	plat = pdev->dev.platform_data;
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	if (plat->is_8bit && bus_width == MMC_BUS_WIDTH_8) {
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		ctrl |= SDHCI_CTRL_8BITBUS;
+	} else {
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+		if (bus_width == MMC_BUS_WIDTH_4)
+			ctrl |= SDHCI_CTRL_4BITBUS;
+		else
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+	}
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	return 0;
+}
+
+
+static int tegra_sdhci_pltfm_init(struct sdhci_host *host,
+				  struct sdhci_pltfm_data *pdata)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct tegra_sdhci_platform_data *plat;
+	struct clk *clk;
+	int rc;
+
+	plat = pdev->dev.platform_data;
+	if (plat == NULL) {
+		dev_err(mmc_dev(host->mmc), "missing platform data\n");
+		return -ENXIO;
+	}
+
+	if (gpio_is_valid(plat->power_gpio)) {
+		rc = gpio_request(plat->power_gpio, "sdhci_power");
+		if (rc) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to allocate power gpio\n");
+			goto out;
+		}
+		tegra_gpio_enable(plat->power_gpio);
+		gpio_direction_output(plat->power_gpio, 1);
+	}
+
+	if (gpio_is_valid(plat->cd_gpio)) {
+		rc = gpio_request(plat->cd_gpio, "sdhci_cd");
+		if (rc) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to allocate cd gpio\n");
+			goto out_power;
+		}
+		tegra_gpio_enable(plat->cd_gpio);
+		gpio_direction_input(plat->cd_gpio);
+
+		rc = request_irq(gpio_to_irq(plat->cd_gpio), carddetect_irq,
+				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+				 mmc_hostname(host->mmc), host);
+
+		if (rc)	{
+			dev_err(mmc_dev(host->mmc), "request irq error\n");
+			goto out_cd;
+		}
+
+	}
+
+	if (gpio_is_valid(plat->wp_gpio)) {
+		rc = gpio_request(plat->wp_gpio, "sdhci_wp");
+		if (rc) {
+			dev_err(mmc_dev(host->mmc),
+				"failed to allocate wp gpio\n");
+			goto out_cd;
+		}
+		tegra_gpio_enable(plat->wp_gpio);
+		gpio_direction_input(plat->wp_gpio);
+	}
+
+	clk = clk_get(mmc_dev(host->mmc), NULL);
+	if (IS_ERR(clk)) {
+		dev_err(mmc_dev(host->mmc), "clk err\n");
+		rc = PTR_ERR(clk);
+		goto out_wp;
+	}
+	clk_enable(clk);
+	pltfm_host->clk = clk;
+
+	if (plat->is_8bit)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
+	return 0;
+
+out_wp:
+	if (gpio_is_valid(plat->wp_gpio)) {
+		tegra_gpio_disable(plat->wp_gpio);
+		gpio_free(plat->wp_gpio);
+	}
+
+out_cd:
+	if (gpio_is_valid(plat->cd_gpio)) {
+		tegra_gpio_disable(plat->cd_gpio);
+		gpio_free(plat->cd_gpio);
+	}
+
+out_power:
+	if (gpio_is_valid(plat->power_gpio)) {
+		tegra_gpio_disable(plat->power_gpio);
+		gpio_free(plat->power_gpio);
+	}
+
+out:
+	return rc;
+}
+
+static void tegra_sdhci_pltfm_exit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct tegra_sdhci_platform_data *plat;
+
+	plat = pdev->dev.platform_data;
+
+	if (gpio_is_valid(plat->wp_gpio)) {
+		tegra_gpio_disable(plat->wp_gpio);
+		gpio_free(plat->wp_gpio);
+	}
+
+	if (gpio_is_valid(plat->cd_gpio)) {
+		tegra_gpio_disable(plat->cd_gpio);
+		gpio_free(plat->cd_gpio);
+	}
+
+	if (gpio_is_valid(plat->power_gpio)) {
+		tegra_gpio_disable(plat->power_gpio);
+		gpio_free(plat->power_gpio);
+	}
+
+	clk_disable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+}
+
+static struct sdhci_ops tegra_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
+	.read_l     = tegra_sdhci_readl,
+	.read_w     = tegra_sdhci_readw,
+	.write_l    = tegra_sdhci_writel,
+	.platform_8bit_width = tegra_sdhci_8bit,
+};
+
+struct sdhci_pltfm_data sdhci_tegra_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_NO_HISPD_BIT |
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
+	.ops  = &tegra_sdhci_ops,
+	.init = tegra_sdhci_pltfm_init,
+	.exit = tegra_sdhci_pltfm_exit,
+};
-- 
1.7.3.GIT

