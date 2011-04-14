From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 3/3] mmc: initialize struct mmc_request at declaration time
Date: Wed, 13 Apr 2011 23:57:43 -0400
Message-ID: <1302753463-31005-3-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:50589 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab1DNDxH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 23:53:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Converts from:
	struct mmc_request mrq;
	memset(&mrq, 0, sizeof(struct mmc_request));

to:
	struct mmc_command mrq = {0};

because it's shorter, as performant, and easier to work out whether
initialization has happened.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/card/block.c    |    6 ++----
 drivers/mmc/card/mmc_test.c |   12 +++---------
 drivers/mmc/core/core.c     |    4 +---
 drivers/mmc/core/mmc_ops.c  |    8 ++------
 drivers/mmc/core/sd_ops.c   |   14 ++++----------
 drivers/mmc/core/sdio_ops.c |    4 +---
 6 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index fb387c8..fe551c0 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -259,7 +259,7 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	u32 result;
 	__be32 *blocks;
 
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	unsigned int timeout_us;
@@ -300,8 +300,6 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	data.sg = &sg;
 	data.sg_len = 1;
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
@@ -482,7 +480,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
-	struct mmc_blk_request brq;
+	struct mmc_blk_request brq = {0};
 	int ret = 1, disable_multi = 0;
 
 	/*
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index d2eb5b1..a65ea90 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -246,15 +246,13 @@ static int mmc_test_buffer_transfer(struct mmc_test_card *test,
 {
 	int ret;
 
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_command stop = {0};
 	struct mmc_data data = {0};
 
 	struct scatterlist sg;
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 	mrq.stop = &stop;
@@ -728,13 +726,11 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
 	struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
 	unsigned blocks, unsigned blksz, int write)
 {
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_command stop = {0};
 	struct mmc_data data = {0};
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 	mrq.stop = &stop;
@@ -755,15 +751,13 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
 static int mmc_test_broken_transfer(struct mmc_test_card *test,
 	unsigned blocks, unsigned blksz, int write)
 {
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_command stop = {0};
 	struct mmc_data data = {0};
 
 	struct scatterlist sg;
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 	mrq.stop = &stop;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f273ffd..1dbc185 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -236,12 +236,10 @@ EXPORT_SYMBOL(mmc_wait_for_req);
  */
 int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries)
 {
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 
 	WARN_ON(!host->claimed);
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	memset(cmd->resp, 0, sizeof(cmd->resp));
 	cmd->retries = retries;
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 6156c79..c20aaa3 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -233,7 +233,7 @@ static int
 mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 		u32 opcode, void *buf, unsigned len)
 {
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -246,8 +246,6 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 	if (data_buf == NULL)
 		return -ENOMEM;
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
@@ -456,7 +454,7 @@ static int
 mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		  u8 len)
 {
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -487,8 +485,6 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 	if (opcode == MMC_BUS_TEST_W)
 		memcpy(data_buf, test_buf, len);
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 	cmd.opcode = opcode;
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 8023f58..a206aea 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -66,7 +66,7 @@ static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 	struct mmc_command *cmd, int retries)
 {
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 
 	int i, err;
 
@@ -243,7 +243,7 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)
 int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 {
 	int err;
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -266,8 +266,6 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	if (data_buf == NULL)
 		return -ENOMEM;
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
@@ -304,7 +302,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp)
 {
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -317,8 +315,6 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	mode = !!mode;
 	value &= 0xF;
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
@@ -351,7 +347,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 {
 	int err;
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -366,8 +362,6 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 	if (err)
 		return err;
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index 147dfc1..f087d87 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -121,7 +121,7 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz)
 {
-	struct mmc_request mrq;
+	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -136,8 +136,6 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	if (addr & ~0x1FFFF)
 		return -EINVAL;
 
-	memset(&mrq, 0, sizeof(struct mmc_request));
-
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
-- 
1.7.0.1

