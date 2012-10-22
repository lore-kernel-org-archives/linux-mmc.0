From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] MMCI: fetch pinctrl handle and set default state
Date: Mon, 22 Oct 2012 09:52:06 +0200
Message-ID: <1350892326-5125-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:44241 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab2JVHwg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Oct 2012 03:52:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

From: Linus Walleij <linus.walleij@linaro.org>

This fetches the pinctrl resource for the MMCI driver, and if
a "default" state is found, it is activated.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 18 ++++++++++++++++++
 drivers/mmc/host/mmci.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..269566d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -33,6 +33,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -1360,6 +1361,23 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		mmc->f_max = min(host->mclk, fmax);
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
+	host->pinctrl = devm_pinctrl_get(&dev->dev);
+	if (IS_ERR(host->pinctrl)) {
+		ret = PTR_ERR(host->pinctrl);
+		goto clk_disable;
+	}
+
+	host->pins_default = pinctrl_lookup_state(host->pinctrl,
+			PINCTRL_STATE_DEFAULT);
+
+	/* enable pins to be muxed in and configured */
+	if (!IS_ERR(host->pins_default)) {
+		ret = pinctrl_select_state(host->pinctrl, host->pins_default);
+		if (ret)
+			dev_err(&dev->dev, "could not set default pins\n");
+	} else
+		dev_err(&dev->dev, "could not get default pinstate\n");
+
 #ifdef CONFIG_REGULATOR
 	/* If we're using the regulator framework, try to fetch a regulator */
 	host->vcc = regulator_get(&dev->dev, "vmmc");
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d437ccf..d34d8c0 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -195,6 +195,10 @@ struct mmci_host {
 	unsigned int		size;
 	struct regulator	*vcc;
 
+	/* pinctrl handles */
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pins_default;
+
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	struct dma_chan		*dma_current;
-- 
1.7.11.3

