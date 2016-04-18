From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH 3/3] mmc: usdhi6rol0: add pinctrl to set pin drive strength
Date: Mon, 18 Apr 2016 11:38:26 +0200
Message-ID: <de3688db670eaeada3d2dd7fa97cec1d6d44203d.1460971625.git.larper@axis.com>
References: <cover.1460971625.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:58538 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbcDRJjK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Apr 2016 05:39:10 -0400
In-Reply-To: <cover.1460971625.git.larper@axis.com>
In-Reply-To: <cover.1460971625.git.larper@axis.com>
References: <cover.1460971625.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

Some boards need different pin drive strength for the UHS mode. Add an
optional pinctrl setting with two pin states covering UHS speeds and
other speeds.

Signed-off-by: Lars Persson <larper@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 5dde31b..4675ec0 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -22,6 +22,7 @@
 #include <linux/mmc/sdio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
@@ -199,6 +200,11 @@ struct usdhi6_host {
 	struct dma_chan *chan_rx;
 	struct dma_chan *chan_tx;
 	bool dma_active;
+
+	/* Pin control */
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_uhs;
 };
 
 /*			I/O primitives					*/
@@ -1148,6 +1154,24 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static int usdhi6_set_pinstates(struct usdhi6_host *host, int voltage)
+{
+	if (IS_ERR(host->pinctrl) || IS_ERR(host->pins_default) ||
+	    IS_ERR(host->pins_uhs))
+		return 0;
+
+	switch (voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+	case MMC_SIGNAL_VOLTAGE_120:
+		return pinctrl_select_state(host->pinctrl,
+					    host->pins_uhs);
+
+	default:
+		return pinctrl_select_state(host->pinctrl,
+					    host->pins_default);
+	}
+}
+
 static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	int ret;
@@ -1172,8 +1196,15 @@ static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 		return 0;
 	}
 
-	if (ret < 0)
+	if (ret < 0) {
 		dev_warn(mmc_dev(mmc), "Voltage switch failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = usdhi6_set_pinstates(mmc_priv(mmc), ios->signal_voltage);
+	if (ret)
+		dev_warn_once(mmc_dev(mmc),
+			      "Failed to set pinstate err=%d\n", ret);
 
 	return ret;
 }
@@ -1836,6 +1867,13 @@ static int usdhi6_probe(struct platform_device *pdev)
 		mmc->f_max = host->imclk;
 	mmc->f_min = host->imclk / 512;
 
+	host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(host->pinctrl)) {
+		host->pins_default = pinctrl_lookup_state(host->pinctrl,
+							  PINCTRL_STATE_DEFAULT);
+		host->pins_uhs     = pinctrl_lookup_state(host->pinctrl,
+							  "pins_uhs");
+	}
 	platform_set_drvdata(pdev, host);
 
 	ret = mmc_add_host(mmc);
-- 
2.1.4

