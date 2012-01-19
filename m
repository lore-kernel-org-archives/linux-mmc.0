From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2] mmc: core: select the operation mode with sysfs
Date: Thu, 19 Jan 2012 15:16:16 +0900
Message-ID: <4F17B530.6040809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:10237 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2ASGQS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 01:16:18 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LY100HMZ82XG2M0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 Jan 2012 15:16:17 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LY1001JV834IN40@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 Jan 2012 15:16:16 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is support the sysfs for operation mode.

There are two operation modes(open-ended/pre-defined).
Now, operation mode is selected only one at the compile time.

But using this patch, we can change the operation mode with node at runtime.

* pre-defined mode 
echo 1 > /sys/class/mmc_host/mmc0/pre_defined_op  
* open-ended mode
echo 0 > /sys/class/mmc_host/mmc0/pre_defined_op  

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changelog v2:
	- Add the check point in mmc_cmd23_store()
	(If host controller didn't support CMD23, need not to change the ops-mode.)

 drivers/mmc/card/block.c |   14 +++++++-------
 drivers/mmc/core/host.c  |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    5 ++++-
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 176b78e..3a190a2 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1390,6 +1390,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
 
+	if (mmc_host_cmd23(card->host)) {
+		if (mmc_card_mmc(card) ||
+		    (mmc_card_sd(card) &&
+		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
+			md->flags |= MMC_BLK_CMD23;
+	}
+
 	if (req && !mq->mqrq_prev->req)
 		/* claim host only for the first request */
 		mmc_claim_host(card->host);
@@ -1520,13 +1527,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	blk_queue_logical_block_size(md->queue.queue, 512);
 	set_capacity(md->disk, size);
 
-	if (mmc_host_cmd23(card->host)) {
-		if (mmc_card_mmc(card) ||
-		    (mmc_card_sd(card) &&
-		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
-			md->flags |= MMC_BLK_CMD23;
-	}
-
 	if (mmc_card_mmc(card) &&
 	    md->flags & MMC_BLK_CMD23 &&
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 30055f2..2660a0c 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -293,6 +293,43 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
 
 #endif
 
+static ssize_t mmc_cmd23_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", host->pre_defined_op);
+}
+
+static ssize_t mmc_cmd23_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long flags, value;
+
+	if (!(host->caps & MMC_CAP_CMD23))
+		return -EINVAL;
+
+	if (kstrtoul(buf, 0, &value))
+		return -EINVAL;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->pre_defined_op = value;
+	spin_unlock_irqrestore(&host->lock, flags);
+	return count;
+}
+
+static inline void mmc_host_cmd23_sysfs_init(struct mmc_host *host)
+{
+	host->pre_defined_attr.show = mmc_cmd23_show;
+	host->pre_defined_attr.store = mmc_cmd23_store;
+	sysfs_attr_init(&host->pre_defined_attr.attr);
+	host->pre_defined_attr.attr.name = "pre_defined_op";
+	host->pre_defined_attr.attr.mode = S_IRUGO | S_IWUSR;
+	if (device_create_file(&host->class_dev, &host->pre_defined_attr))
+		pr_err("%s: Failed to create pre_defined_op sysfs entry\n",
+				mmc_hostname(host));
+}
+
 /**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
@@ -381,6 +418,10 @@ int mmc_add_host(struct mmc_host *host)
 #endif
 	mmc_host_clk_sysfs_init(host);
 
+	if (host->caps & MMC_CAP_CMD23)
+		host->pre_defined_op = 1;
+	mmc_host_cmd23_sysfs_init(host);
+
 	mmc_start_host(host);
 	register_pm_notifier(&host->pm_notify);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index dd13e05..44fbf6c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -258,6 +258,9 @@ struct mmc_host {
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
 
+	struct device_attribute pre_defined_attr;
+	bool			pre_defined_op;	/* CMD23 should be use or not */
+
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
 #define MMC_HOST_PW_NOTIFY_NONE		0
@@ -436,7 +439,7 @@ static inline int mmc_card_wake_sdio_irq(struct mmc_host *host)
 
 static inline int mmc_host_cmd23(struct mmc_host *host)
 {
-	return host->caps & MMC_CAP_CMD23;
+	return host->pre_defined_op;
 }
 
 static inline int mmc_boot_partition_access(struct mmc_host *host)
