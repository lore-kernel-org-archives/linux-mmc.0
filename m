From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v9 1/2] mmc: add packed command feature of eMMC4.5
Date: Wed, 06 Feb 2013 17:01:43 +0900
Message-ID: <003101ce0440$33a89f70$9af9de50$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22818 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab3BFIBp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 03:01:45 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHS00EHNGXE63T0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Feb 2013 17:01:43 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MHS002SEGYVGD00@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Feb 2013 17:01:43 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>, 'Arnd Bergmann' <arnd.bergmann@linaro.org>

This patch adds packed command feature of eMMC4.5.
The maximum number for packing read(or write) is offered
and exception event relevant to packed command which is
used for error handling is enabled. If host wants to use
this feature, MMC_CAP2_PACKED_CMD should be set.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Reviewed-by: Maya Erez <merez@codeaurora.org>
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
---
 drivers/mmc/core/mmc.c   |   28 ++++++++++++++++++++++++++++
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/host.h |    4 ++++
 include/linux/mmc/mmc.h  |   15 +++++++++++++--
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0d7a979..71c5757 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -538,6 +538,11 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		} else {
 			card->ext_csd.data_tag_unit_size = 0;
 		}
+
+		card->ext_csd.max_packed_writes =
+			ext_csd[EXT_CSD_MAX_PACKED_WRITES];
+		card->ext_csd.max_packed_reads =
+			ext_csd[EXT_CSD_MAX_PACKED_READS];
 	} else {
 		card->ext_csd.data_sector_size = 512;
 	}
@@ -1275,6 +1280,29 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/*
+	 * The mandatory minimum values are defined for packed command.
+	 * read: 5, write: 3
+	 */
+	if (card->ext_csd.max_packed_writes >= 3 &&
+	    card->ext_csd.max_packed_reads >= 5 &&
+	    host->caps2 & MMC_CAP2_PACKED_CMD) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_EXP_EVENTS_CTRL,
+				EXT_CSD_PACKED_EVENT_EN,
+				card->ext_csd.generic_cmd6_time);
+		if (err && err != -EBADMSG)
+			goto free_card;
+		if (err) {
+			pr_warn("%s: Enabling packed event failed\n",
+				mmc_hostname(card->host));
+			card->ext_csd.packed_event_en = 0;
+			err = 0;
+		} else {
+			card->ext_csd.packed_event_en = 1;
+		}
+	}
+
 	if (!oldcard)
 		host->card = card;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7069dce..237f253 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -53,6 +53,9 @@ struct mmc_ext_csd {
 	u8			part_config;
 	u8			cache_ctrl;
 	u8			rst_n_function;
+	u8			max_packed_writes;
+	u8			max_packed_reads;
+	u8			packed_event_en;
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		generic_cmd6_time;	/* Units: 10ms */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 523d570..b8e4ea2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -274,6 +274,10 @@ struct mmc_host {
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
+#define MMC_CAP2_PACKED_RD	(1 << 12)	/* Allow packed read */
+#define MMC_CAP2_PACKED_WR	(1 << 13)	/* Allow packed write */
+#define MMC_CAP2_PACKED_CMD	(MMC_CAP2_PACKED_RD | \
+				 MMC_CAP2_PACKED_WR)
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 94d532e..50bcde3 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -139,7 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
 #define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
 #define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
-#define R1_EXCEPTION_EVENT	(1 << 6)	/* sx, a */
+#define R1_EXCEPTION_EVENT	(1 << 6)	/* sr, a */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
 #define R1_STATE_IDLE	0
@@ -275,7 +275,10 @@ struct _mmc_csd {
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
-#define EXT_CSD_EXP_EVENTS_STATUS	54	/* RO */
+#define EXT_CSD_PACKED_FAILURE_INDEX	35	/* RO */
+#define EXT_CSD_PACKED_CMD_STATUS	36	/* RO */
+#define EXT_CSD_EXP_EVENTS_STATUS	54	/* RO, 2 bytes */
+#define EXT_CSD_EXP_EVENTS_CTRL		56	/* R/W, 2 bytes */
 #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
@@ -324,6 +327,8 @@ struct _mmc_csd {
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
+#define EXT_CSD_MAX_PACKED_WRITES	500	/* RO */
+#define EXT_CSD_MAX_PACKED_READS	501	/* RO */
 #define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
 #define EXT_CSD_HPI_FEATURES		503	/* RO */
 
@@ -385,6 +390,9 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_4BIT_MASK	0x0F	/* 8 bit PWR CLS */
 #define EXT_CSD_PWR_CL_8BIT_SHIFT	4
 #define EXT_CSD_PWR_CL_4BIT_SHIFT	0
+
+#define EXT_CSD_PACKED_EVENT_EN	BIT(3)
+
 /*
  * EXCEPTION_EVENT_STATUS field
  */
@@ -393,6 +401,9 @@ struct _mmc_csd {
 #define EXT_CSD_SYSPOOL_EXHAUSTED	BIT(2)
 #define EXT_CSD_PACKED_FAILURE		BIT(3)
 
+#define EXT_CSD_PACKED_GENERIC_ERROR	BIT(0)
+#define EXT_CSD_PACKED_INDEXED_ERROR	BIT(1)
+
 /*
  * BKOPS status level
  */
-- 
1.7.0.4


