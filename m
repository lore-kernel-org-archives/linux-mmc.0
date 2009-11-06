From: Don Mullis <don.mullis@gmail.com>
Subject: [PATCH 2.6.31-rc5 3/3] mmc: Add SD_STATUS register dump to debugfs
Date: Thu, 05 Nov 2009 19:03:32 -0800
Message-ID: <4AF39204.2060101@gmail.com>
References: <4AF38EA0.4080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:64532 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZKFDD3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2009 22:03:29 -0500
Received: by pzk26 with SMTP id 26so429911pzk.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2009 19:03:34 -0800 (PST)
In-Reply-To: <4AF38EA0.4080604@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Add a file to debugfs to read back the SD_STATUS register from an SD
card.  SD_STATUS contains performance-related information.

Signed-off-by: don.mullis@gmail.com
---
  drivers/mmc/core/debugfs.c |   56 +++++++++++++++++++++++++++++++++++++++++++++
  drivers/mmc/core/sd_ops.c  |   51 ++++++++++++++++++++++++++++++++++++++++
  drivers/mmc/core/sd_ops.h  |    1
  include/linux/mmc/sd.h     |    1
  4 files changed, 109 insertions(+)

Index: linux-2.6/drivers/mmc/core/sd_ops.c
===================================================================
--- linux-2.6.orig/drivers/mmc/core/sd_ops.c	2009-11-02 15:10:28.000000000 -0800
+++ linux-2.6/drivers/mmc/core/sd_ops.c	2009-11-02 15:19:01.000000000 -0800
@@ -299,6 +299,57 @@ int mmc_app_send_scr(struct mmc_card *ca
  	return 0;
  }

+int mmc_send_sd_status(struct mmc_card *card, u32 *sd_status)
+{
+	int err;
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+	struct scatterlist sg;
+	int i;
+
+	BUG_ON(!card);
+	BUG_ON(!card->host);
+	BUG_ON(!sd_status);
+
+	err = mmc_app_cmd(card->host, card);
+	if (err)
+		return err;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	cmd.opcode = SD_APP_SEND_SD_STATUS;
+	cmd.arg = 0;  /* not used */
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	data.blksz = 16*sizeof(u32);
+	data.blocks = 1;
+	data.flags = MMC_DATA_READ;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	sg_init_one(&sg, sd_status, 16*sizeof(u32));
+
+	mmc_set_data_timeout(&data, card);
+
+	mmc_wait_for_req(card->host, &mrq);
+
+	if (cmd.error)
+		return cmd.error;
+	if (data.error)
+		return data.error;
+
+	for (i = 0; i < 16; i++)
+		sd_status[i] = be32_to_cpu(sd_status[i]);
+
+	return 0;
+}
+
  int mmc_sd_switch(struct mmc_card *card, int mode, int group,
  	u8 value, u8 *resp)
  {
Index: linux-2.6/drivers/mmc/core/sd_ops.h
===================================================================
--- linux-2.6.orig/drivers/mmc/core/sd_ops.h	2009-11-02 15:10:28.000000000 -0800
+++ linux-2.6/drivers/mmc/core/sd_ops.h	2009-11-02 15:19:01.000000000 -0800
@@ -13,6 +13,7 @@
  #define _MMC_SD_OPS_H

  int mmc_app_set_bus_width(struct mmc_card *card, int width);
+int mmc_send_sd_status(struct mmc_card *card, u32 *sd_status);
  int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
  int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
  int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
Index: linux-2.6/include/linux/mmc/sd.h
===================================================================
--- linux-2.6.orig/include/linux/mmc/sd.h	2009-11-02 15:10:28.000000000 -0800
+++ linux-2.6/include/linux/mmc/sd.h	2009-11-02 15:19:01.000000000 -0800
@@ -26,6 +26,7 @@
  #define SD_APP_SEND_NUM_WR_BLKS  22   /* adtc                    R1  */
  #define SD_APP_OP_COND           41   /* bcr  [31:0] OCR         R3  */
  #define SD_APP_SEND_SCR          51   /* adtc                    R1  */
+#define SD_APP_SEND_SD_STATUS    13   /* adtc                    R1  */

  /*
   * SD_SWITCH argument format:
Index: linux-2.6/drivers/mmc/core/debugfs.c
===================================================================
--- linux-2.6.orig/drivers/mmc/core/debugfs.c	2009-11-02 15:10:28.000000000 -0800
+++ linux-2.6/drivers/mmc/core/debugfs.c	2009-11-03 12:29:23.000000000 -0800
@@ -17,6 +17,7 @@

  #include "core.h"
  #include "mmc_ops.h"
+#include "sd_ops.h"

  /* The debugfs functions are optimized away when CONFIG_DEBUG_FS isn't set. */
  static int mmc_ios_show(struct seq_file *s, void *data)
@@ -246,6 +247,56 @@ static struct file_operations mmc_dbg_ex
  	.release	= mmc_ext_csd_release,
  };

+static int mmc_card_sd_status_show(struct seq_file *s, void *data)
+{
+	struct mmc_card	*card = s->private;
+	u32		sd_status[16];
+	int		ret;
+
+	mmc_claim_host(card->host);
+
+	/*
+	 * Fields as defined in the Simplified SD Spec, available from
+	 * http://www.sdcard.org/developers/tech/sdcard/pls/
+	 */
+	ret = mmc_send_sd_status(card, sd_status);
+	if (!ret) {
+		int i;
+		const int WIDTH = 24;
+
+		for (i = 0; i < 16; i++)
+			seq_printf(s, "%3d: %8x\n", 511-i*32, sd_status[i]);
+		seq_printf(s, "\n");
+
+		seq_printf(s, "%-*s %d\n", WIDTH, "SPEED_CLASS:",
+			UNSTUFF_BITS_ARRAY(sd_status, 440, 8)*2);
+		seq_printf(s, "%-*s %01x\n", WIDTH, "PERFORMANCE_MOVE (MB/s):",
+			UNSTUFF_BITS_ARRAY(sd_status, 432, 8));
+		seq_printf(s, "%-*s %01x\n", WIDTH, "AU_SIZE (kB):",
+			(1<<(UNSTUFF_BITS_ARRAY(sd_status, 428, 4)-1))*16);
+		seq_printf(s, "%-*s %d\n", WIDTH, "ERASE_SIZE (AU):",
+			UNSTUFF_BITS_ARRAY(sd_status, 408, 16));
+		seq_printf(s, "%-*s %d\n", WIDTH, "ERASE_TIMEOUT (sec):",
+			UNSTUFF_BITS_ARRAY(sd_status, 402, 6));
+	}
+
+	mmc_release_host(card->host);
+
+	return ret;
+}
+
+static int mmc_card_sd_status_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mmc_card_sd_status_show, inode->i_private);
+}
+
+static const struct file_operations mmc_dbg_card_sd_status_fops = {
+	.open		= mmc_card_sd_status_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
  void mmc_add_card_debugfs(struct mmc_card *card)
  {
  	struct mmc_host	*host = card->host;
@@ -278,6 +329,11 @@ void mmc_add_card_debugfs(struct mmc_car
  					&mmc_dbg_ext_csd_fops))
  			goto err;

+	if (mmc_card_sd(card))
+		if (!debugfs_create_file("sd_status", S_IRUSR, root, card,
+					&mmc_dbg_card_sd_status_fops))
+			goto err;
+
  	return;

  err:





