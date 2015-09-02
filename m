From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH] mmc: block: Add new ioctl to send combo commands
Date: Wed, 2 Sep 2015 15:21:51 +0100
Message-ID: <1441203711-19538-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4411 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbbIBOWI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2015 10:22:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Olof Johansson <olofj@chromium.org>, Seshagiri Holi <sholi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>

From: Seshagiri Holi <sholi@nvidia.com>

Certain eMMC devices allow vendor specific device information to be read
via a sequence of vendor commands. These vendor commands must be issued
in sequence and an atomic fashion. One way to support this would be to
add an ioctl function for sending a sequence of commands to the device
atomically as proposed here. These combo commands are simple array of
the existing mmc_ioc_cmd structure.

Signed-off-by: Seshagiri Holi <sholi@nvidia.com>
[ jonathanh@nvidia.com: Rebased on linux-next from v3.18 and updated
  commit message ]
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
I am not sure if there are other/better ways to support this, and so
if this approach is not acceptable, other suggestions would be great.
Thanks!

I still need to test this updated version for -next but wanted to get
some feedback on the approach.

 drivers/mmc/card/block.c       | 199 ++++++++++++++++++++++++++++++++---------
 include/uapi/linux/mmc/ioctl.h |  17 +++-
 2 files changed, 171 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c742cfd7674e..fe2bca75b997 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -387,6 +387,22 @@ out:
 	return ERR_PTR(err);
 }
 
+static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
+				      struct mmc_blk_ioc_data *idata)
+{
+	if (copy_to_user(&(ic_ptr->response), idata->ic.response,
+			 sizeof(idata->ic.response)))
+		return -EFAULT;
+
+	if (!idata->ic.write_flag) {
+		if (copy_to_user((void __user *)(unsigned long)idata->ic.data_ptr,
+				 idata->buf, idata->buf_bytes))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
 				       u32 retries_max)
 {
@@ -447,12 +463,9 @@ out:
 	return err;
 }
 
-static int mmc_blk_ioctl_cmd(struct block_device *bdev,
-	struct mmc_ioc_cmd __user *ic_ptr)
+static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
+			       struct mmc_blk_ioc_data *idata)
 {
-	struct mmc_blk_ioc_data *idata;
-	struct mmc_blk_data *md;
-	struct mmc_card *card;
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct mmc_request mrq = {NULL};
@@ -461,33 +474,12 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	int is_rpmb = false;
 	u32 status = 0;
 
-	/*
-	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
-	 * whole block device, not on a partition.  This prevents overspray
-	 * between sibling partitions.
-	 */
-	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
-		return -EPERM;
-
-	idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
-	if (IS_ERR(idata))
-		return PTR_ERR(idata);
-
-	md = mmc_blk_get(bdev->bd_disk);
-	if (!md) {
-		err = -EINVAL;
-		goto cmd_err;
-	}
+	if (!card || !md || !idata)
+		return -EINVAL;
 
 	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
 		is_rpmb = true;
 
-	card = md->queue.card;
-	if (IS_ERR(card)) {
-		err = PTR_ERR(card);
-		goto cmd_done;
-	}
-
 	cmd.opcode = idata->ic.opcode;
 	cmd.arg = idata->ic.arg;
 	cmd.flags = idata->ic.flags;
@@ -582,18 +574,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	if (copy_to_user(&(ic_ptr->response), cmd.resp, sizeof(cmd.resp))) {
-		err = -EFAULT;
-		goto cmd_rel_host;
-	}
-
-	if (!idata->ic.write_flag) {
-		if (copy_to_user((void __user *)(unsigned long) idata->ic.data_ptr,
-						idata->buf, idata->buf_bytes)) {
-			err = -EFAULT;
-			goto cmd_rel_host;
-		}
-	}
+	memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
 
 	if (is_rpmb) {
 		/*
@@ -609,6 +590,48 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 cmd_rel_host:
 	mmc_put_card(card);
+	return err;
+}
+
+static int mmc_blk_ioctl_cmd(struct block_device *bdev,
+			struct mmc_ioc_cmd __user *ic_ptr)
+{
+	struct mmc_blk_ioc_data *idata;
+	struct mmc_blk_data *md;
+	struct mmc_card *card;
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
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md) {
+		err = -EINVAL;
+		goto cmd_err;
+	}
+
+	card = md->queue.card;
+	if (IS_ERR(card)) {
+		err = PTR_ERR(card);
+		goto cmd_done;
+	}
+
+	mmc_claim_host(card->host);
+
+	err = __mmc_blk_ioctl_cmd(card, md, idata);
+
+	mmc_release_host(card->host);
+
+	err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
 
 cmd_done:
 	mmc_blk_put(md);
@@ -618,13 +641,101 @@ cmd_err:
 	return err;
 }
 
+static int mmc_blk_ioctl_combo_cmd(struct block_device *bdev,
+				   struct mmc_ioc_combo_cmd __user *user)
+{
+	struct mmc_ioc_combo_cmd mcci = {0};
+	struct mmc_blk_ioc_data **ioc_data = NULL;
+	struct mmc_ioc_cmd __user *usr_ptr;
+	struct mmc_card *card;
+	struct mmc_blk_data *md;
+	int i, err = -EFAULT;
+	u8 n_cmds = 0;
+
+	/*
+	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
+	 * whole block device, not on a partition.  This prevents overspray
+	 * between sibling partitions.
+	 */
+	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
+		return -EPERM;
+
+	if (copy_from_user(&mcci, user, sizeof(struct mmc_ioc_combo_cmd)))
+		return -EFAULT;
+
+	if (!mcci.num_of_cmds) {
+		err = -EINVAL;
+		goto cmd_err;
+	}
+
+	ioc_data = kcalloc(mcci.num_of_cmds, sizeof(*ioc_data), GFP_KERNEL);
+	if (!ioc_data) {
+		err = -ENOMEM;
+		goto cmd_err;
+	}
+
+	usr_ptr = (void * __user)mcci.mmc_ioc_cmd_list;
+	for (n_cmds = 0; n_cmds < mcci.num_of_cmds; n_cmds++) {
+		ioc_data[n_cmds] =
+			mmc_blk_ioctl_copy_from_user(&usr_ptr[n_cmds]);
+		if (IS_ERR(ioc_data[n_cmds])) {
+			err = PTR_ERR(ioc_data[n_cmds]);
+			goto cmd_err;
+		}
+	}
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md)
+		goto cmd_err;
+
+	card = md->queue.card;
+	if (IS_ERR(card)) {
+		err = PTR_ERR(card);
+		goto cmd_done;
+	}
+
+	mmc_claim_host(card->host);
+	for (i = 0; i < n_cmds; i++) {
+		err = __mmc_blk_ioctl_cmd(card, md, ioc_data[i]);
+		if (err) {
+			mmc_release_host(card->host);
+			goto cmd_done;
+		}
+	}
+
+	mmc_release_host(card->host);
+
+	/* copy to user if data and response */
+	for (i = 0; i < n_cmds; i++) {
+		err = mmc_blk_ioctl_copy_to_user(&usr_ptr[i], ioc_data[i]);
+		if (err)
+			break;
+	}
+
+cmd_done:
+	mmc_blk_put(md);
+cmd_err:
+	for (i = 0; i < n_cmds; i++) {
+		kfree(ioc_data[i]->buf);
+		kfree(ioc_data[i]);
+	}
+	kfree(ioc_data);
+	return err;
+}
+
 static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
-	int ret = -EINVAL;
-	if (cmd == MMC_IOC_CMD)
-		ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
-	return ret;
+	switch (cmd) {
+	case MMC_COMBO_IOC_CMD:
+		return mmc_blk_ioctl_combo_cmd(bdev,
+				(struct mmc_ioc_combo_cmd __user *)arg);
+	case MMC_IOC_CMD:
+		return mmc_blk_ioctl_cmd(bdev,
+				(struct mmc_ioc_cmd __user *)arg);
+	default:
+		return -EINVAL;
+	}
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
index 1f5e68923929..5943e51f22b3 100644
--- a/include/uapi/linux/mmc/ioctl.h
+++ b/include/uapi/linux/mmc/ioctl.h
@@ -45,8 +45,23 @@ struct mmc_ioc_cmd {
 };
 #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
 
-#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
+/**
+ * struct mmc_ioc_combo_cmd - combo command information
+ * @num_of_cmds: number of commands to send
+ * @mmc_ioc_cmd_list: pointer to list of commands
+ */
+struct mmc_ioc_combo_cmd {
+	uint8_t num_of_cmds;
+	struct mmc_ioc_cmd *mmc_ioc_cmd_list;
+};
 
+#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
+/*
+ * MMC_COMBO_IOC_CMD: Used to send an array of MMC commands described by
+ *	the structure mmc_ioc_combo_cmd. The MMC driver will issue all
+ *	commands in array in sequence to card.
+ */
+#define MMC_COMBO_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 1, struct mmc_ioc_combo_cmd)
 /*
  * Since this ioctl is only meant to enhance (and not replace) normal access
  * to the mmc bus device, an upper data transfer limit of MMC_IOC_MAX_BYTES
-- 
2.1.4

