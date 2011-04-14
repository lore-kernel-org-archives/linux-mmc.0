From: Chris Ball <cjb@laptop.org>
Subject: [PATCHv2 1/3] mmc: initialize struct mmc_command at declaration time
Date: Thu, 14 Apr 2011 00:07:35 -0400
Message-ID: <m3sjtltr08.fsf@pullcord.laptop.org>
References: <1302753463-31005-1-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47222 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757Ab1DNECv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Apr 2011 00:02:51 -0400
Received: from pullcord.laptop.org ([18.85.46.20])
	by void.printf.net with esmtp (Exim 4.69)
	(envelope-from <cjb@laptop.org>)
	id 1QADla-0003hj-2N
	for linux-mmc@vger.kernel.org; Thu, 14 Apr 2011 05:02:50 +0100
In-Reply-To: <1302753463-31005-1-git-send-email-cjb@laptop.org> (Chris Ball's
	message of "Wed, 13 Apr 2011 23:57:41 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Converts from:
	struct mmc_command cmd;
	memset(&cmd, 0, sizeof(struct mmc_command));

to:
	struct mmc_command cmd = {0};

because it's shorter, as performant, and easier to work out whether
initialization has happened.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
v2: Sorry, there was a rogue hunk in the previous version of this patch,
    inside mmc_test_busy().  Fixed/tested.

 drivers/mmc/card/block.c    |   13 +++-------
 drivers/mmc/card/mmc_test.c |   20 ++++++-----------
 drivers/mmc/core/core.c     |    6 +---
 drivers/mmc/core/mmc_ops.c  |   50 +++++++++++-------------------------------
 drivers/mmc/core/sd_ops.c   |   29 +++++++------------------
 drivers/mmc/core/sdio_ops.c |   11 ++-------
 6 files changed, 37 insertions(+), 92 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9e30cf6..93a7efc 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -260,14 +260,12 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	__be32 *blocks;
 
 	struct mmc_request mrq;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	struct mmc_data data;
 	unsigned int timeout_us;
 
 	struct scatterlist sg;
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_APP_CMD;
 	cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
@@ -328,10 +326,9 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 
 static u32 get_card_status(struct mmc_card *card, struct request *req)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int err;
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	cmd.opcode = MMC_SEND_STATUS;
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg = card->rca << 16;
@@ -460,7 +457,7 @@ static inline int mmc_apply_rel_rw(struct mmc_blk_request *brq,
 				   struct request *req)
 {
 	int err;
-	struct mmc_command set_count;
+	struct mmc_command set_count = {0};
 
 	if (!(card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN)) {
 		/* Legacy mode imposes restrictions on transfers. */
@@ -473,7 +470,6 @@ static inline int mmc_apply_rel_rw(struct mmc_blk_request *brq,
 			brq->data.blocks = 1;
 	}
 
-	memset(&set_count, 0, sizeof(struct mmc_command));
 	set_count.opcode = MMC_SET_BLOCK_COUNT;
 	set_count.arg = brq->data.blocks | (1 << 31);
 	set_count.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -501,10 +497,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		REL_WRITES_SUPPORTED(card);
 
 	do {
-		struct mmc_command cmd;
+		struct mmc_command cmd = {0};
 		u32 readcmd, writecmd, status = 0;
 
-		memset(&cmd, 0, sizeof(struct mmc_command));
 		memset(&brq, 0, sizeof(struct mmc_blk_request));
 		brq.mrq.cmd = &brq.cmd;
 		brq.mrq.data = &brq.data;
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index f5cedec..83c394c 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -212,7 +212,7 @@ static int mmc_test_busy(struct mmc_command *cmd)
 static int mmc_test_wait_busy(struct mmc_test_card *test)
 {
 	int ret, busy;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	busy = 0;
 	do {
@@ -247,16 +247,14 @@ static int mmc_test_buffer_transfer(struct mmc_test_card *test,
 	int ret;
 
 	struct mmc_request mrq;
-	struct mmc_command cmd;
-	struct mmc_command stop;
+	struct mmc_command cmd = {0};
+	struct mmc_command stop = {0};
 	struct mmc_data data;
 
 	struct scatterlist sg;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
-	memset(&stop, 0, sizeof(struct mmc_command));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
@@ -732,14 +730,12 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
 	unsigned blocks, unsigned blksz, int write)
 {
 	struct mmc_request mrq;
-	struct mmc_command cmd;
-	struct mmc_command stop;
+	struct mmc_command cmd = {0};
+	struct mmc_command stop = {0};
 	struct mmc_data data;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
-	memset(&stop, 0, sizeof(struct mmc_command));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
@@ -762,16 +758,14 @@ static int mmc_test_broken_transfer(struct mmc_test_card *test,
 	unsigned blocks, unsigned blksz, int write)
 {
 	struct mmc_request mrq;
-	struct mmc_command cmd;
-	struct mmc_command stop;
+	struct mmc_command cmd = {0};
+	struct mmc_command stop = {0};
 	struct mmc_data data;
 
 	struct scatterlist sg;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
-	memset(&stop, 0, sizeof(struct mmc_command));
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5178d5d..f273ffd 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1286,7 +1286,7 @@ static unsigned int mmc_erase_timeout(struct mmc_card *card,
 static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 			unsigned int to, unsigned int arg)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	unsigned int qty = 0;
 	int err;
 
@@ -1320,7 +1320,6 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 		to <<= 9;
 	}
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	if (mmc_card_sd(card))
 		cmd.opcode = SD_ERASE_WR_BLK_START;
 	else
@@ -1490,12 +1489,11 @@ EXPORT_SYMBOL(mmc_erase_group_aligned);
 
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	if (mmc_card_blockaddr(card) || mmc_card_ddr_mode(card))
 		return 0;
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	cmd.opcode = MMC_SET_BLOCKLEN;
 	cmd.arg = blocklen;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5f18919..3631ed6 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -23,12 +23,10 @@
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	BUG_ON(!host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_SELECT_CARD;
 
 	if (card) {
@@ -60,15 +58,13 @@ int mmc_deselect_cards(struct mmc_host *host)
 
 int mmc_card_sleepawake(struct mmc_host *host, int sleep)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	struct mmc_card *card = host->card;
 	int err;
 
 	if (sleep)
 		mmc_deselect_cards(host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_SLEEP_AWAKE;
 	cmd.arg = card->rca << 16;
 	if (sleep)
@@ -97,7 +93,7 @@ int mmc_card_sleepawake(struct mmc_host *host, int sleep)
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	/*
 	 * Non-SPI hosts need to prevent chipselect going active during
@@ -113,8 +109,6 @@ int mmc_go_idle(struct mmc_host *host)
 		mmc_delay(1);
 	}
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_GO_IDLE_STATE;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
@@ -135,13 +129,11 @@ int mmc_go_idle(struct mmc_host *host)
 
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int i, err = 0;
 
 	BUG_ON(!host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_SEND_OP_COND;
 	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
@@ -178,13 +170,11 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	BUG_ON(!host);
 	BUG_ON(!cid);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_ALL_SEND_CID;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_R2 | MMC_CMD_BCR;
@@ -201,13 +191,11 @@ int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
 int mmc_set_relative_addr(struct mmc_card *card)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	BUG_ON(!card);
 	BUG_ON(!card->host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_SET_RELATIVE_ADDR;
 	cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -223,13 +211,11 @@ static int
 mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	BUG_ON(!host);
 	BUG_ON(!cxd);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = opcode;
 	cmd.arg = arg;
 	cmd.flags = MMC_RSP_R2 | MMC_CMD_AC;
@@ -248,7 +234,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 		u32 opcode, void *buf, unsigned len)
 {
 	struct mmc_request mrq;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	struct mmc_data data;
 	struct scatterlist sg;
 	void *data_buf;
@@ -261,7 +247,6 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 		return -ENOMEM;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
@@ -355,11 +340,9 @@ int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
 
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int err;
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_SPI_READ_OCR;
 	cmd.arg = highcap ? (1 << 30) : 0;
 	cmd.flags = MMC_RSP_SPI_R3;
@@ -372,11 +355,9 @@ int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp)
 
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int err;
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_SPI_CRC_ON_OFF;
 	cmd.flags = MMC_RSP_SPI_R1;
 	cmd.arg = use_crc;
@@ -402,14 +383,12 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	       unsigned int timeout_ms)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	u32 status;
 
 	BUG_ON(!card);
 	BUG_ON(!card->host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_SWITCH;
 	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 		  (index << 16) |
@@ -451,13 +430,11 @@ EXPORT_SYMBOL_GPL(mmc_switch);
 int mmc_send_status(struct mmc_card *card, u32 *status)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	BUG_ON(!card);
 	BUG_ON(!card->host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_SEND_STATUS;
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg = card->rca << 16;
@@ -481,7 +458,7 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		  u8 len)
 {
 	struct mmc_request mrq;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	struct mmc_data data;
 	struct scatterlist sg;
 	u8 *data_buf;
@@ -512,7 +489,6 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		memcpy(data_buf, test_buf, len);
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index da50849..dfe9a9c 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -24,13 +24,11 @@
 static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	BUG_ON(!host);
 	BUG_ON(card && (card->host != host));
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = MMC_APP_CMD;
 
 	if (card) {
@@ -121,13 +119,11 @@ EXPORT_SYMBOL(mmc_wait_for_app_cmd);
 int mmc_app_set_bus_width(struct mmc_card *card, int width)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	BUG_ON(!card);
 	BUG_ON(!card->host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = SD_APP_SET_BUS_WIDTH;
 	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
@@ -151,13 +147,11 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
 
 int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int i, err = 0;
 
 	BUG_ON(!host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = SD_APP_OP_COND;
 	if (mmc_host_is_spi(host))
 		cmd.arg = ocr & (1 << 30); /* SPI only defines one bit */
@@ -196,13 +190,11 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 
 int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int err;
 	static const u8 test_pattern = 0xAA;
 	u8 result_pattern;
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	/*
 	 * To support SD 2.0 cards, we must always invoke SD_SEND_IF_COND
 	 * before SD_APP_OP_COND. This command will harmlessly fail for
@@ -230,13 +222,11 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
 int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)
 {
 	int err;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 
 	BUG_ON(!host);
 	BUG_ON(!rca);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = SD_SEND_RELATIVE_ADDR;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_R6 | MMC_CMD_BCR;
@@ -254,7 +244,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 {
 	int err;
 	struct mmc_request mrq;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	struct mmc_data data;
 	struct scatterlist sg;
 	void *data_buf;
@@ -277,7 +267,6 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 		return -ENOMEM;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
@@ -317,7 +306,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp)
 {
 	struct mmc_request mrq;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	struct mmc_data data;
 	struct scatterlist sg;
 
@@ -330,7 +319,6 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	value &= 0xF;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
@@ -366,7 +354,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 {
 	int err;
 	struct mmc_request mrq;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	struct mmc_data data;
 	struct scatterlist sg;
 
@@ -381,7 +369,6 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 		return err;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index dea36d9..f77b1bc 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -21,13 +21,11 @@
 
 int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int i, err = 0;
 
 	BUG_ON(!host);
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = SD_IO_SEND_OP_COND;
 	cmd.arg = ocr;
 	cmd.flags = MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR;
@@ -70,7 +68,7 @@ int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 static int mmc_io_rw_direct_host(struct mmc_host *host, int write, unsigned fn,
 	unsigned addr, u8 in, u8 *out)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int err;
 
 	BUG_ON(!host);
@@ -80,8 +78,6 @@ static int mmc_io_rw_direct_host(struct mmc_host *host, int write, unsigned fn,
 	if (addr & ~0x1FFFF)
 		return -EINVAL;
 
-	memset(&cmd, 0, sizeof(struct mmc_command));
-
 	cmd.opcode = SD_IO_RW_DIRECT;
 	cmd.arg = write ? 0x80000000 : 0x00000000;
 	cmd.arg |= fn << 28;
@@ -126,7 +122,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz)
 {
 	struct mmc_request mrq;
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	struct mmc_data data;
 	struct scatterlist sg;
 
@@ -141,7 +137,6 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 		return -EINVAL;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
-	memset(&cmd, 0, sizeof(struct mmc_command));
 	memset(&data, 0, sizeof(struct mmc_data));
 
 	mrq.cmd = &cmd;
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
