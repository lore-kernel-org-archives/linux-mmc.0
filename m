From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] sdhci-fujitsu: add support for setting the CMD_DAT_DELAY attribute
Date: Wed,  1 Nov 2017 00:21:32 +0000
Message-ID: <20171101002132.13500-1-ard.biesheuvel@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47035 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdKAAV4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Oct 2017 20:21:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id m72so1983394wmc.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Oct 2017 17:21:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

The Socionext SynQuacer SoC inherits this IP from Fujitsu, but
requires the F_SDH30_CMD_DAT_DELAY bit to be set in the
F_SDH30_ESD_CONTROL control register.

So let's add an optional property to this device's binding, and
set the attribute if it is present in the DT node.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt |  2 ++
 drivers/mmc/host/sdhci_f_sdh30.c                        | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
index de2c53cff4f1..9ad02f743ad0 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
@@ -15,6 +15,8 @@ Required properties:
 Optional properties:
 - vqmmc-supply: phandle to the regulator device tree node, mentioned
   as the VCCQ/VDD_IO supply in the eMMC/SD specs.
+- cmd-dat-delay-select: boolean property indicating that this host requires
+  the CMD_DAT_DELAY control to be enabled.
 
 Example:
 
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 111b66f5439b..00bc2121d607 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/clk.h>
 
 #include "sdhci-pltfm.h"
@@ -45,8 +46,9 @@
 struct f_sdhost_priv {
 	struct clk *clk_iface;
 	struct clk *clk;
-	u32 vendor_hs200;
 	struct device *dev;
+	u32 vendor_hs200;
+	bool enable_cmd_dat_delay;
 };
 
 static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
@@ -84,10 +86,19 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
 
 static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 {
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+	u32 ctl;
+
 	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
 		sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
 
 	sdhci_reset(host, mask);
+
+	if (priv->enable_cmd_dat_delay) {
+		ctl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
+		ctl |= F_SDH30_CMD_DAT_DELAY;
+		sdhci_writel(host, ctl, F_SDH30_ESD_CONTROL);
+	}
 }
 
 static const struct sdhci_ops sdhci_f_sdh30_ops = {
@@ -126,6 +137,11 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
 			SDHCI_QUIRK2_TUNING_WORK_AROUND;
 
+	if (device_property_read_bool(dev, "cmd-dat-delay-select")) {
+		dev_info(dev, "Setting cmd-dat-delay\n");
+		priv->enable_cmd_dat_delay = true;
+	}
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err;
-- 
2.11.0

