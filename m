From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] mmc: core: add core-level function for sending tuning commands
Date: Fri, 21 Nov 2014 22:46:41 +0800
Message-ID: <1416581201-9851-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43068 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbaKUOrL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Nov 2014 09:47:11 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so5016019pab.33
        for <linux-mmc@vger.kernel.org>; Fri, 21 Nov 2014 06:47:11 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, chris@printf.net, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Minda Chen <Minda.Chen@csr.com>

According to the SD card spec, Add a manual tuning command function
for SDR104/HS200 by sending command 19 or command 21 to read data
and compare with the tuning block pattern.

this patch will help to decrease some platform private codes in
SDHCI platform_execute_tuning() callbacks.

Signed-off-by: Minda Chen <Minda.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/core/mmc_ops.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h   |  1 +
 2 files changed, 66 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 7911e05..ecc7789 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -543,6 +543,71 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
+int mmc_send_tuning(struct mmc_card *card, u32 opcode)
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
+
+	if (opcode == MMC_SEND_TUNING_BLOCK_HS200) {
+		if (ios->bus_width == MMC_BUS_WIDTH_8) {
+			tuning_block_pattern = tuning_blk_pattern_8bit;
+			size = sizeof(tuning_blk_pattern_8bit);
+		} else if (ios->bus_width == MMC_BUS_WIDTH_4) {
+			tuning_block_pattern = tuning_blk_pattern_4bit;
+			size = sizeof(tuning_blk_pattern_4bit);
+		} else
+			return -EINVAL;
+	} else if (opcode == MMC_SEND_TUNING_BLOCK) {
+		tuning_block_pattern = tuning_blk_pattern_4bit;
+		size = sizeof(tuning_blk_pattern_4bit);
+	} else
+		return -EINVAL;
+
+	data_buf = kmalloc(size, GFP_KERNEL);
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
+	mmc_set_data_timeout(&data, card);
+	sg_init_one(&sg, data_buf, size);
+	memset(data_buf, 0, size);
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
index f206e29..82a0119 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -154,6 +154,7 @@ extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
 			bool, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
+extern int mmc_send_tuning(struct mmc_card *, u32);
 extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 
 #define MMC_ERASE_ARG		0x00000000
-- 
2.1.1

