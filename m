From: John Calixto <john.calixto@modsystems.com>
Subject: [PATCH v2 1/2] mmc: Add ioctl to let userspace apps send ACMDs
Date: Tue, 5 Apr 2011 14:57:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104051450480.25803@peruna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:44115 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940Ab1DEV5X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 17:57:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

Sending ACMDs from userspace is useful for such things as:

    - The security application of an SD card (SD Specification, Part 3,
      Security)

    - SD passthrough for virtual machines

Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621
SoC, TI OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.

Signed-off-by: John Calixto <john.calixto@modsystems.com>
---
 drivers/mmc/card/block.c  |  191 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sd_ops.c |    3 +-
 include/linux/mmc/core.h  |    1 +
 include/linux/mmc/sd.h    |   16 ++++
 4 files changed, 210 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 61d233a..c2e107c 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -31,6 +31,8 @@
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -158,11 +160,200 @@ mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
+static int mmc_blk_ioctl_acmd(struct block_device *bdev,
+	struct sd_ioc_cmd __user *sdic_ptr)
+{
+	struct sd_ioc_cmd sdic;
+	struct mmc_blk_data *md;
+	struct mmc_host *host;
+	struct mmc_card *card;
+	struct mmc_command cmd = {0};
+	struct mmc_data data = {0};
+	struct mmc_request mrq = {0};
+	struct scatterlist sg = {0};
+	unsigned char *blocks = NULL;
+	size_t data_bytes;
+	int err;
+
+	/*
+	 * Only allow ACMDs on the whole block device, not on partitions.  This
+	 * prevents overspray between sibling partitions.
+	 */
+	if (bdev != bdev->bd_contains)
+		return -EPERM;
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md)
+		return -EINVAL;
+
+	card = md->queue.card;
+	if (IS_ERR(card))
+		return PTR_ERR(card);
+
+	host = card->host;
+	mmc_claim_host(host);
+
+	err = mmc_app_cmd(host, card);
+	if (err)
+		goto acmd_done;
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	if (copy_from_user(&sdic, sdic_ptr, sizeof(sdic))) {
+		err = -EFAULT;
+		goto acmd_done;
+	}
+
+	cmd.opcode = sdic.opcode;
+	cmd.arg = sdic.arg;
+	cmd.flags = sdic.flags;
+
+	data.sg = &sg;
+	data.sg_len = 1;
+	data.blksz = sdic.blksz;
+	data.blocks = sdic.blocks;
+
+	data_bytes = data.blksz * data.blocks;
+	blocks = kzalloc(data_bytes, GFP_KERNEL);
+	if (!blocks) {
+		err = -ENOMEM;
+		goto acmd_done;
+	}
+	sg_init_one(data.sg, blocks, data_bytes);
+
+
+	if (copy_from_user(blocks, sdic_ptr->data_ptr, data_bytes)) {
+		err = -EFAULT;
+		goto acmd_done;
+	}
+	if (sdic.write_flag)
+		data.flags = MMC_DATA_WRITE;
+	else
+		data.flags = MMC_DATA_READ;
+
+	/* data.flags must already be set before doing this. */
+	mmc_set_data_timeout(&data, card);
+	/* Allow overriding the timeout_ns for empirical tuning. */
+	if (sdic.force_timeout_ns)
+		data.timeout_ns = sdic.force_timeout_ns;
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (cmd.error) {
+		dev_err(mmc_dev(host), "%s: cmd error %d\n",
+						__func__, cmd.error);
+		err = cmd.error;
+		goto acmd_done;
+	}
+	if (data.error) {
+		dev_err(mmc_dev(host), "%s: data error %d\n",
+						__func__, data.error);
+		err = data.error;
+		goto acmd_done;
+	}
+
+	/*
+	 * According to the SD specs, some commands require a delay after
+	 * issuing the command.
+	 */
+	if (sdic.postsleep_us)
+		udelay(sdic.postsleep_us);
+
+	if (copy_to_user(&(sdic_ptr->response), cmd.resp, sizeof(cmd.resp))) {
+		err = -EFAULT;
+		goto acmd_done;
+	}
+
+	if (!sdic.write_flag) {
+		if (copy_to_user(sdic_ptr->data_ptr, blocks, data_bytes)) {
+			err = -EFAULT;
+			goto acmd_done;
+		}
+	}
+
+acmd_done:
+	kfree(blocks);
+	mmc_release_host(host);
+	mmc_blk_put(md);
+	return err;
+}
+
+static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
+	unsigned int cmd, unsigned long arg)
+{
+	int ret = -EINVAL;
+	mutex_lock(&block_mutex);
+	if (cmd == SD_IOC_ACMD)
+		ret = mmc_blk_ioctl_acmd(bdev, (struct sd_ioc_cmd __user *)arg);
+	mutex_unlock(&block_mutex);
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+struct sd_ioc_cmd32 {
+	u32 write_flag;
+	u32 opcode;
+	u32 arg;
+	u32 response[4];
+	u32 flags;
+	u32 blksz;
+	u32 blocks;
+	u32 postsleep_us;
+	u32 force_timeout_ns;
+	compat_uptr_t data_ptr;
+};
+#define SD_IOC_ACMD32 _IOWR(MMC_BLOCK_MAJOR, 0, struct sd_ioc_cmd32)
+
+static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
+	unsigned int cmd, unsigned long arg)
+{
+	struct sd_ioc_cmd32 __user *sdic32 = (struct sd_ioc_cmd32 __user *) arg;
+	struct sd_ioc_cmd sdic;
+	struct sd_ioc_cmd __user *tmp = compat_alloc_user_space(sizeof(sdic));
+	u32 cp;
+	int err;
+
+	if (cmd != SD_IOC_ACMD32)
+		return -ENOIOCTLCMD;
+
+	err = 0;
+	err |= get_user(sdic.write_flag, &sdic32->write_flag);
+	err |= get_user(sdic.opcode, &sdic32->opcode);
+	err |= get_user(sdic.arg, &sdic32->arg);
+	err |= get_user(sdic.flags, &sdic32->flags);
+	err |= get_user(sdic.blksz, &sdic32->blksz);
+	err |= get_user(sdic.blocks, &sdic32->blocks);
+	err |= get_user(sdic.postsleep_us, &sdic32->postsleep_us);
+	err |= get_user(sdic.force_timeout_ns, &sdic32->force_timeout_ns);
+	err |= get_user(cp, &sdic32->data_ptr);
+	sdic.data_ptr = compat_ptr(cp);
+	err |= copy_to_user(tmp, &sdic, sizeof(sdic));
+	if (err)
+		return -EFAULT;
+
+	err = mmc_blk_ioctl(bdev, mode, SD_IOC_ACMD, (unsigned long) tmp);
+	if (err)
+		return err;
+
+	err |= copy_in_user(&sdic32->response, &tmp->response,
+					sizeof(sdic32->response));
+	if (err)
+		return -EFAULT;
+
+	return err;
+}
+#endif
+
 static const struct block_device_operations mmc_bdops = {
 	.open			= mmc_blk_open,
 	.release		= mmc_blk_release,
 	.getgeo			= mmc_blk_getgeo,
 	.owner			= THIS_MODULE,
+	.ioctl			= mmc_blk_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= mmc_blk_compat_ioctl,
+#endif
 };
 
 struct mmc_blk_request {
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 797cdb5..990dd43 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -20,7 +20,7 @@
 #include "core.h"
 #include "sd_ops.h"
 
-static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
+int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 {
 	int err;
 	struct mmc_command cmd;
@@ -48,6 +48,7 @@ static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mmc_app_cmd);
 
 /**
  *	mmc_wait_for_app_cmd - start an application command and wait for
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 07f27af..bfc6127 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -133,6 +133,7 @@ struct mmc_card;
 
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *, int);
+extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
 extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
 	struct mmc_command *, int);
 
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 3fd85e0..8ead3c8 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -12,6 +12,8 @@
 #ifndef MMC_SD_H
 #define MMC_SD_H
 
+#include <linux/ioctl.h>
+
 /* SD commands                           type  argument     response */
   /* class 0 */
 /* This is basically the same command as for MMC with some quirks. */
@@ -84,5 +86,19 @@
 #define SD_SWITCH_ACCESS_DEF	0
 #define SD_SWITCH_ACCESS_HS	1
 
+struct sd_ioc_cmd {
+	int write_flag;  /* implies direction of data.  true = write, false = read */
+	__u32 opcode;
+	__u32 arg;
+	__u32 response[4];  /* CMD response */
+	unsigned int flags;
+	unsigned int blksz;
+	unsigned int blocks;
+	unsigned int postsleep_us;  /* apply usecond delay *after* issuing command */
+	unsigned int force_timeout_ns;  /* force timeout to be force_timeout_ns ns */
+	__u8 *data_ptr;  /* DAT buffer */
+};
+#define SD_IOC_ACMD _IOWR(MMC_BLOCK_MAJOR, 0, struct sd_ioc_cmd)
+
 #endif
 
-- 
1.7.4.1

