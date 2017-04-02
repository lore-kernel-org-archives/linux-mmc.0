From: Tomas Winkler <tomas.winkler@intel.com>
Subject: [mmc] mmc: core: add proper be32 annotation
Date: Sun,  2 Apr 2017 23:56:03 +0300
Message-ID: <20170402205603.23790-1-tomas.winkler@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10212 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751738AbdDBU4q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 2 Apr 2017 16:56:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>

Annotate big endian values correctly and make sparse happy.
In mmc_app_send_scr remove scr function parameter as it was
updating card->raw_scr anyway.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/mmc/core/mmc_ops.c |  8 ++++----
 drivers/mmc/core/sd.c      |  4 ++--
 drivers/mmc/core/sd_ops.c  | 19 +++++++++----------
 drivers/mmc/core/sd_ops.h  |  2 +-
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index fe80f26d6971..d94a722fd340 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -305,7 +305,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 int mmc_send_csd(struct mmc_card *card, u32 *csd)
 {
 	int ret, i;
-	u32 *csd_tmp;
+	__be32 *csd_tmp;
 
 	if (!mmc_host_is_spi(card->host))
 		return mmc_send_cxd_native(card->host, card->rca << 16,
@@ -319,7 +319,7 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd)
 	if (ret)
 		goto err;
 
-	for (i = 0;i < 4;i++)
+	for (i = 0; i < 4; i++)
 		csd[i] = be32_to_cpu(csd_tmp[i]);
 
 err:
@@ -330,7 +330,7 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd)
 int mmc_send_cid(struct mmc_host *host, u32 *cid)
 {
 	int ret, i;
-	u32 *cid_tmp;
+	__be32 *cid_tmp;
 
 	if (!mmc_host_is_spi(host)) {
 		if (!host->card)
@@ -347,7 +347,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid)
 	if (ret)
 		goto err;
 
-	for (i = 0;i < 4;i++)
+	for (i = 0; i < 4; i++)
 		cid[i] = be32_to_cpu(cid_tmp[i]);
 
 err:
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 89531b48ae84..d109634fbfce 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -225,7 +225,7 @@ static int mmc_decode_scr(struct mmc_card *card)
 static int mmc_read_ssr(struct mmc_card *card)
 {
 	unsigned int au, es, et, eo;
-	u32 *raw_ssr;
+	__be32 *raw_ssr;
 	int i;
 
 	if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
@@ -853,7 +853,7 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 		/*
 		 * Fetch SCR from card.
 		 */
-		err = mmc_app_send_scr(card, card->raw_scr);
+		err = mmc_app_send_scr(card);
 		if (err)
 			return err;
 
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 9d5824a37586..47056d8d1bac 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -232,14 +232,14 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)
 	return 0;
 }
 
-int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
+int mmc_app_send_scr(struct mmc_card *card)
 {
 	int err;
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
 	struct mmc_data data = {};
 	struct scatterlist sg;
-	void *data_buf;
+	__be32 *scr;
 
 	/* NOTE: caller guarantees scr is heap-allocated */
 
@@ -250,8 +250,8 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	/* dma onto stack is unsafe/nonportable, but callers to this
 	 * routine normally provide temporary on-stack buffers ...
 	 */
-	data_buf = kmalloc(sizeof(card->raw_scr), GFP_KERNEL);
-	if (data_buf == NULL)
+	scr = kmalloc(sizeof(card->raw_scr), GFP_KERNEL);
+	if (!scr)
 		return -ENOMEM;
 
 	mrq.cmd = &cmd;
@@ -267,23 +267,22 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	data.sg = &sg;
 	data.sg_len = 1;
 
-	sg_init_one(&sg, data_buf, 8);
+	sg_init_one(&sg, scr, 8);
 
 	mmc_set_data_timeout(&data, card);
 
 	mmc_wait_for_req(card->host, &mrq);
 
-	memcpy(scr, data_buf, sizeof(card->raw_scr));
-	kfree(data_buf);
+	card->raw_scr[0] = be32_to_cpu(scr[0]);
+	card->raw_scr[1] = be32_to_cpu(scr[1]);
+
+	kfree(scr);
 
 	if (cmd.error)
 		return cmd.error;
 	if (data.error)
 		return data.error;
 
-	scr[0] = be32_to_cpu(scr[0]);
-	scr[1] = be32_to_cpu(scr[1]);
-
 	return 0;
 }
 
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 784f8e6b6baa..0e6c3d51e66d 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -22,7 +22,7 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width);
 int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
 int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
-int mmc_app_send_scr(struct mmc_card *card, u32 *scr);
+int mmc_app_send_scr(struct mmc_card *card);
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
-- 
2.9.3

