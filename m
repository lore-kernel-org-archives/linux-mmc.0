From: Seunguk Shin <seunguk.shin@samsung.com>
Subject: [PATCH] mmc: Support FFU for Samsung eMMC v4.5
Date: Fri, 04 Apr 2014 21:07:32 +0900
Message-ID: <000201cf4ffe$75507b90$5ff172b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31105 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaDDMHc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Apr 2014 08:07:32 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3I008LD9OJC3A0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Apr 2014 21:07:31 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, cpgs@samsung.com

This change adds support to field firmware update (ffu) for Samsung emmc
v4.5.

Samsung eMMC 4.5 FFU protocol is similar with eMMC 5.0 FFU without
MODE_OPERATION.
It uses the different EXT_CSD offset.

This patch depends on patch mmc: Support-FFU-for-eMMC-v5.0 committed by Avi
Shchislowski <avi.shchislowski@sandisk.com>

---
 drivers/mmc/card/Kconfig |   9 +++++
 drivers/mmc/card/block.c |   8 ++++
 drivers/mmc/card/ffu.c   | 100
+++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/ffu.h  |  14 +++++++
 4 files changed, 131 insertions(+)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index d1ea14f..4b0126d 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -76,3 +76,12 @@ config MMC_FFU
 	  This is an option to run firmware update on eMMC 5.0.
 	  Field firmware updates (FFU) enables features enhancement
 	  in the field.
+
+config MMC_FFU_SAMSUNG45
+	bool "FFU SUPPORT for Samsung eMMC 4.5."
+	depends on MMC_FFU
+	default n
+	help
+	  This is an option to run firmware update on Samsung eMMC 4.5.
+	  Field firmware updates (FFU) enables features enhancment
+	  in the field.
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e50cded..ca8ba57 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -536,6 +536,14 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 		goto cmd_rel_host;
 	}
 
+#ifdef CONFIG_MMC_FFU_SAMSUNG45
+	if (cmd.opcode == MMC_FFU_SAMSUNG45_OP) {
+		err = mmc_ffu_execute(card, &cmd, idata->buf,
+				idata->buf_bytes);
+		goto cmd_rel_host;
+	}
+#endif
+
 	err = mmc_blk_part_switch(card, md);
 	if (err)
 		goto cmd_rel_host;
diff --git a/drivers/mmc/card/ffu.c b/drivers/mmc/card/ffu.c
index 092a791..a5eed6c 100644
--- a/drivers/mmc/card/ffu.c
+++ b/drivers/mmc/card/ffu.c
@@ -608,3 +608,103 @@ exit:
 }
 EXPORT_SYMBOL(mmc_ffu_install);
 
+#ifdef CONFIG_MMC_FFU_SAMSUNG45
+
+#define EXT_CSD_MODE_CONFIG_SAMSUNG45	133
+#define EXT_CSD_FFU_STATUS_SAMSUNG45	253
+
+int mmc_ffu_execute(struct mmc_card *card, struct mmc_command *cmd,
+	u8 *data, int buf_bytes)
+{
+	u8 ext_csd[CARD_BLOCK_SIZE];
+	int err;
+	int ret = 0;
+
+	/* Read the EXT_CSD */
+	err = mmc_send_ext_csd(card, ext_csd);
+	if (err) {
+		u32 status;
+		pr_err("FFU: %s: error %d sending ext_csd\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/*
+	 * Check Manufacturer ID and revision,
+	 * This is only for Samsung eMMC 4.5
+	 */
+	if (card->cid.manfid != CID_MANFID_SAMSUNG ||
+	    card->ext_csd.rev != 6) {
+		err = -EINVAL;
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/* Check if FFU is supported by card */
+	if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE])) {
+		err = -EINVAL;
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	if (FFU_ENABLED(ext_csd[EXT_CSD_FW_CONFIG])) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_FW_CONFIG, MMC_FFU_ENABLE,
+			card->ext_csd.generic_cmd6_time);
+		if (err) {
+			pr_err("%s: switch to FFU failed with error %d\n",
+				mmc_hostname(card->host), err);
+			return err;
+		}
+	}
+
+	/* set device to FFU mode */
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+		EXT_CSD_MODE_CONFIG_SAMSUNG45, MMC_FFU_MODE_SET,
+		card->ext_csd.generic_cmd6_time);
+	if (err) {
+		pr_err("FFU: %s: error %d FFU is not supported\n",
+			mmc_hostname(card->host), err);
+		goto exit;
+	}
+	cmd->arg = 0xc7810000;
+
+	err = mmc_ffu_write(card, data, cmd->arg, buf_bytes);
+
+	/* host switch back to work in normal MMC Read/Write commands */
+	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+		EXT_CSD_MODE_CONFIG_SAMSUNG45, MMC_FFU_MODE_NORMAL,
+		card->ext_csd.generic_cmd6_time);
+	if (ret)
+		err = ret;
+
+	/* read ext_csd */
+	err = mmc_send_ext_csd(card, ext_csd);
+	if (err) {
+		pr_err("FFU: %s: error %d sending ext_csd\n",
+		mmc_hostname(card->host), err);
+		goto exit;
+	}
+
+	/* return status */
+	err = ext_csd[EXT_CSD_FFU_STATUS_SAMSUNG45];
+	if (!err) {
+		pr_err("FFU: %s: error %d FFU execute:\n",
+			mmc_hostname(card->host), err);
+		err = -EINVAL;
+		goto exit;
+	}
+	err = mmc_ffu_restart(card);
+	if (err) {
+		pr_err("FFU: %s: error %d FFU execute:\n",
+			mmc_hostname(card->host), err);
+	}
+exit:
+	return err;
+}
+EXPORT_SYMBOL(mmc_ffu_execute);
+
+#endif
+
diff --git a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h
index 009e98b..abf56e6 100644
--- a/include/linux/mmc/ffu.h
+++ b/include/linux/mmc/ffu.h
@@ -27,6 +27,9 @@
  */
 #define MMC_FFU_DOWNLOAD_OP 302
 #define MMC_FFU_INSTALL_OP 303
+#ifdef CONFIG_MMC_FFU_SAMSUNG45
+#define MMC_FFU_SAMSUNG45_OP 304
+#endif
 
 #define MMC_FFU_MODE_SET 0x1
 #define MMC_FFU_MODE_NORMAL 0x0
@@ -47,6 +50,10 @@
 int mmc_ffu_download(struct mmc_card *card, struct mmc_command *cmd,
 	u8 *data, int buf_bytes);
 int mmc_ffu_install(struct mmc_card *card);
+#ifdef CONFIG_MMC_FFU_SAMSUNG45
+int mmc_ffu_execute(struct mmc_card *card, struct mmc_command *cmd,
+	u8 *data, int buf_bytes);
+#endif
 #else
 static inline int mmc_ffu_download(struct mmc_card *card,
 	struct mmc_command *cmd, u8 *data, int buf_bytes)
@@ -57,6 +64,13 @@ static inline int mmc_ffu_install(struct mmc_card *card)
 {
 	return -ENOSYS;
 }
+#ifdef CONFIG_MMC_FFU_SAMSUNG45
+static inline int mmc_ffu_execute(struct mmc_card *card,
+	struct mmc_command *cmd, u8 *data, int buf_bytes)
+{
+	return -ENOSYS;
+}
+#endif
 
 #endif
 #endif /* FFU_H_ */
-- 
1.8.3.2

