From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: select the operation mode with sysfs
Date: Thu, 05 Jan 2012 11:04:57 +0900
Message-ID: <4F050549.2000408@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39869 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab2AECFC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 21:05:02 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXA00820Z4A62H0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 05 Jan 2012 11:05:00 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LXA008ICZ4BMQC0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 05 Jan 2012 11:05:00 +0900 (KST)
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
 drivers/mmc/card/block.c |   14 +++++++-------
 drivers/mmc/core/host.c  |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    5 ++++-
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 0cad48a..56e2aae 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1379,6 +1379,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
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
@@ -1509,13 +1516,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
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
index 30055f2..a89007e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -293,6 +293,40 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
 
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
@@ -381,6 +415,10 @@ int mmc_add_host(struct mmc_host *host)
 #endif
 	mmc_host_clk_sysfs_init(host);
 
+	if (host->caps & MMC_CAP_CMD23)
+		host->pre_defined_op = 1;
+	mmc_host_cmd23_sysfs_init(host);
+
 	mmc_start_host(host);
 	register_pm_notifier(&host->pm_notify);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 031d865..cfa5fd5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -249,6 +249,9 @@ struct mmc_host {
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
 #define MMC_CAP2_NO_SLEEP_CMD	(1 << 4)	/* Don't allow sleep command */
 
+	struct device_attribute pre_defined_attr;
+	bool			pre_defined_op;	/* CMD23 should be use or not */
+
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
 #define MMC_HOST_PW_NOTIFY_NONE		0
@@ -427,7 +430,7 @@ static inline int mmc_card_wake_sdio_irq(struct mmc_host *host)
 
 static inline int mmc_host_cmd23(struct mmc_host *host)
 {
-	return host->caps & MMC_CAP_CMD23;
+	return host->pre_defined_op;
 }
 
 static inline int mmc_boot_partition_access(struct mmc_host *host)
