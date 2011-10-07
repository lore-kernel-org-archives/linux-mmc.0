From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2] mmc: core: Add cache control for eMMC4.5 device
Date: Fri, 07 Oct 2011 13:08:00 +0900
Message-ID: <000501cc84a6$b3ec30e0$1bc492a0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com, 'Adrian Hunter' <adrian.hunter@intel.com>, jh80.chung@samsung.com, andrey.warkentin@gmail.com
List-Id: linux-mmc@vger.kernel.org

This patch adds cache feature of eMMC4.5 Spec.
If device supports cache capability, host can utilize some specific
operations.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
v2:
Rebased to latest mmc-next branch.
Updated with comments from Adrian Hunter.
This patch is base on [PATCH v5] mmc: core: Add default timeout vaule for CMD6.

 drivers/mmc/card/block.c |   14 ++++++----
 drivers/mmc/core/core.c  |   63 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   |   23 ++++++++++++++++
 include/linux/mmc/card.h |    2 +
 include/linux/mmc/core.h |    2 +
 include/linux/mmc/host.h |    3 ++
 include/linux/mmc/mmc.h  |    3 ++
 7 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a527806..0e49eea 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -842,16 +842,18 @@ out:
 static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
+	struct mmc_card *card = md->queue.card;
+	int ret = 0;
+
+	ret = mmc_flush_cache(card);
+	if (ret)
+		ret = -EIO;

-	/*
-	 * No-op, only service this because we need REQ_FUA for reliable
-	 * writes.
-	 */
 	spin_lock_irq(&md->lock);
-	__blk_end_request_all(req, 0);
+	__blk_end_request_all(req, ret);
 	spin_unlock_irq(&md->lock);

-	return 1;
+	return ret ? 0 : 1;
 }

 /*
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9698d8a..21d94e4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2090,6 +2090,65 @@ int mmc_card_can_sleep(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_card_can_sleep);

+/*
+ * Flush the cache to the non-volatile storage.
+ */
+int mmc_flush_cache(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	int err = 0;
+
+	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL))
+		return err;
+
+	if (mmc_card_mmc(card) &&
+			(card->ext_csd.cache_size > 0) &&
+			(card->ext_csd.cache_ctrl & 1)) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_FLUSH_CACHE, 1, 0);
+		if (err)
+			pr_err("%s: cache flush error %d\n",
+					mmc_hostname(card->host), err);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_flush_cache);
+
+/*
+ * Turn the cache ON/OFF.
+ * Turning the cache OFF shall trigger flushing of the data
+ * to the non-volatile storage.
+ */
+int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
+{
+	struct mmc_card *card = host->card;
+	int err = 0;
+
+	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
+			mmc_card_is_removable(host))
+		return err;
+
+	if (card && mmc_card_mmc(card) &&
+			(card->ext_csd.cache_size > 0)) {
+		enable = !!enable;
+
+		if (card->ext_csd.cache_ctrl ^ enable)
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					EXT_CSD_CACHE_CTRL, enable, 0);
+		if (err)
+			pr_err("%s: cache %s error %d\n",
+					mmc_hostname(card->host),
+					enable ? "on" : "off",
+					err);
+		else
+			card->ext_csd.cache_ctrl = enable;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_cache_ctrl);
+
 #ifdef CONFIG_PM

 /**
@@ -2104,6 +2163,9 @@ int mmc_suspend_host(struct mmc_host *host)
 		cancel_delayed_work(&host->disable);
 	cancel_delayed_work(&host->detect);
 	mmc_flush_scheduled_work();
+	err = mmc_cache_ctrl(host, 0);
+	if (err)
+		goto out;

 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
@@ -2129,6 +2191,7 @@ int mmc_suspend_host(struct mmc_host *host)
 	if (!err && !mmc_card_keep_power(host))
 		mmc_power_off(host);

+out:
 	return err;
 }

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4dafe45..9fa20a2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -464,6 +464,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	else
 		card->ext_csd.generic_cmd6_time = 0;

+	card->ext_csd.cache_size =
+		ext_csd[EXT_CSD_CACHE_SIZE + 0] << 0 |
+		ext_csd[EXT_CSD_CACHE_SIZE + 1] << 8 |
+		ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
+		ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
+
 out:
 	return err;
 }
@@ -997,6 +1003,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}

+	/*
+	 * If cache size is higher than 0, this indicates
+	 * the the existence of cache and it can be turned on.
+	 */
+	if ((host->caps2 & MMC_CAP2_CACHE_CTRL) &&
+			card->ext_csd.cache_size > 0) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_CACHE_CTRL, 1, 0);
+		if (err && err != -EBADMSG)
+			goto free_card;
+
+		/*
+		 * Only if no error, cache is turned on successfully.
+		 */
+		card->ext_csd.cache_ctrl = err ? 0 : 1;
+	}
+
 	if (!oldcard)
 		host->card = card;

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index a419616..374aad1 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -51,6 +51,7 @@ struct mmc_ext_csd {
 	u8			rel_sectors;
 	u8			rel_param;
 	u8			part_config;
+	u8			cache_ctrl;
 	u8			rst_n_function;
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
@@ -66,6 +67,7 @@ struct mmc_ext_csd {
 	bool			enhanced_area_en;	/* enable bit */
 	unsigned long long	enhanced_area_offset;	/* Units: Byte */
 	unsigned int		enhanced_area_size;	/* Units: KB */
+	unsigned int		cache_size;		/* Units: KB */
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 56e5625..497a319 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -174,6 +174,8 @@ extern void mmc_release_host(struct mmc_host *host);
 extern void mmc_do_release_host(struct mmc_host *host);
 extern int mmc_try_claim_host(struct mmc_host *host);

+extern int mmc_flush_cache(struct mmc_card *);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index aed5bc7..e47ec11 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -239,6 +239,7 @@ struct mmc_host {
 	unsigned int		caps2;		/* More host capabilities */

 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
+#define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control. */

 	mmc_pm_flag_t		pm_caps;	/* supported pm features */

@@ -344,6 +345,8 @@ extern int mmc_power_restore_host(struct mmc_host *host);
 extern void mmc_detect_change(struct mmc_host *, unsigned long delay);
 extern void mmc_request_done(struct mmc_host *, struct mmc_request *);

+extern int mmc_cache_ctrl(struct mmc_host *, u8);
+
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index cd63c2d..3636237 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -270,6 +270,8 @@ struct _mmc_csd {
  * EXT_CSD fields
  */

+#define EXT_CSD_FLUSH_CACHE		32	/* W */
+#define EXT_CSD_CACHE_CTRL		33	/* R/W */
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
@@ -306,6 +308,7 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_DDR_52_360	239	/* RO */
 #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
+#define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */

 /*
  * EXT_CSD field definitions
--
1.7.0.4
