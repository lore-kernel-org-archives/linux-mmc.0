From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH v4 3/3] mmc: usdhi6rol0: add pinctrl to set pin drive strength
Date: Thu, 21 Apr 2016 15:55:44 +0200
Message-ID: <7eca8ca9ed439369f47341a7eca4a62d982b6766.1461246772.git.larper@axis.com>
References: <cover.1461246772.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:45014 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcDUNzy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 09:55:54 -0400
In-Reply-To: <cover.1461246772.git.larper@axis.com>
In-Reply-To: <cover.1461246772.git.larper@axis.com>
References: <cover.1461246772.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

Some boards need different pin drive strength for the UHS mode. Add an
optional pinctrl setting with two pin states covering UHS speeds and
other speeds.

Signed-off-by: Lars Persson <larper@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 28fe5c7..38c418c 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pagemap.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
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
@@ -1148,12 +1154,35 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static int usdhi6_set_pinstates(struct usdhi6_host *host, int voltage)
+{
+	if (IS_ERR(host->pins_uhs))
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
 
 	ret = mmc_regulator_set_vqmmc(mmc, ios);
+	if (ret < 0)
+		return ret;
 
+	ret = usdhi6_set_pinstates(mmc_priv(mmc), ios->signal_voltage);
+	if (ret)
+		dev_warn_once(mmc_dev(mmc),
+			      "Failed to set pinstate err=%d\n", ret);
 	return ret;
 }
 
@@ -1741,6 +1770,25 @@ static int usdhi6_probe(struct platform_device *pdev)
 	host->wait	= USDHI6_WAIT_FOR_REQUEST;
 	host->timeout	= msecs_to_jiffies(4000);
 
+	host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(host->pinctrl)) {
+		ret = PTR_ERR(host->pinctrl);
+		goto e_free_mmc;
+	}
+
+	host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
+	if (!IS_ERR(host->pins_uhs)) {
+		host->pins_default = pinctrl_lookup_state(host->pinctrl,
+							  PINCTRL_STATE_DEFAULT);
+
+		if (IS_ERR(host->pins_default)) {
+			dev_err(dev,
+				"UHS pinctrl requires a default pin state.\n");
+			ret = PTR_ERR(host->pins_default);
+			goto e_free_mmc;
+		}
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(host->base)) {
-- 
2.1.4

