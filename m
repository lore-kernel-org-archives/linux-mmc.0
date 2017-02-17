From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/7] mmc: dw_mmc: move dw_mci_get_cd forward to avoid declaration
Date: Fri, 17 Feb 2017 10:56:42 +0800
Message-ID: <1487300205-202825-5-git-send-email-shawn.lin@rock-chips.com>
References: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:52227 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755018AbdBQDBq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 22:01:46 -0500
In-Reply-To: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 83 +++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e87fd95..936de76 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -107,7 +107,6 @@ struct idmac_desc {
 #define DW_MCI_DESC_DATA_LENGTH	0x1000
 
 static int dw_mci_card_busy(struct mmc_host *mmc);
-static int dw_mci_get_cd(struct mmc_host *mmc);
 
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
@@ -933,6 +932,47 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 	data->host_cookie = COOKIE_UNMAPPED;
 }
 
+static int dw_mci_get_cd(struct mmc_host *mmc)
+{
+	int present;
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	int gpio_cd = mmc_gpio_get_cd(mmc);
+
+	/* Use platform get_cd function, else try onboard card detect */
+	if (((mmc->caps & MMC_CAP_NEEDS_POLL)
+				|| !mmc_card_is_removable(mmc))) {
+		present = 1;
+
+		if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
+			if (mmc->caps & MMC_CAP_NEEDS_POLL) {
+				dev_info(&mmc->class_dev,
+					"card is polling.\n");
+			} else {
+				dev_info(&mmc->class_dev,
+					"card is non-removable.\n");
+			}
+			set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+		}
+
+		return present;
+	} else if (gpio_cd >= 0)
+		present = gpio_cd;
+	else
+		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
+			== 0 ? 1 : 0;
+
+	spin_lock_bh(&host->lock);
+	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+		dev_dbg(&mmc->class_dev, "card is present\n");
+	else if (!present &&
+			!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+		dev_dbg(&mmc->class_dev, "card is not present\n");
+	spin_unlock_bh(&host->lock);
+
+	return present;
+}
+
 static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 {
 	unsigned int blksz = data->blksz;
@@ -1544,47 +1584,6 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 	return read_only;
 }
 
-static int dw_mci_get_cd(struct mmc_host *mmc)
-{
-	int present;
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
-	int gpio_cd = mmc_gpio_get_cd(mmc);
-
-	/* Use platform get_cd function, else try onboard card detect */
-	if (((mmc->caps & MMC_CAP_NEEDS_POLL)
-				|| !mmc_card_is_removable(mmc))) {
-		present = 1;
-
-		if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
-			if (mmc->caps & MMC_CAP_NEEDS_POLL) {
-				dev_info(&mmc->class_dev,
-					"card is polling.\n");
-			} else {
-				dev_info(&mmc->class_dev,
-					"card is non-removable.\n");
-			}
-			set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-		}
-
-		return present;
-	} else if (gpio_cd >= 0)
-		present = gpio_cd;
-	else
-		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
-			== 0 ? 1 : 0;
-
-	spin_lock_bh(&host->lock);
-	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
-		dev_dbg(&mmc->class_dev, "card is present\n");
-	else if (!present &&
-			!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
-		dev_dbg(&mmc->class_dev, "card is not present\n");
-	spin_unlock_bh(&host->lock);
-
-	return present;
-}
-
 static void dw_mci_hw_reset(struct mmc_host *mmc)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-- 
1.9.1


