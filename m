From: Avi Shchislowski <avi.shchislowski@sandisk.com>
Subject: [PATCH 1/3] mmc: Add eMMC5.0 ffu ext_csd field
Date: Thu, 13 Nov 2014 18:29:35 +0200
Message-ID: <1415896175-27379-1-git-send-email-avi.shchislowski@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0062.outbound.protection.outlook.com ([65.55.169.62]:41136
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933037AbaKMQar (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Nov 2014 11:30:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, chris@printf.net, Alex.Lemberg@sandisk.com, Avi Shchislowski <avi.shchislowski@sandisk.com>, Alex Lemberg <alex.lemberg@sandisk.com>


Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
---
 drivers/mmc/core/mmc.c   |    3 +++
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/mmc.h  |    8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 02ad792..000f7e6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -571,6 +571,9 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.ffu_capable =
 			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
 			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
+		card->ext_csd.ffu_mode_op = ext_csd[EXT_CSD_FFU_FEATURES];
+	} else {
+		card->ext_csd.ffu_capable = false;
 	}
 out:
 	return err;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4d69c00..cb97e51 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -89,6 +89,7 @@ struct mmc_ext_csd {
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
 	bool			ffu_capable;	/* Firmware upgrade support */
+	bool			ffu_mode_op;	/* FFU mode operation */
 #define MMC_FIRMWARE_LEN 8
 	u8			fwrev[MMC_FIRMWARE_LEN];  /* FW version */
 	u8			raw_exception_status;	/* 54 */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 49ad7a9..cab1796 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -277,6 +277,9 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_FFU_STATUS		26	/* R */
+#define EXT_CSD_MODE_OPERATION_CODES	29	/* W */
+#define EXT_CSD_MODE_CONFIG		30	/* R/W */
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
@@ -334,6 +337,11 @@ struct _mmc_csd {
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO, 8 bytes */
+#define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
+#define EXT_CSD_NUM_OF_FW_SEC_PROG	302	/* RO, 4 bytes */
+#define EXT_CSD_FFU_ARG			487	/* RO, 4 bytes */
+#define EXT_CSD_OPERATION_CODE_TIMEOUT	491	/* RO */
+#define EXT_CSD_FFU_FEATURES		492	/* RO */
 #define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
-- 
1.7.9.5

