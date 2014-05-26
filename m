From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2 2/3] mmc: dw_mmc: use the __mmc_of_parse to parse the slot
 node
Date: Mon, 26 May 2014 20:35:06 +0900
Message-ID: <1401104107-17651-3-git-send-email-jh80.chung@samsung.com>
References: <1401104107-17651-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45987 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbaEZLfR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 07:35:17 -0400
In-reply-to: <1401104107-17651-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, tgih.jun@samsung.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

dw-mmc controller have the multiple slot.
Then it needs to parse the property for each slot.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V2:
	- None

 drivers/mmc/host/dw_mmc.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..d4800f8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1015,12 +1015,11 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 {
 	int present;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci_board *brd = slot->host->pdata;
 	struct dw_mci *host = slot->host;
 	int gpio_cd = mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
-	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
+	if (slot->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
 		present = 1;
 	else if (!IS_ERR_VALUE(gpio_cd))
 		present = gpio_cd;
@@ -2010,6 +2009,9 @@ static struct dw_mci_of_slot_quirks {
 	{
 		.quirk	= "disable-wp",
 		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
+	}, {
+		.quirk	= "broken-cd",
+		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
 	},
 };
 
@@ -2088,7 +2090,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
-	mmc_of_parse(mmc);
+	__mmc_of_parse(mmc, dw_mci_of_find_slot_node(host->dev, slot->id));
 
 	if (host->pdata->blk_settings) {
 		mmc->max_segs = host->pdata->blk_settings->max_segs;
@@ -2231,23 +2233,13 @@ static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
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
@@ -2264,11 +2256,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		pdata->num_slots = 1;
 	}
 
-	/* get quirks */
-	for (idx = 0; idx < ARRAY_SIZE(of_quirks); idx++)
-		if (of_get_property(np, of_quirks[idx].quirk, NULL))
-			pdata->quirks |= of_quirks[idx].id;
-
 	if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_depth))
 		dev_info(dev, "fifo-depth property not found, using "
 				"value of FIFOTH register as default\n");
-- 
1.7.9.5

