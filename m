From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] mmc: core: add core-level function for sending tuning commands
Date: Wed, 26 Nov 2014 13:05:33 +0800
Message-ID: <1416978333-3086-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:47492 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaKZFH2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Nov 2014 00:07:28 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so2025218pdb.36
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2014 21:07:27 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, chris@printf.net, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Minda Chen <Minda.Chen@csr.com>

According to the SD card spec, Add a manual tuning command function
for SDR104/HS200.
Sending command 19 or command 21 to read data and compare with the
tunning block pattern.

This patch will help to decrease some platform private codes in SDHCI
platform_execute_tuning() callbacks.

Signed-off-by: Minda Chen <Minda.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/core/mmc_ops.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h   |  1 +
 2 files changed, 71 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 7911e05..a897894 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -543,6 +543,76 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
+int mmc_send_tuning(struct mmc_card *card)
+{
+	struct mmc_request mrq = {NULL};
+	struct mmc_command cmd = {0};
+	struct mmc_data data = {0};
+	struct scatterlist sg;
+	struct mmc_host *mmc = card->host;
+	struct mmc_ios *ios = &mmc->ios;
+	const u8 *tuning_block_pattern;
+	int size, err = 0;
+	u8 *data_buf;
+	u32 opcode;
+
+	if (ios->bus_width == MMC_BUS_WIDTH_8) {
+		tuning_block_pattern = tuning_blk_pattern_8bit;
+		size = sizeof(tuning_blk_pattern_8bit);
+		opcode = MMC_SEND_TUNING_BLOCK_HS200;
+	} else if (ios->bus_width == MMC_BUS_WIDTH_4) {
+		tuning_block_pattern = tuning_blk_pattern_4bit;
+		size = sizeof(tuning_blk_pattern_4bit);
+		opcode = MMC_SEND_TUNING_BLOCK;
+	} else
+		return -EINVAL;
+
+	data_buf = kzalloc(size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	cmd.opcode = opcode;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	data.blksz = size;
+	data.blocks = 1;
+	data.flags = MMC_DATA_READ;
+
+	/*
+	 * According to the tuning specs, Tuning process
+	 * is normally shorter 40 executions of CMD19,
+	 * and timeout value should be shorter than 150 ms
+	 */
+	data.timeout_ns = 150 * NSEC_PER_MSEC;
+
+	data.sg = &sg;
+	data.sg_len = 1;
+	sg_init_one(&sg, data_buf, size);
+
+	mmc_wait_for_req(mmc, &mrq);
+
+	if (cmd.error) {
+		err = cmd.error;
+		goto out;
+	}
+
+	if (data.error) {
+		err = data.error;
+		goto out;
+	}
+
+	if (memcmp(data_buf, tuning_block_pattern, size))
+		err = -EIO;
+
+out:
+	kfree(data_buf);
+	return err;
+}
+EXPORT_SYMBOL_GPL(mmc_send_tuning);
+
 static int
 mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		  u8 len)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f206e29..b5c2763 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -154,6 +154,7 @@ extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
 			bool, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
+extern int mmc_send_tuning(struct mmc_card *);
 extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 
 #define MMC_ERASE_ARG		0x00000000
-- 
2.1.3

