From: Chris Ball <cjb@laptop.org>
Subject: [stable PATCH] mmc: core: check for zero length ioctl data
Date: Thu, 16 Feb 2012 15:59:45 -0500
Message-ID: <m2zkciebpa.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40523 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab2BPU7x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Feb 2012 15:59:53 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

From: Johan Rudholm <johan.rudholm@stericsson.com>

If the read or write buffer size associated with the command sent
through the mmc_blk_ioctl is zero, do not prepare data buffer.

This enables a ioctl(2) call to for instance send a MMC_SWITCH to set
a byte in the ext_csd.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
Upstream commit 4d6144de8ba263eb3691a737c547e5b2fdc45287.
Please apply to stable for 3.0, 3.1 and 3.2, I've tested that
it applies cleanly to each.  Fixes a NULL dereference oops via
ioctl.

 drivers/mmc/card/block.c |   82 +++++++++++++++++++++++++---------------------
 1 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 12096cc..4d29b30 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -336,6 +336,9 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
 		goto idata_err;
 	}
 
+	if (!idata->buf_bytes)
+		return idata;
+
 	idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
 	if (!idata->buf) {
 		err = -ENOMEM;
@@ -382,25 +385,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	if (IS_ERR(idata))
 		return PTR_ERR(idata);
 
-	cmd.opcode = idata->ic.opcode;
-	cmd.arg = idata->ic.arg;
-	cmd.flags = idata->ic.flags;
-
-	data.sg = &sg;
-	data.sg_len = 1;
-	data.blksz = idata->ic.blksz;
-	data.blocks = idata->ic.blocks;
-
-	sg_init_one(data.sg, idata->buf, idata->buf_bytes);
-
-	if (idata->ic.write_flag)
-		data.flags = MMC_DATA_WRITE;
-	else
-		data.flags = MMC_DATA_READ;
-
-	mrq.cmd = &cmd;
-	mrq.data = &data;
-
 	md = mmc_blk_get(bdev->bd_disk);
 	if (!md) {
 		err = -EINVAL;
@@ -413,6 +397,48 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		goto cmd_done;
 	}
 
+	cmd.opcode = idata->ic.opcode;
+	cmd.arg = idata->ic.arg;
+	cmd.flags = idata->ic.flags;
+
+	if (idata->buf_bytes) {
+		data.sg = &sg;
+		data.sg_len = 1;
+		data.blksz = idata->ic.blksz;
+		data.blocks = idata->ic.blocks;
+
+		sg_init_one(data.sg, idata->buf, idata->buf_bytes);
+
+		if (idata->ic.write_flag)
+			data.flags = MMC_DATA_WRITE;
+		else
+			data.flags = MMC_DATA_READ;
+
+		/* data.flags must already be set before doing this. */
+		mmc_set_data_timeout(&data, card);
+
+		/* Allow overriding the timeout_ns for empirical tuning. */
+		if (idata->ic.data_timeout_ns)
+			data.timeout_ns = idata->ic.data_timeout_ns;
+
+		if ((cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+			/*
+			 * Pretend this is a data transfer and rely on the
+			 * host driver to compute timeout.  When all host
+			 * drivers support cmd.cmd_timeout for R1B, this
+			 * can be changed to:
+			 *
+			 *     mrq.data = NULL;
+			 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
+			 */
+			data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
+		}
+
+		mrq.data = &data;
+	}
+
+	mrq.cmd = &cmd;
+
 	mmc_claim_host(card->host);
 
 	if (idata->ic.is_acmd) {
@@ -421,24 +447,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 			goto cmd_rel_host;
 	}
 
-	/* data.flags must already be set before doing this. */
-	mmc_set_data_timeout(&data, card);
-	/* Allow overriding the timeout_ns for empirical tuning. */
-	if (idata->ic.data_timeout_ns)
-		data.timeout_ns = idata->ic.data_timeout_ns;
-
-	if ((cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
-		/*
-		 * Pretend this is a data transfer and rely on the host driver
-		 * to compute timeout.  When all host drivers support
-		 * cmd.cmd_timeout for R1B, this can be changed to:
-		 *
-		 *     mrq.data = NULL;
-		 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
-		 */
-		data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
-	}
-
 	mmc_wait_for_req(card->host, &mrq);
 
 	if (cmd.error) {
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
