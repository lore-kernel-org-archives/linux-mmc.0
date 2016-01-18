From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: remove DW_MCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Mon, 18 Jan 2016 16:50:26 +0800
Message-ID: <1453107026-19814-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:50005 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbcARIzR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 03:55:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

dw_mmc already use mmc_of_parse to get "broken-cd" property,
but it considered "broken-cd" to be a quirk in its driver. We
don't need this quirk here, and just take what we need from
mmc->caps.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c  | 23 +++--------------------
 include/linux/mmc/dw_mmc.h |  4 +---
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7128351..bbf9ca6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1450,12 +1450,11 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 {
 	int present;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci_board *brd = slot->host->pdata;
 	struct dw_mci *host = slot->host;
 	int gpio_cd = mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
-	if ((brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) ||
+	if ((mmc->caps & MMC_CAP_NEEDS_POLL) ||
 	    (mmc->caps & MMC_CAP_NONREMOVABLE))
 		present = 1;
 	else if (!IS_ERR_VALUE(gpio_cd))
@@ -2840,23 +2839,13 @@ static void dw_mci_dto_timer(unsigned long arg)
 }
 
 #ifdef CONFIG_OF
-static struct dw_mci_of_quirks {
-	char *quirk;
-	int id;
-} of_quirks[] = {
-	{
-		.quirk	= "broken-cd",
-		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
-	},
-};
-
 static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 {
 	struct dw_mci_board *pdata;
 	struct device *dev = host->dev;
 	struct device_node *np = dev->of_node;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
-	int idx, ret;
+	int ret;
 	u32 clock_frequency;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
@@ -2871,11 +2860,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		pdata->num_slots = 1;
 	}
 
-	/* get quirks */
-	for (idx = 0; idx < ARRAY_SIZE(of_quirks); idx++)
-		if (of_get_property(np, of_quirks[idx].quirk, NULL))
-			pdata->quirks |= of_quirks[idx].id;
-
 	if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_depth))
 		dev_info(dev,
 			 "fifo-depth property not found, using value of FIFOTH register as default\n");
@@ -2908,13 +2892,12 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 static void dw_mci_enable_cd(struct dw_mci *host)
 {
-	struct dw_mci_board *brd = host->pdata;
 	unsigned long irqflags;
 	u32 temp;
 	int i;
 
 	/* No need for CD if broken card detection */
-	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
+	if (host->cur_slot->mmc->caps & MMC_CAP_NEEDS_POLL)
 		return;
 
 	/* No need for CD if all slots have a non-error GPIO */
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 89df7ab..250d822 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -235,10 +235,8 @@ struct dw_mci_dma_ops {
 };
 
 /* IP Quirks/flags. */
-/* Unreliable card detection */
-#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(0)
 /* Timer for broken data transfer over scheme */
-#define DW_MCI_QUIRK_BROKEN_DTO			BIT(1)
+#define DW_MCI_QUIRK_BROKEN_DTO			BIT(0)
 
 struct dma_pdata;
 
-- 
2.3.7



