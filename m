From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: remove "disable-wp" property
Date: Mon, 18 Jan 2016 17:50:04 +0800
Message-ID: <1453110604-8169-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:38472 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbcARJyp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 04:54:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

dw_mmc already use mmc_of_parse to get disable-wp,
so we remove it from dw_mmc. And dw_mci_slot_of_parse
will not be removed as well.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fddbcb6..8687554 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2493,47 +2493,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_OF
-/* given a slot, find out the device node representing that slot */
-static struct device_node *dw_mci_of_find_slot_node(struct dw_mci_slot *slot)
-{
-	struct device *dev = slot->mmc->parent;
-	struct device_node *np;
-	const __be32 *addr;
-	int len;
-
-	if (!dev || !dev->of_node)
-		return NULL;
-
-	for_each_child_of_node(dev->of_node, np) {
-		addr = of_get_property(np, "reg", &len);
-		if (!addr || (len < sizeof(int)))
-			continue;
-		if (be32_to_cpup(addr) == slot->id)
-			return np;
-	}
-	return NULL;
-}
-
-static void dw_mci_slot_of_parse(struct dw_mci_slot *slot)
-{
-	struct device_node *np = dw_mci_of_find_slot_node(slot);
-
-	if (!np)
-		return;
-
-	if (of_property_read_bool(np, "disable-wp")) {
-		slot->mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
-		dev_warn(slot->mmc->parent,
-			"Slot quirk 'disable-wp' is deprecated\n");
-	}
-}
-#else /* CONFIG_OF */
-static void dw_mci_slot_of_parse(struct dw_mci_slot *slot)
-{
-}
-#endif /* CONFIG_OF */
-
 static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
@@ -2590,8 +2549,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
-	dw_mci_slot_of_parse(slot);
-
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto err_host_allocated;
-- 
2.3.7



