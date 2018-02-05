From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 08/16] mmc: sdhci-omap: Add support to override f_max and iodelay from pdata
Date: Mon, 5 Feb 2018 18:20:21 +0530
Message-ID: <20180205125029.21570-9-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

DRA74x EVM Rev H EVM comes with revision 2.0 silicon. However, earlier
versions of EVM can come with either revision 1.1 or revision 1.0 of
silicon.

The device-tree file is written to support rev 2.0 of silicon.
pdata-quirks are used to then override the settings needed for
PG 1.1 silicon.

PG 1.1 silicon has limitations w.r.t frequencies at which MMC1/2/3
can operate as well as different IOdelay numbers.

Add support in sdhci-omap driver to get platform data if available
(added using pdata quirks) and override the data (max-frequency and
iodelay data) obtained from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c            | 21 ++++++++++++++++++++-
 include/linux/platform_data/sdhci-omap.h | 22 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/sdhci-omap.h

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index d5a9e688dc1b..c2570db3f7a2 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_data/sdhci-omap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -99,6 +100,7 @@ struct sdhci_omap_data {
 };
 
 struct sdhci_omap_host {
+	char			*version;
 	void __iomem		*base;
 	struct device		*dev;
 	struct	regulator	*pbias;
@@ -732,12 +734,21 @@ static struct pinctrl_state
 				  u32 *caps, u32 capmask)
 {
 	struct device *dev = omap_host->dev;
+	char *version = omap_host->version;
 	struct pinctrl_state *pinctrl_state = ERR_PTR(-ENODEV);
+	char str[20];
 
 	if (!(*caps & capmask))
 		goto ret;
 
-	pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
+	if (version) {
+		snprintf(str, 20, "%s-%s", mode, version);
+		pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, str);
+	}
+
+	if (IS_ERR(pinctrl_state))
+		pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
+
 	if (IS_ERR(pinctrl_state)) {
 		dev_err(dev, "no pinctrl state for %s mode", mode);
 		*caps &= ~capmask;
@@ -840,6 +851,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	const struct of_device_id *match;
 	struct sdhci_omap_data *data;
+	struct sdhci_omap_platform_data *platform_data;
 
 	match = of_match_device(omap_sdhci_match, dev);
 	if (!match)
@@ -874,6 +886,13 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pltfm_free;
 
+	platform_data = dev_get_platdata(dev);
+	if (platform_data) {
+		omap_host->version = platform_data->version;
+		if (platform_data->max_freq)
+			mmc->f_max = platform_data->max_freq;
+	}
+
 	pltfm_host->clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(pltfm_host->clk)) {
 		ret = PTR_ERR(pltfm_host->clk);
diff --git a/include/linux/platform_data/sdhci-omap.h b/include/linux/platform_data/sdhci-omap.h
new file mode 100644
index 000000000000..92abd53dcd00
--- /dev/null
+++ b/include/linux/platform_data/sdhci-omap.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Texas Instruments
+// SDHCI Controller Platform Data for TI's OMAP SoCs
+// Author: Kishon Vijay Abraham I <kishon@ti.com>
+
+#ifndef __SDHCI_OMAP_PDATA_H__
+#define __SDHCI_OMAP_PDATA_H__
+
+struct sdhci_omap_platform_data {
+	const char *name;
+
+	/*
+	 * set if your board has components or wiring that limits the
+	 * maximum frequency on the MMC bus
+	 */
+	unsigned int max_freq;
+
+	/* string specifying a particular variant of hardware */
+	char *version;
+};
+
+#endif
-- 
2.11.0
