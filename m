From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/2] mmc: dw_mmc: add dw_mci_of_get_cd_gpio to handle cd pin
Date: Fri,  8 Nov 2013 13:38:46 +0800
Message-ID: <1383889128-12540-2-git-send-email-zhangfei.gao@linaro.org>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40586 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab3KHFjS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 00:39:18 -0500
Received: by mail-pd0-f173.google.com with SMTP id r10so1647157pdi.18
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 21:39:17 -0800 (PST)
In-Reply-To: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Add function dw_mci_of_get_cd_gpio to check "cd-gpios" from dts.
mmc_gpio_request_cd and mmc_gpio_get_cd are used to handle cd pin

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   52 +++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4bce0de..0d5ad80 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -36,6 +36,7 @@
 #include <linux/workqueue.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include "dw_mmc.h"
 
@@ -1032,20 +1033,26 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
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
 
-	if (present)
+	if (present) {
+		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is present\n");
-	else
+	} else {
+		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is not present\n");
+	}
 
 	return present;
 }
@@ -1926,10 +1933,6 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 			/* Card change detected */
 			slot->last_detect_state = present;
 
-			/* Mark card as present if applicable */
-			if (present != 0)
-				set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-
 			/* Clean up queue if present */
 			mrq = slot->mrq;
 			if (mrq) {
@@ -1977,8 +1980,6 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 
 			/* Power down slot */
 			if (present == 0) {
-				clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-
 				/* Clear down the FIFO */
 				dw_mci_fifo_reset(host);
 #ifdef CONFIG_MMC_DW_IDMAC
@@ -2079,6 +2080,30 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 
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
@@ -2096,6 +2121,11 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
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
@@ -2197,12 +2227,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 #endif /* CONFIG_MMC_DW_IDMAC */
 	}
 
-	if (dw_mci_get_cd(mmc))
-		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-	else
-		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-
 	slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
+	dw_mci_of_get_cd_gpio(host->dev, slot->id, mmc);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-- 
1.7.9.5

