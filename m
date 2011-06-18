From: Sebastian Rasmussen <sebras@gmail.com>
Subject: [PATCH 3/3] MMC: Fix checkpatch complaints about long lines
Date: Sat, 18 Jun 2011 19:50:37 +0200
Message-ID: <1308419437-18306-1-git-send-email-sebras@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53547 "EHLO mail.df.lth.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab1FRRul (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2011 13:50:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sebastian Rasmussen <sebras@gmail.com>

Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
---
 drivers/mmc/card/block.c    |   26 ++++++++++++++++----------
 drivers/mmc/card/queue.c    |    3 ++-
 drivers/mmc/card/queue.h    |    3 ++-
 drivers/mmc/core/bus.c      |    3 ++-
 drivers/mmc/core/bus.h      |   13 +++++++------
 drivers/mmc/core/core.c     |    6 ++++--
 drivers/mmc/core/mmc.c      |    7 ++++---
 drivers/mmc/core/sd.c       |    3 ++-
 drivers/mmc/core/sdio.c     |    6 ++++--
 drivers/mmc/core/sdio_bus.c |    7 ++++---
 drivers/mmc/core/sdio_io.c  |    6 ++++--
 drivers/mmc/core/sdio_irq.c |    3 ++-
 12 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 48cf063..7dd71b5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -87,7 +87,7 @@ struct mmc_blk_data {
 	struct list_head part;
 
 	unsigned int	flags;
-#define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
+#define MMC_BLK_CMD23	(1 << 0)	/* Can SET_BLOCK_COUNT for multiblock */
 #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
 
 	unsigned int	usage;
@@ -374,7 +374,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	 * issuing the command.
 	 */
 	if (idata->ic.postsleep_min_us)
-		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
+		usleep_range(idata->ic.postsleep_min_us,
+				idata->ic.postsleep_max_us);
 
 	if (copy_to_user(&(ic_ptr->response), cmd.resp, sizeof(cmd.resp))) {
 		err = -EFAULT;
@@ -382,8 +383,9 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	}
 
 	if (!idata->ic.write_flag) {
-		if (copy_to_user((void __user *)(unsigned long) idata->ic.data_ptr,
-						idata->buf, idata->buf_bytes)) {
+		if (copy_to_user((void __user *)(unsigned long)
+					idata->ic.data_ptr, idata->buf,
+					idata->buf_bytes)) {
 			err = -EFAULT;
 			goto cmd_rel_host;
 		}
@@ -890,7 +892,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 				 * read a single sector.
 				 */
 				spin_lock_irq(&md->lock);
-				ret = __blk_end_request(req, -EIO, brq.data.blksz);
+				ret = __blk_end_request(req, -EIO,
+					brq.data.blksz);
 				spin_unlock_irq(&md->lock);
 				continue;
 			}
@@ -1114,8 +1117,8 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 	char cap_str[10];
 	struct mmc_blk_data *part_md;
 
-	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
-				    subname);
+	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size,
+				    default_ro, subname);
 	if (IS_ERR(part_md))
 		return PTR_ERR(part_md);
 	part_md->part_type = part_type;
@@ -1137,13 +1140,15 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 		return 0;
 
 	if (card->ext_csd.boot_size) {
-		ret = mmc_blk_alloc_part(card, md, EXT_CSD_PART_CONFIG_ACC_BOOT0,
+		ret = mmc_blk_alloc_part(card, md,
+					 EXT_CSD_PART_CONFIG_ACC_BOOT0,
 					 card->ext_csd.boot_size >> 9,
 					 true,
 					 "boot0");
 		if (ret)
 			return ret;
-		ret = mmc_blk_alloc_part(card, md, EXT_CSD_PART_CONFIG_ACC_BOOT1,
+		ret = mmc_blk_alloc_part(card, md,
+					 EXT_CSD_PART_CONFIG_ACC_BOOT1,
 					 card->ext_csd.boot_size >> 9,
 					 true,
 					 "boot1");
@@ -1176,7 +1181,8 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 {
 	if (md) {
 		if (md->disk->flags & GENHD_FL_UP) {
-			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+			device_remove_file(disk_to_dev(md->disk),
+			&md->force_ro);
 
 			/* Stop new requests from getting into the queue */
 			del_gendisk(md->disk);
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 2c10e61..3cbac80 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -109,7 +109,8 @@ static void mmc_request(struct request_queue *q)
  *
  * Initialise a MMC card request queue.
  */
-int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock)
+int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
+		spinlock_t *lock)
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 64e66e0..e2c9d9f 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -10,7 +10,8 @@ struct mmc_queue {
 	struct semaphore	thread_sem;
 	unsigned int		flags;
 	struct request		*req;
-	int			(*issue_fn)(struct mmc_queue *, struct request *);
+	int			(*issue_fn)(struct mmc_queue *,
+					struct request *);
 	void			*data;
 	struct request_queue	*queue;
 	struct scatterlist	*sg;
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index a7245b7..3655344 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -263,7 +263,8 @@ int mmc_add_card(struct mmc_card *card)
 	int ret;
 	const char *type;
 
-	dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host), card->rca);
+	dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host),
+		card->rca);
 
 	switch (card->type) {
 	case MMC_TYPE_MMC:
diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
index 8b4d1cc..52e3a4b 100644
--- a/drivers/mmc/core/bus.h
+++ b/drivers/mmc/core/bus.h
@@ -11,12 +11,13 @@
 #ifndef _MMC_CORE_BUS_H
 #define _MMC_CORE_BUS_H
 
-#define MMC_DEV_ATTR(name, fmt, args...)					\
-static ssize_t mmc_##name##_show(struct device *dev, struct device_attribute *attr, char *buf)	\
-{										\
-	struct mmc_card *card = mmc_dev_to_card(dev);				\
-	return sprintf(buf, fmt, args);						\
-}										\
+#define MMC_DEV_ATTR(name, fmt, args...)				\
+static ssize_t mmc_##name##_show(struct device *dev,			\
+		struct device_attribute *attr, char *buf)		\
+{									\
+	struct mmc_card *card = mmc_dev_to_card(dev);			\
+	return sprintf(buf, fmt, args);					\
+}									\
 static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
 
 struct mmc_card *mmc_alloc_card(struct mmc_host *host,
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b03ae56..cac0b43 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -232,7 +232,8 @@ EXPORT_SYMBOL(mmc_wait_for_req);
  *	to complete.  Return any error that occurred while the command
  *	was executing.  Do not attempt to parse the response.
  */
-int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries)
+int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
+		int retries)
 {
 	struct mmc_request mrq = {0};
 
@@ -927,7 +928,8 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 	return ocr;
 }
 
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11)
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
+		bool cmd11)
 {
 	struct mmc_command cmd = {0};
 	int err = 0;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 20f1ec3..dac1b49 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -312,7 +312,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.part_config = ext_csd[EXT_CSD_PART_CONFIG];
 
 		/* EXT_CSD value is in units of 10ms, but we store in ms */
-		card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
+		card->ext_csd.part_time =
+			10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
 
 		/* Sleep / awake timeout in 100ns units */
 		if (sa_shift > 0 && sa_shift <= 0x17)
@@ -674,8 +675,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (card->ext_csd.part_config & EXT_CSD_PART_CONFIG_ACC_MASK) {
 		card->ext_csd.part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_PART_CONFIG,
-				 card->ext_csd.part_config,
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_PART_CONFIG, card->ext_csd.part_config,
 				 card->ext_csd.part_time);
 		if (err && err != -EBADMSG)
 			goto free_card;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d4a4fda..4803769 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -727,7 +727,8 @@ try_again:
 	 */
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
+				true);
 		if (err) {
 			ocr &= ~SD_OCR_S18R;
 			goto try_again;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index acfa56d..d8aa12d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -46,7 +46,8 @@ static int sdio_read_fbr(struct sdio_func *func)
 
 	if (data == 0x0f) {
 		ret = mmc_io_rw_direct(func->card, 0, 0,
-			SDIO_FBR_BASE(func->num) + SDIO_FBR_STD_IF_EXT, 0, &data);
+			SDIO_FBR_BASE(func->num) + SDIO_FBR_STD_IF_EXT, 0,
+			&data);
 		if (ret)
 			goto out;
 	}
@@ -374,7 +375,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		card->type = MMC_TYPE_SD_COMBO;
 
 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
-		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) != 0)) {
+		    memcmp(card->raw_cid, oldcard->raw_cid,
+			    sizeof(card->raw_cid)) != 0)) {
 			mmc_remove_card(card);
 			return -ENOENT;
 		}
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index b1a4484..2addfb6 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -25,8 +25,8 @@
 
 /* show configuration fields */
 #define sdio_config_attr(field, format_string)				\
-static ssize_t								\
-field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
+static ssize_t field##_show(struct device *dev,				\
+	struct device_attribute *attr, char *buf)			\
 {									\
 	struct sdio_func *func;						\
 									\
@@ -38,7 +38,8 @@ sdio_config_attr(class, "0x%02x\n");
 sdio_config_attr(vendor, "0x%04x\n");
 sdio_config_attr(device, "0x%04x\n");
 
-static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t modalias_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 0f687cd..9215cf2 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -79,7 +79,8 @@ int sdio_enable_func(struct sdio_func *func)
 	timeout = jiffies + msecs_to_jiffies(func->enable_timeout);
 
 	while (1) {
-		ret = mmc_io_rw_direct(func->card, 0, 0, SDIO_CCCR_IORx, 0, &reg);
+		ret = mmc_io_rw_direct(func->card, 0, 0, SDIO_CCCR_IORx, 0,
+			&reg);
 		if (ret)
 			goto err;
 		if (reg & (1 << func->num))
@@ -659,7 +660,8 @@ void sdio_f0_writeb(struct sdio_func *func, unsigned char b, unsigned int addr,
 
 	BUG_ON(!func);
 
-	if ((addr < 0xF0 || addr > 0xFF) && (!mmc_card_lenient_fn0(func->card))) {
+	if ((addr < 0xF0 || addr > 0xFF) &&
+			(!mmc_card_lenient_fn0(func->card))) {
 		if (err_ret)
 			*err_ret = -EINVAL;
 		return;
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 45bd33c..86889a8 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -236,7 +236,8 @@ int sdio_claim_irq(struct sdio_func *func, sdio_irq_handler_t *handler)
 	pr_debug("SDIO: Enabling IRQ for %s...\n", sdio_func_id(func));
 
 	if (func->irq_handler) {
-		pr_debug("SDIO: IRQ for %s already in use.\n", sdio_func_id(func));
+		pr_debug("SDIO: IRQ for %s already in use.\n",
+			sdio_func_id(func));
 		return -EBUSY;
 	}
 
-- 
1.7.4.1

