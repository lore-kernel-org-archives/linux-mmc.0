From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: [PATCH 1/3]mmc: Support-FFU-for-eMMC-v5.0
Date: Thu, 6 Nov 2014 15:42:20 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE64F6AFCE9@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0099.outbound.protection.outlook.com ([157.56.111.99]:27584
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750998AbaKFP5z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Nov 2014 10:57:55 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "'cjb@laptop.org'" <cjb@laptop.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Gwendal Grignou <gwendal@google.com>

Add eMMC5.0 ffu ext_csd fields

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index 1eda8dd..3b86ed3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -603,6 +603,15 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.data_sector_size = 512;
 	}
 
+	/* eMMC v5 or later */
+	if (card->ext_csd.rev >= 7) {
+		card->ext_csd.ffu_capable =
+			((ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) == 0x1) &&
+			((ext_csd[EXT_CSD_FW_CONFIG] & 0x1) == 0x0);
+		card->ext_csd.ffu_mode_op = ext_csd[EXT_CSD_FFU_FEATURES];
+	} else {
+		card->ext_csd.ffu_capable = false;
+	}
 out:
 	return err;
 }
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index d424b9d..dd01efe 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -81,6 +81,8 @@ struct mmc_ext_csd {
 	bool			hpi_en;			/* HPI enablebit */
 	bool			hpi;			/* HPI support bit */
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
+	bool			ffu_capable;		/* FFU support */
+	bool			ffu_mode_op;		/* FFU mode operation */
 	bool			bkops;		/* background support bit */
 	bool			bkops_en;	/* background enable bit */
 	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index 64ec963..787787b 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -272,6 +272,9 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_FFU_STATUS		26	/* R */
+#define EXT_CSD_MODE_OPERATION_CODES	29	/* W */
+#define EXT_CSD_MODE_CONFIG		30	/* R/W */
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
@@ -290,6 +293,7 @@ struct _mmc_csd {
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_RPMB_MULT		168	/* RO */
+#define EXT_CSD_FW_CONFIG		169	/* R/W */
 #define EXT_CSD_BOOT_WP			173	/* R/W */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
@@ -326,6 +330,11 @@ struct _mmc_csd {
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
+#define EXT_CSD_NUM_OF_FW_SEC_PROG	302	/* RO, 4 bytes */
+#define EXT_CSD_FFU_ARG			487	/* RO, 4 bytes */
+#define EXT_CSD_OPERATION_CODE_TIMEOUT	491	/* RO */
+#define EXT_CSD_FFU_FEATURES		492	/* RO */
+#define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
 #define EXT_CSD_MAX_PACKED_WRITES	500	/* RO */
