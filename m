From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 2/2] sdhci-fujitsu: add support for setting the CMD_DAT_DELAY attribute
Date: Mon,  6 Nov 2017 15:29:23 +0000
Message-ID: <20171106152923.32114-2-ard.biesheuvel@linaro.org>
References: <20171106152923.32114-1-ard.biesheuvel@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:49276 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753731AbdKFP3f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2017 10:29:35 -0500
Received: by mail-wr0-f196.google.com with SMTP id g90so8967881wrd.6
        for <linux-mmc@vger.kernel.org>; Mon, 06 Nov 2017 07:29:35 -0800 (PST)
In-Reply-To: <20171106152923.32114-1-ard.biesheuvel@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

The Socionext SynQuacer SoC inherits this IP from Fujitsu, but
requires the F_SDH30_CMD_DAT_DELAY bit to be set in the
F_SDH30_ESD_CONTROL control register. So set this bit if the
DT node has the 'fujitsu,cmd-dat-delay-select' property.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3: don't reorder struct members to reduce padding
    remove pr_info() and simplify conditional assignment
v2: no change

 drivers/mmc/host/sdhci_f_sdh30.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 111b66f5439b..04ca0d33a521 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/clk.h>
 
 #include "sdhci-pltfm.h"
@@ -47,6 +48,7 @@ struct f_sdhost_priv {
 	struct clk *clk;
 	u32 vendor_hs200;
 	struct device *dev;
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
@@ -126,6 +137,9 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
 			SDHCI_QUIRK2_TUNING_WORK_AROUND;
 
+	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
+						"fujitsu,cmd-dat-delay-select");
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err;
-- 
2.11.0

