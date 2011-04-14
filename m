From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 2/3] mmc: initialize struct mmc_data at declaration time
Date: Wed, 13 Apr 2011 23:57:42 -0400
Message-ID: <1302753463-31005-2-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:50586 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab1DNDxH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 23:53:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Converts from:
	struct mmc_data data;
	memset(&data, 0, sizeof(struct mmc_data));

to:
	struct mmc_data data = {0};

because it's shorter, as performant, and easier to work out whether
initialization has happened.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/card/block.c    |    4 +---
 drivers/mmc/card/mmc_test.c |    9 +++------
 drivers/mmc/core/mmc_ops.c  |    6 ++----
 drivers/mmc/core/sd_ops.c   |    9 +++------
 drivers/mmc/core/sdio_ops.c |    3 +--
 5 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 93a7efc..fb387c8 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -261,7 +261,7 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 	unsigned int timeout_us;
 
 	struct scatterlist sg;
@@ -282,8 +282,6 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	memset(&data, 0, sizeof(struct mmc_data));
-
 	data.timeout_ns = card->csd.tacc_ns * 100;
 	data.timeout_clks = card->csd.tacc_clks * 100;
 
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index cc09be8..d2eb5b1 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -249,12 +249,11 @@ static int mmc_test_buffer_transfer(struct mmc_test_card *test,
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
 	struct mmc_command stop = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 
 	struct scatterlist sg;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
@@ -732,10 +731,9 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
 	struct mmc_command stop = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
@@ -760,12 +758,11 @@ static int mmc_test_broken_transfer(struct mmc_test_card *test,
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
 	struct mmc_command stop = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 
 	struct scatterlist sg;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3631ed6..6156c79 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -235,7 +235,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 {
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 	struct scatterlist sg;
 	void *data_buf;
 
@@ -247,7 +247,6 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 		return -ENOMEM;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
@@ -459,7 +458,7 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 {
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 	struct scatterlist sg;
 	u8 *data_buf;
 	u8 *test_buf;
@@ -489,7 +488,6 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		memcpy(data_buf, test_buf, len);
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index dfe9a9c..8023f58 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -245,7 +245,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	int err;
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 	struct scatterlist sg;
 	void *data_buf;
 
@@ -267,7 +267,6 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 		return -ENOMEM;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
@@ -307,7 +306,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 {
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 	struct scatterlist sg;
 
 	BUG_ON(!card);
@@ -319,7 +318,6 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	value &= 0xF;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
@@ -355,7 +353,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 	int err;
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 	struct scatterlist sg;
 
 	BUG_ON(!card);
@@ -369,7 +367,6 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 		return err;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index f77b1bc..147dfc1 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -123,7 +123,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 {
 	struct mmc_request mrq;
 	struct mmc_command cmd = {0};
-	struct mmc_data data;
+	struct mmc_data data = {0};
 	struct scatterlist sg;
 
 	BUG_ON(!card);
@@ -137,7 +137,6 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 		return -EINVAL;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
-- 
1.7.0.1

