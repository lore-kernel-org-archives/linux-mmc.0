From: Mark Salyzyn <salyzyn@android.com>
Subject: mmc: Add CONFIG_MMC_BLOCK_MAX_SPEED
Date: Thu,  4 Feb 2016 12:29:07 -0800
Message-ID: <1454617771-9842-1-git-send-email-salyzyn@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Salyzyn <salyzyn@android.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luca Porzio <lporzio@micron.com>, yalin wang <yalin.wang2010@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

When CONFIG_MMC_BLOCK_MAX_SPEED is enabled, Expose max_read_speed,
max_write_speed and cache_size controls to simulate a slow eMMC device.
The boot default values for each respectively are
CONFIG_MMC_BLOCK_MAX_READ_SPEED, CONFIG_MMC_BLOCK_MAX_WRITE_SPEED and
CONFIG_MMC_BLOCK_CACHE_SIZE respectively; and if not defined are
0 (off), 0, (off) and 4 MB also respectively.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 drivers/mmc/card/Kconfig |  54 +++++++++
 drivers/mmc/card/block.c | 295 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/card/queue.h |   8 ++
 3 files changed, 357 insertions(+)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 5562308..70bf39c 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -68,3 +68,57 @@ config MMC_TEST
 
 	  This driver is only of interest to those developing or
 	  testing a host driver. Most people should say N here.
+
+config MMC_BLOCK_MAX_SPEED
+	bool "Turn on maximum speed control per block device"
+	depends on MMC_BLOCK
+	help
+	  Say Y here to enable MMC device speed limiting. Used to test and
+	  simulate the behavior of the system when confronted with a slow MMC.
+
+	  Enables max_read_speed and max_write_speed attributes to control the
+	  write or read maximum KB/second speed.
+
+	  If unsure, say N here.
+
+config MMC_BLOCK_MAX_READ_SPEED
+	int "KB/second read speed limit per block device"
+	depends on MMC_BLOCK
+	depends on MMC_BLOCK_MAX_SPEED
+	default 0
+	help
+	  Number of KB/second reads allowed to the block device. Used to
+	  test and simulate the behavior of the system when confronted with
+	  a slow MMC.
+
+	  Value can be overridden at runtime with the max_read_speed attribute.
+
+	  If unsure, say 0 here (no speed limit)
+
+config MMC_BLOCK_MAX_WRITE_SPEED
+	int "KB/second write speed limit per block device"
+	depends on MMC_BLOCK
+	depends on MMC_BLOCK_MAX_SPEED
+	default 0
+	help
+	  Number of KB/second writes allowed to the block device. Used to
+	  test and simulate the behavior of the system when confronted with
+	  a slow MMC.
+
+	  Value can be overridden at runtime with the max_write_speed attribute.
+
+	  If unsure, say 0 here (no speed limit)
+
+config MMC_BLOCK_MAX_SPEED_CACHE_SIZE
+	int "MB of memory or SLC cache"
+	depends on MMC_BLOCK
+	depends on MMC_BLOCK_MAX_SPEED
+	default 4
+	help
+	  Number of MB of high speed memory or SLC cache expected on the
+	  eMMC device. Used to help simulate the write-back behavior more
+	  accurately.
+
+	  Value can be overridden at runtime with the cache_size attribute.
+
+	  If unsure, say 4 here
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 5914263..b2075bf 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -289,6 +289,242 @@ out:
 	return ret;
 }
 
+#ifdef CONFIG_MMC_BLOCK_MAX_SPEED
+
+/*
+ * helper macros and expectations:
+ *  size    - unsigned long number of bytes
+ *  jiffies - unsigned long HZ timestamp difference
+ *  speed   - unsigned KB/s transfer rate
+ */
+#define size_and_speed_to_jiffies(size, speed) \
+		((size) * HZ / (speed) / 1024UL)
+#define jiffies_and_speed_to_size(jiffies, speed) \
+		(((speed) * (jiffies) * 1024UL) / HZ)
+#define jiffies_and_size_to_speed(jiffies, size) \
+		((size) * HZ / (jiffies) / 1024UL)
+
+/* Limits to report warning */
+/* jiffies_and_size_to_speed(10*HZ, queue_max_hw_sectors(q) * 512UL) ~ 25 */
+#define MIN_SPEED(q) 250 /* 10 times faster than a floppy disk */
+#define MAX_SPEED(q) jiffies_and_size_to_speed(1, queue_max_sectors(q) * 512UL)
+
+#define speed_valid(speed) ((speed) > 0)
+
+static const char off[] = "off\n";
+
+static int max_speed_show(int speed, char *buf)
+{
+	if (speed)
+		return scnprintf(buf, PAGE_SIZE, "%uKB/s\n", speed);
+	else
+		return scnprintf(buf, PAGE_SIZE, off);
+}
+
+static int max_speed_store(const char *buf, struct request_queue *q)
+{
+	long set = 0;
+	unsigned limit;
+
+	if (!strncasecmp(off, buf, sizeof(off) - 2))
+		return set;
+	if (kstrtol(buf, 0, &set) || (set < 0) || (set > INT_MAX))
+		return -EINVAL;
+	if (set == 0)
+		return set;
+	limit = MAX_SPEED(q);
+	if (set > limit)
+		pr_warn("max speed %ld ineffective above %u\n", set, limit);
+	limit = MIN_SPEED(q);
+	if (set < limit)
+		pr_warn("max speed %ld painful below %u\n", set, limit);
+	return set;
+}
+
+static ssize_t max_write_speed_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+	int ret = max_speed_show(atomic_read(&md->queue.max_write_speed), buf);
+
+	mmc_blk_put(md);
+	return ret;
+}
+
+static ssize_t max_write_speed_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+	int set = max_speed_store(buf, md->queue.queue);
+
+	if (set < 0) {
+		mmc_blk_put(md);
+		return set;
+	}
+
+	atomic_set(&md->queue.max_write_speed, set);
+	mmc_blk_put(md);
+	return count;
+}
+
+static const DEVICE_ATTR(max_write_speed, S_IRUGO | S_IWUSR,
+	max_write_speed_show, max_write_speed_store);
+
+static ssize_t max_read_speed_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+	int ret = max_speed_show(atomic_read(&md->queue.max_read_speed), buf);
+
+	mmc_blk_put(md);
+	return ret;
+}
+
+static ssize_t max_read_speed_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+	int set = max_speed_store(buf, md->queue.queue);
+
+	if (set < 0) {
+		mmc_blk_put(md);
+		return set;
+	}
+
+	atomic_set(&md->queue.max_read_speed, set);
+	mmc_blk_put(md);
+	return count;
+}
+
+static const DEVICE_ATTR(max_read_speed, S_IRUGO | S_IWUSR,
+	max_read_speed_show, max_read_speed_store);
+
+static ssize_t cache_size_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
+	struct mmc_queue *mq = &md->queue;
+	int cache_size = atomic_read(&mq->cache_size);
+	int ret;
+
+	if (!cache_size)
+		ret = scnprintf(buf, PAGE_SIZE, off);
+	else {
+		int speed = atomic_read(&mq->max_write_speed);
+
+		if (!speed_valid(speed))
+			ret = scnprintf(buf, PAGE_SIZE, "%uMB\n", cache_size);
+		else { /* We accept race between cache_jiffies and cache_used */
+			unsigned long size = jiffies_and_speed_to_size(
+				jiffies - mq->cache_jiffies, speed);
+			long used = atomic_long_read(&mq->cache_used);
+
+			if (size >= used)
+				size = 0;
+			else
+				size = (used - size) * 100 / cache_size
+					/ 1024UL / 1024UL;
+
+			ret = scnprintf(buf, PAGE_SIZE, "%uMB %lu%% used\n",
+				cache_size, size);
+		}
+	}
+
+	mmc_blk_put(md);
+	return ret;
+}
+
+static ssize_t cache_size_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct mmc_blk_data *md;
+	long set = 0;
+
+	if (strncasecmp(off, buf, sizeof(off) - 2)
+	 && (kstrtol(buf, 0, &set) || (set < 0) || (set > INT_MAX)))
+		return -EINVAL;
+
+	md = mmc_blk_get(dev_to_disk(dev));
+	atomic_set(&md->queue.cache_size, set);
+	mmc_blk_put(md);
+	return count;
+}
+
+static const DEVICE_ATTR(cache_size, S_IRUGO | S_IWUSR,
+	cache_size_show, cache_size_store);
+
+/* correct for write-back */
+static long mmc_blk_cache_used(struct mmc_queue *mq, unsigned long waitfor)
+{
+	long used = 0;
+	int speed = atomic_read(&mq->max_write_speed);
+
+	if (speed_valid(speed)) {
+		unsigned long size = jiffies_and_speed_to_size(
+					waitfor - mq->cache_jiffies, speed);
+		used = atomic_long_read(&mq->cache_used);
+
+		if (size >= used)
+			used = 0;
+		else
+			used -= size;
+	}
+
+	atomic_long_set(&mq->cache_used, used);
+	mq->cache_jiffies = waitfor;
+
+	return used;
+}
+
+static void mmc_blk_waitfor_completion(
+	struct mmc_queue *mq,
+	struct request *req,
+	unsigned long waitfor)
+{
+	int max_speed;
+
+	if (!req)
+		return;
+
+	max_speed = (rq_data_dir(req) == READ)
+		? atomic_read(&mq->max_read_speed)
+		: atomic_read(&mq->max_write_speed);
+	if (speed_valid(max_speed)) {
+		unsigned long bytes = blk_rq_bytes(req);
+
+		if (rq_data_dir(req) != READ) {
+			int cache_size = atomic_read(&mq->cache_size);
+
+			if (cache_size) {
+				unsigned long size = cache_size * 1024L * 1024L;
+				long used = mmc_blk_cache_used(mq, waitfor);
+
+				used += bytes;
+				atomic_long_set(&mq->cache_used, used);
+				bytes = 0;
+				if (used > size)
+					bytes = used - size;
+			}
+		}
+		waitfor += size_and_speed_to_jiffies(bytes, max_speed);
+		if (time_is_after_jiffies(waitfor)) {
+			unsigned long msecs = jiffies_to_msecs(
+					waitfor - jiffies);
+			if (msecs)
+				msleep(msecs);
+		}
+	}
+}
+
+#else
+
+#define mmc_blk_waitfor_completion(mq, req, waitfor)
+
+#endif
+
 static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
@@ -1251,6 +1487,23 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	if (ret)
 		ret = -EIO;
 
+#ifdef CONFIG_MMC_BLOCK_MAX_SPEED
+	else if (atomic_read(&mq->cache_size)) {
+		long used = mmc_blk_cache_used(mq, jiffies);
+
+		if (used) {
+			int speed = atomic_read(&mq->max_write_speed);
+
+			if (speed_valid(speed)) {
+				unsigned long msecs = jiffies_to_msecs(
+					size_and_speed_to_jiffies(
+						used, speed));
+				if (msecs)
+					msleep(msecs);
+			}
+		}
+	}
+#endif
 	blk_end_request_all(req, ret);
 
 	return ret ? 0 : 1;
@@ -1930,6 +2183,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct mmc_async_req *areq;
 	const u8 packed_nr = 2;
 	u8 reqs = 0;
+#ifdef CONFIG_MMC_BLOCK_MAX_SPEED
+	unsigned long waitfor = jiffies;
+#endif
 
 	if (!rqc && !mq->mqrq_prev->req)
 		return 0;
@@ -1980,6 +2236,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 */
 			mmc_blk_reset_success(md, type);
 
+			mmc_blk_waitfor_completion(mq, rqc, waitfor);
+
 			if (mmc_packed_cmd(mq_rq->cmd_type)) {
 				ret = mmc_blk_end_packed_req(mq_rq);
 				break;
@@ -2398,6 +2656,14 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 					card->ext_csd.boot_ro_lockable)
 				device_remove_file(disk_to_dev(md->disk),
 					&md->power_ro_lock);
+#ifdef CONFIG_MMC_BLOCK_MAX_SPEED
+			device_remove_file(disk_to_dev(md->disk),
+						&dev_attr_max_write_speed);
+			device_remove_file(disk_to_dev(md->disk),
+						&dev_attr_max_read_speed);
+			device_remove_file(disk_to_dev(md->disk),
+						&dev_attr_cache_size);
+#endif
 
 			del_gendisk(md->disk);
 		}
@@ -2433,6 +2699,27 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
 	if (ret)
 		goto force_ro_fail;
+#ifdef CONFIG_MMC_BLOCK_MAX_SPEED
+	atomic_set(&md->queue.max_write_speed,
+			CONFIG_MMC_BLOCK_MAX_WRITE_SPEED);
+	ret = device_create_file(disk_to_dev(md->disk),
+			&dev_attr_max_write_speed);
+	if (ret)
+		goto max_write_speed_fail;
+	atomic_set(&md->queue.max_read_speed,
+			CONFIG_MMC_BLOCK_MAX_READ_SPEED);
+	ret = device_create_file(disk_to_dev(md->disk),
+			&dev_attr_max_read_speed);
+	if (ret)
+		goto max_read_speed_fail;
+	atomic_set(&md->queue.cache_size,
+			CONFIG_MMC_BLOCK_MAX_SPEED_CACHE_SIZE);
+	atomic_long_set(&md->queue.cache_used, 0);
+	md->queue.cache_jiffies = jiffies;
+	ret = device_create_file(disk_to_dev(md->disk), &dev_attr_cache_size);
+	if (ret)
+		goto cache_size_fail;
+#endif
 
 	if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
 	     card->ext_csd.boot_ro_lockable) {
@@ -2457,6 +2744,14 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	return ret;
 
 power_ro_lock_fail:
+#ifdef CONFIG_MMC_BLOCK_MAX_SPEED
+	device_remove_file(disk_to_dev(md->disk), &dev_attr_cache_size);
+cache_size_fail:
+	device_remove_file(disk_to_dev(md->disk), &dev_attr_max_read_speed);
+max_read_speed_fail:
+	device_remove_file(disk_to_dev(md->disk), &dev_attr_max_write_speed);
+max_write_speed_fail:
+#endif
 	device_remove_file(disk_to_dev(md->disk), &md->force_ro);
 force_ro_fail:
 	del_gendisk(md->disk);
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 36cddab..fd7cef8 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -58,6 +58,14 @@ struct mmc_queue {
 	struct mmc_queue_req	mqrq[2];
 	struct mmc_queue_req	*mqrq_cur;
 	struct mmc_queue_req	*mqrq_prev;
+#ifdef CONFIG_MMC_BLOCK_MAX_SPEED
+	atomic_t max_write_speed;
+	atomic_t max_read_speed;
+	atomic_t cache_size;
+	/* i/o tracking */
+	atomic_long_t cache_used;
+	unsigned long cache_jiffies;
+#endif
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-- 
2.7.0.rc3.207.g0ac5344
