From: John Calixto <john.calixto@modsystems.com>
Subject: [PATCH v5] mmc: Add ioctl to let userspace apps send ACMDs
Date: Tue, 12 Apr 2011 15:57:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104121555150.8483@peruna>
References: <alpine.DEB.2.00.1104121544380.8483@peruna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:37270 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751867Ab1DLW5t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 18:57:49 -0400
In-Reply-To: <alpine.DEB.2.00.1104121544380.8483@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Andrei Warkentin <andreiw@motorola.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

Sending ACMDs from userspace is useful for such things as:

    - The security application of an SD card (SD Specification, Part 3,
      Security)

    - SD passthrough for virtual machines

Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621
SoC, TI OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.

Signed-off-by: John Calixto <john.calixto@modsystems.com>
Reviewed-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c  |  196 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sd_ops.c |    3 +-
 include/linux/Kbuild      |    1 +
 include/linux/mmc/Kbuild  |    1 +
 include/linux/mmc/core.h  |    1 +
 include/linux/mmc/ioctl.h |   37 +++++++++
 6 files changed, 238 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/mmc/Kbuild
 create mode 100644 include/linux/mmc/ioctl.h

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 61d233a..98f7a5e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -31,7 +31,10 @@
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
+#include <linux/delay.h>
+#include <linux/capability.h>
 
+#include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -158,11 +161,204 @@ mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
+struct mmc_blk_ioc_data {
+	struct mmc_ioc_cmd ic;
+	unsigned char *buf;
+	size_t buf_bytes;
+};
+
+static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
+	struct mmc_ioc_cmd __user *user)
+{
+	struct mmc_blk_ioc_data *idata;
+	int err;
+
+	idata = kzalloc(sizeof(*idata), GFP_KERNEL);
+	if (!idata) {
+		err = -ENOMEM;
+		goto copy_err;
+	}
+
+	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
+		err = -EFAULT;
+		goto copy_err;
+	}
+
+	idata->buf_bytes = idata->ic.blksz * idata->ic.blocks;
+
+	idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
+	if (!idata->buf) {
+		err = -ENOMEM;
+		goto copy_err;
+	}
+
+	if (copy_from_user(idata->buf, user->data_ptr, idata->buf_bytes)) {
+		err = -EFAULT;
+		goto copy_err;
+	}
+
+	return idata;
+
+copy_err:
+	kfree(idata->buf);
+	kfree(idata);
+	return ERR_PTR(err);
+
+}
+
+static int mmc_blk_ioctl_acmd(struct block_device *bdev,
+	struct mmc_ioc_cmd __user *ic_ptr)
+{
+	struct mmc_blk_ioc_data *idata;
+	struct mmc_blk_data *md;
+	struct mmc_card *card;
+	struct mmc_command cmd = {0};
+	struct mmc_data data = {0};
+	struct mmc_request mrq = {0};
+	struct scatterlist sg;
+	int err;
+
+	/*
+	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
+	 * whole block device, not on a partition.  This prevents overspray
+	 * between sibling partitions.
+	 */
+	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
+		return -EPERM;
+
+	idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
+	if (IS_ERR(idata))
+		return PTR_ERR(idata);
+
+	cmd.opcode = idata->ic.opcode;
+	cmd.arg = idata->ic.arg;
+	cmd.flags = idata->ic.flags;
+
+	data.sg = &sg;
+	data.sg_len = 1;
+	data.blksz = idata->ic.blksz;
+	data.blocks = idata->ic.blocks;
+
+	sg_init_one(data.sg, idata->buf, idata->buf_bytes);
+
+	if (idata->ic.write_flag)
+		data.flags = MMC_DATA_WRITE;
+	else
+		data.flags = MMC_DATA_READ;
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md) {
+		err = -EINVAL;
+		goto acmd_done;
+	}
+
+	card = md->queue.card;
+	if (IS_ERR(card)) {
+		err = PTR_ERR(card);
+		goto acmd_done;
+	}
+
+	mmc_claim_host(card->host);
+
+	err = mmc_app_cmd(card->host, card);
+	if (err)
+		goto acmd_rel_host;
+
+	/* data.flags must already be set before doing this. */
+	mmc_set_data_timeout(&data, card);
+	/* Allow overriding the timeout_ns for empirical tuning. */
+	if (idata->ic.data_timeout_ns)
+		data.timeout_ns = idata->ic.data_timeout_ns;
+
+	if ((cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+		/*
+		 * Pretend this is a data transfer and rely on the host driver
+		 * to compute timeout.  When all host drivers support
+		 * cmd.cmd_timeout for R1B, this can be changed to:
+		 *
+		 *     mrq.data = NULL;
+		 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
+		 */
+		data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
+	}
+
+	mmc_wait_for_req(card->host, &mrq);
+
+	if (cmd.error) {
+		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
+						__func__, cmd.error);
+		err = cmd.error;
+		goto acmd_rel_host;
+	}
+	if (data.error) {
+		dev_err(mmc_dev(card->host), "%s: data error %d\n",
+						__func__, data.error);
+		err = data.error;
+		goto acmd_rel_host;
+	}
+
+	/*
+	 * According to the SD specs, some commands require a delay after
+	 * issuing the command.
+	 */
+	if (idata->ic.postsleep_min_us)
+		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
+
+	if (copy_to_user(&(ic_ptr->response), cmd.resp, sizeof(cmd.resp))) {
+		err = -EFAULT;
+		goto acmd_rel_host;
+	}
+
+	if (!idata->ic.write_flag) {
+		if (copy_to_user(ic_ptr->data_ptr, idata->buf, idata->buf_bytes)) {
+			err = -EFAULT;
+			goto acmd_rel_host;
+		}
+	}
+
+acmd_rel_host:
+	mmc_release_host(card->host);
+
+acmd_done:
+	mmc_blk_put(md);
+	kfree(idata->buf);
+	kfree(idata);
+	return err;
+}
+
+static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
+	unsigned int cmd, unsigned long arg)
+{
+	int ret = -EINVAL;
+	mutex_lock(&block_mutex);
+	if (cmd == MMC_IOC_ACMD)
+		ret = mmc_blk_ioctl_acmd(bdev, (struct mmc_ioc_cmd __user *)arg);
+	mutex_unlock(&block_mutex);
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode,
+	unsigned int cmd, unsigned long arg)
+{
+	struct mmc_ioc_cmd __user *ic = (struct mmc_ioc_cmd __user *) arg;
+	ic->data_pad = ic->data_pad & 0xffffffff;
+	return mmc_blk_ioctl(bdev, mode, cmd, arg);
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
diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 75cf611..ed38527 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -4,6 +4,7 @@ header-y += caif/
 header-y += dvb/
 header-y += hdlc/
 header-y += isdn/
+header-y += mmc/
 header-y += nfsd/
 header-y += raid/
 header-y += spi/
diff --git a/include/linux/mmc/Kbuild b/include/linux/mmc/Kbuild
new file mode 100644
index 0000000..1fb2644
--- /dev/null
+++ b/include/linux/mmc/Kbuild
@@ -0,0 +1 @@
+header-y += ioctl.h
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
 
diff --git a/include/linux/mmc/ioctl.h b/include/linux/mmc/ioctl.h
new file mode 100644
index 0000000..7f2e0b5
--- /dev/null
+++ b/include/linux/mmc/ioctl.h
@@ -0,0 +1,37 @@
+#ifndef _MMC_IOCTL_H
+#define _MMC_IOCTL_H
+struct mmc_ioc_cmd {
+	/* implies direction of data.  true = write, false = read */
+	int write_flag;
+
+	__u32 opcode;
+	__u32 arg;
+	__u32 response[4];  /* CMD response */
+	unsigned int flags;
+	unsigned int blksz;
+	unsigned int blocks;
+
+	/*
+	 * Sleep at least postsleep_min_us useconds, and at most
+	 * postsleep_max_us useconds *after* issuing command.  Needed for some
+	 * read commands for which cards have no other way of indicating
+	 * they're ready for the next command (i.e. there is no equivalent of a
+	 * "busy" indicator for read operations).
+	 */
+	unsigned int postsleep_min_us;
+	unsigned int postsleep_max_us;
+
+	/*
+	 * Override driver-computed timeouts.  Note the difference in units!
+	 */
+	unsigned int data_timeout_ns;
+	unsigned int cmd_timeout_ms;
+
+	/* DAT buffer */
+	union {
+		unsigned char *data_ptr;
+		__u64 data_pad;  /* compat */
+	};
+};
+#define MMC_IOC_ACMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
+#endif  /* _MMC_IOCTL_H */
-- 
1.7.4.1

