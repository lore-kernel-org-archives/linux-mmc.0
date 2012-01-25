From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3] mmc: core: select the operation mode with sysfs
Date: Wed, 25 Jan 2012 13:29:37 +0900
Message-ID: <4F1F8531.6090407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51296 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2AYE3k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2012 23:29:40 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYC003GU74QKF60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Jan 2012 13:29:38 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYC008NN75DV880@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Jan 2012 13:29:38 +0900 (KST)
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
Changelog V3:
	- Add the mmc_change_operation_mode()
Changelog v2:
	- Add the check point in mmc_cmd23_store()
	(If host controller didn't support CMD23, need not to change the ops-mode.)

 drivers/mmc/card/block.c |   19 +++++++++++++++++++
 drivers/mmc/core/host.c  |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/host.h |    3 +++
 4 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 176b78e..2ca72d2 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1765,6 +1765,25 @@ static const struct mmc_fixup blk_fixups[] =
 	END_FIXUP
 };
 
+void mmc_change_operation_mode(struct mmc_card *card, int val)
+{
+	struct mmc_blk_data *md = mmc_get_drvdata(card);
+
+	if (mmc_host_cmd23(card->host)) {
+		if (mmc_card_mmc(card) ||
+		    (mmc_card_sd(card) &&
+		     card->scr.cmds & SD_SCR_CMD23_SUPPORT)) {
+			if (val) {
+				md->flags |= MMC_BLK_CMD23;
+				card->host->pre_defined_op = val;
+			} else {
+				md->flags &= ~MMC_BLK_CMD23;
+				card->host->pre_defined_op = val;
+			}
+		}
+	}
+}
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 30055f2..7dab0dc 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -293,6 +293,41 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
 
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
+	int value;
+	unsigned long flags;
+
+	if (kstrtoint(buf, 0, &value))
+		return -EINVAL;
+
+	spin_lock_irqsave(&host->lock, flags);
+	mmc_change_operation_mode(host->card, value);
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
@@ -381,6 +416,10 @@ int mmc_add_host(struct mmc_host *host)
 #endif
 	mmc_host_clk_sysfs_init(host);
 
+	if (host->caps & MMC_CAP_CMD23)
+		host->pre_defined_op = 1;
+	mmc_host_cmd23_sysfs_init(host);
+
 	mmc_start_host(host);
 	register_pm_notifier(&host->pm_notify);
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f9a0663..6c530f9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -485,5 +485,6 @@ extern void mmc_unregister_driver(struct mmc_driver *);
 
 extern void mmc_fixup_device(struct mmc_card *card,
 			     const struct mmc_fixup *table);
+extern void mmc_change_operation_mode(struct mmc_card *card, int val);
 
 #endif /* LINUX_MMC_CARD_H */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index dd13e05..16604a2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -258,6 +258,9 @@ struct mmc_host {
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
 
+	struct device_attribute pre_defined_attr;
+	int			pre_defined_op;	/* CMD23 should be use or not */
+
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
 #define MMC_HOST_PW_NOTIFY_NONE		0
