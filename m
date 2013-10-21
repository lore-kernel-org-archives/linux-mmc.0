From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/2] mmc: dw_mmc: add dw_mci_of_get_cd_gpio to handle cd pin
Date: Mon, 21 Oct 2013 15:13:58 +0800
Message-ID: <1382339639-16764-2-git-send-email-zhangfei.gao@linaro.org>
References: <1382339639-16764-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38500 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab3JUHOQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2013 03:14:16 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so4225474pdj.10
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2013 00:14:15 -0700 (PDT)
In-Reply-To: <1382339639-16764-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Add function dw_mci_of_get_cd_gpio to check "cd-gpios" from dts.
mmc_gpio_request_cd and mmc_gpio_get_cd are used to handle cd pin

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 018f365..b8bb9a5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -35,6 +35,7 @@
 #include <linux/workqueue.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include "dw_mmc.h"
 
@@ -872,12 +873,15 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	int present;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci_board *brd = slot->host->pdata;
+	int gpio_cd = !mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
 	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
 		present = 1;
 	else if (brd->get_cd)
 		present = !brd->get_cd(slot->id);
+	else if (!IS_ERR_VALUE(gpio_cd))
+		present = !!gpio_cd;
 	else
 		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
 			== 0 ? 1 : 0;
@@ -1876,6 +1880,30 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 
 	return gpio;
 }
+
+/* find the cd gpio for a given slot; or -1 if none specified */
+static int dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
+					struct mmc_host *mmc)
+{
+	struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
+	int gpio;
+
+	if (!np)
+		return -EINVAL;
+
+	gpio = of_get_named_gpio(np, "cd-gpios", 0);
+
+	/* Having a missing entry is valid; return silently */
+	if (!gpio_is_valid(gpio))
+		return -EINVAL;
+
+	if (mmc_gpio_request_cd(mmc, gpio, 0)) {
+		dev_warn(dev, "gpio [%d] request failed\n", gpio);
+		return -EINVAL;
+	}
+
+	return gpio;
+}
 #else /* CONFIG_OF */
 static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
 {
@@ -1893,6 +1921,11 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 {
 	return -EINVAL;
 }
+static int dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
+					struct mmc_host *mmc)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_OF */
 
 static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
@@ -1996,6 +2029,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 
 	slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
+	dw_mci_of_get_cd_gpio(host->dev, slot->id, mmc);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-- 
1.7.9.5

