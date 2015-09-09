From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] mmc: block: Add new ioctl to send multi commands
Date: Wed, 9 Sep 2015 16:06:01 +0100
Message-ID: <1441811161-18513-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: grundler@google.com, olofj@chromium.org, Seshagiri Holi <sholi@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

From: Seshagiri Holi <sholi@nvidia.com>

Certain eMMC devices allow vendor specific device information to be read
via a sequence of vendor commands. These vendor commands must be issued
in sequence and an atomic fashion. One way to support this would be to
add an ioctl function for sending a sequence of commands to the device
atomically as proposed here. These multi commands are simple array of
the existing mmc_ioc_cmd structure.

Signed-off-by: Seshagiri Holi <sholi@nvidia.com>
[ jonathanh@nvidia.com: Rebased on linux-next from v3.18. Changed
  userspace pointer type for multi command to be a u64. Renamed
  from combo commands to multi commands. Updated patch based upon
  feedback review comments received. Updated commit message ]
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/mmc/card/block.c       | 198 ++++++++++++++++++++++++++++++++---------
 include/uapi/linux/mmc/ioctl.h |  17 +++-
 2 files changed, 170 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c742cfd7674e..738bfd037209 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -387,6 +387,24 @@ out:
 	return ERR_PTR(err);
 }
 
+static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
+				      struct mmc_blk_ioc_data *idata)
+{
+	struct mmc_ioc_cmd *ic = &idata->ic;
+
+	if (copy_to_user(&(ic_ptr->response), ic->response,
+			 sizeof(ic->response)))
+		return -EFAULT;
+
+	if (!idata->ic.write_flag) {
+		if (copy_to_user((void __user *)(unsigned long)ic->data_ptr,
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
@@ -447,12 +465,9 @@ out:
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
@@ -461,33 +476,12 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
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
@@ -582,18 +576,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
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
@@ -609,6 +592,46 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 cmd_rel_host:
 	mmc_put_card(card);
+	return err;
+}
+
+static int mmc_blk_ioctl_cmd(struct block_device *bdev,
+			     struct mmc_ioc_cmd __user *ic_ptr)
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
+	err = __mmc_blk_ioctl_cmd(card, md, idata);
+	if (err)
+		goto cmd_done;
+
+	err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
 
 cmd_done:
 	mmc_blk_put(md);
@@ -618,13 +641,100 @@ cmd_err:
 	return err;
 }
 
+static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
+				   struct mmc_ioc_multi_cmd __user *user)
+{
+	struct mmc_ioc_multi_cmd mcci = {0};
+	struct mmc_blk_ioc_data **idata = NULL;
+	struct mmc_ioc_cmd __user *cmds;
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
+	if (copy_from_user(&mcci, user, sizeof(struct mmc_ioc_multi_cmd)))
+		return -EFAULT;
+
+	if (!mcci.num_of_cmds) {
+		err = -EINVAL;
+		goto cmd_err;
+	}
+
+	idata = kcalloc(mcci.num_of_cmds, sizeof(*idata), GFP_KERNEL);
+	if (!idata) {
+		err = -ENOMEM;
+		goto cmd_err;
+	}
+
+	cmds = (struct mmc_ioc_cmd __user *)(unsigned long)mcci.cmds_ptr;
+	for (n_cmds = 0; n_cmds < mcci.num_of_cmds; n_cmds++) {
+		idata[n_cmds] = mmc_blk_ioctl_copy_from_user(&cmds[n_cmds]);
+		if (IS_ERR(idata[n_cmds])) {
+			err = PTR_ERR(idata[n_cmds]);
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
+	mmc_get_card(card);
+	for (i = 0; i < n_cmds; i++) {
+		err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
+		if (err) {
+			mmc_release_host(card->host);
+			goto cmd_done;
+		}
+	}
+
+	mmc_put_card(card);
+
+	/* copy to user if data and response */
+	for (i = 0; i < n_cmds; i++) {
+		err = mmc_blk_ioctl_copy_to_user(&cmds[i], idata[i]);
+		if (err)
+			break;
+	}
+
+cmd_done:
+	mmc_blk_put(md);
+cmd_err:
+	for (i = 0; i < n_cmds; i++) {
+		kfree(idata[i]->buf);
+		kfree(idata[i]);
+	}
+	kfree(idata);
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
+	case MMC_IOC_CMD:
+		return mmc_blk_ioctl_cmd(bdev,
+				(struct mmc_ioc_cmd __user *)arg);
+	case MMC_IOC_MULTI_CMD:
+		return mmc_blk_ioctl_multi_cmd(bdev,
+				(struct mmc_ioc_multi_cmd __user *)arg);
+	default:
+		return -EINVAL;
+	}
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
index 1f5e68923929..6b9a962dbee3 100644
--- a/include/uapi/linux/mmc/ioctl.h
+++ b/include/uapi/linux/mmc/ioctl.h
@@ -45,8 +45,23 @@ struct mmc_ioc_cmd {
 };
 #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
 
-#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
+/**
+ * struct mmc_ioc_multi_cmd - multi command information
+ * @cmds_ptr: Address of the location where the list of commands resides
+ * @num_of_cmds: number of commands to send
+ */
+struct mmc_ioc_multi_cmd {
+	__u64 cmds_ptr;
+	uint8_t num_of_cmds;
+};
 
+#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
+/*
+ * MMC_IOC_MULTI_CMD: Used to send an array of MMC commands described by
+ *	the structure mmc_ioc_multi_cmd. The MMC driver will issue all
+ *	commands in array in sequence to card.
+ */
+#define MMC_IOC_MULTI_CMD _IOWR(MMC_BLOCK_MAJOR, 1, struct mmc_ioc_multi_cmd)
 /*
  * Since this ioctl is only meant to enhance (and not replace) normal access
  * to the mmc bus device, an upper data transfer limit of MMC_IOC_MAX_BYTES
-- 
2.1.4
