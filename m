From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/7] mmc: block: Use dev_set|get_drvdata()
Date: Tue, 14 Oct 2014 13:45:19 +0200
Message-ID: <1413287120-10914-7-git-send-email-ulf.hansson@linaro.org>
References: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52052 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaJNLpm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 07:45:42 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so8157243lbv.33
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2014 04:45:40 -0700 (PDT)
In-Reply-To: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

In most of the cases mmc_get|set_drvdata() didn't simplify code, which
should be the primary reason for such macros.

Let's remove them and convert to the common device_driver macros,
dev_set|get_drvdata() instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c | 21 ++++++++++-----------
 include/linux/mmc/card.h |  2 --
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 53164e4..ab33e2d 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -112,7 +112,7 @@ struct mmc_blk_data {
 
 	/*
 	 * Only set in main mmc_blk_data associated
-	 * with mmc_card with mmc_set_drvdata, and keeps
+	 * with mmc_card with dev_set_drvdata, and keeps
 	 * track of the current selected device partition.
 	 */
 	unsigned int	part_curr;
@@ -642,7 +642,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md)
 {
 	int ret;
-	struct mmc_blk_data *main_md = mmc_get_drvdata(card);
+	struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
 
 	if (main_md->part_curr == md->part_type)
 		return 0;
@@ -1004,7 +1004,8 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 	err = mmc_hw_reset(host);
 	/* Ensure we switch back to the correct partition */
 	if (err != -EOPNOTSUPP) {
-		struct mmc_blk_data *main_md = mmc_get_drvdata(host->card);
+		struct mmc_blk_data *main_md =
+			dev_get_drvdata(&host->card->dev);
 		int part_err;
 
 		main_md->part_curr = main_md->part_type;
@@ -2093,7 +2094,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	/*
 	 * !subname implies we are creating main mmc_blk_data that will be
-	 * associated with mmc_card with mmc_set_drvdata. Due to device
+	 * associated with mmc_card with dev_set_drvdata. Due to device
 	 * partitions, devidx will not coincide with a per-physical card
 	 * index anymore so we keep track of a name index.
 	 */
@@ -2452,7 +2453,7 @@ static int mmc_blk_probe(struct device *dev)
 	if (mmc_blk_alloc_parts(card, md))
 		goto out;
 
-	mmc_set_drvdata(card, md);
+	dev_set_drvdata(dev, md);
 
 	if (mmc_add_disk(md))
 		goto out;
@@ -2485,7 +2486,7 @@ static int mmc_blk_probe(struct device *dev)
 static int mmc_blk_remove(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
-	struct mmc_blk_data *md = mmc_get_drvdata(card);
+	struct mmc_blk_data *md = dev_get_drvdata(dev);
 
 	mmc_blk_remove_parts(card, md);
 	pm_runtime_get_sync(&card->dev);
@@ -2496,7 +2497,7 @@ static int mmc_blk_remove(struct device *dev)
 		pm_runtime_disable(&card->dev);
 	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
-	mmc_set_drvdata(card, NULL);
+	dev_set_drvdata(dev, NULL);
 
 	return 0;
 }
@@ -2504,8 +2505,7 @@ static int mmc_blk_remove(struct device *dev)
 static int _mmc_blk_suspend(struct device *dev)
 {
 	struct mmc_blk_data *part_md;
-	struct mmc_card *card = mmc_dev_to_card(dev);
-	struct mmc_blk_data *md = mmc_get_drvdata(card);
+	struct mmc_blk_data *md = dev_get_drvdata(dev);
 
 	if (md) {
 		mmc_queue_suspend(&md->queue);
@@ -2530,8 +2530,7 @@ static int mmc_blk_suspend(struct device *dev)
 static int mmc_blk_resume(struct device *dev)
 {
 	struct mmc_blk_data *part_md;
-	struct mmc_card *card = mmc_dev_to_card(dev);
-	struct mmc_blk_data *md = mmc_get_drvdata(card);
+	struct mmc_blk_data *md = dev_get_drvdata(dev);
 
 	if (md) {
 		/*
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index cf54afe..64f4136 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -510,8 +510,6 @@ static inline int mmc_card_broken_irq_polling(const struct mmc_card *c)
 #define mmc_dev_to_card(d)	container_of(d, struct mmc_card, dev)
 
 #define mmc_list_to_card(l)	container_of(l, struct mmc_card, node)
-#define mmc_get_drvdata(c)	dev_get_drvdata(&(c)->dev)
-#define mmc_set_drvdata(c,d)	dev_set_drvdata(&(c)->dev, d)
 
 extern int mmc_register_driver(struct device_driver *);
 extern void mmc_unregister_driver(struct device_driver *);
-- 
1.9.1

