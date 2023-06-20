Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782B8EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFTKrw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjFTKrq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:46 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDAAE41
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:44 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D20AF861C2;
        Tue, 20 Jun 2023 12:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258062;
        bh=5vrv0j8kd9dmcrKuZefmbAp2Kqye/rppl9uxftRPUOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uAfunrtdHVeyi7YwYjPnzeQeOrEtcq8iFCNuCutSZRQLTVaA3qtpFv67KOwT8l4LO
         Yi+Dt23wBBqAIObm+/z/ROHV1Oj/ca6VV+JnS9hQe6opFIKuRKX0hm868Elv9BRrJm
         GnRAa7GawrIytBD1L/jn8St6kE+V5KePluKEiYKgqeScirU5oT8olgOJLcGWRjNDVQ
         37ARZkhsWjfyTJ+oseAXTswm+/NQvZokOAqiHiGPpKxn0rQ3n8A1uRIolwp2JRzYNn
         LCV6VBOm3tMMS1RoOuoVLuHoFz8nCqUSg6iGJEzpZYic2nBr/rFFyj2kOwBIbbu4Kp
         o5lhMbO5mQMsw==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>, Bo Liu <liubo03@inspur.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pierre Ossman <pierre@ossman.eu>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 04/11] mmc: mmc: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:15 +0200
Message-Id: <20230620104722.16465-4-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620104722.16465-1-marex@denx.de>
References: <20230620104722.16465-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use the BIT(n) macro instead of (1<<n), no functional change.
Regex 's@(1 \?<< \?\([0-9A-Z_]\+\))@BIT(\1)' .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Bo Liu <liubo03@inspur.com>
Cc: Deren Wu <deren.wu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mmc@vger.kernel.org
---
 include/linux/mmc/mmc.h | 128 ++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 6f7993803ee78..bbd3678e87aa7 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -131,31 +131,31 @@ static inline bool mmc_op_tuning(u32 opcode)
 	c : clear by read
  */
 
-#define R1_OUT_OF_RANGE		(1 << 31)	/* er, c */
-#define R1_ADDRESS_ERROR	(1 << 30)	/* erx, c */
-#define R1_BLOCK_LEN_ERROR	(1 << 29)	/* er, c */
-#define R1_ERASE_SEQ_ERROR      (1 << 28)	/* er, c */
-#define R1_ERASE_PARAM		(1 << 27)	/* ex, c */
-#define R1_WP_VIOLATION		(1 << 26)	/* erx, c */
-#define R1_CARD_IS_LOCKED	(1 << 25)	/* sx, a */
-#define R1_LOCK_UNLOCK_FAILED	(1 << 24)	/* erx, c */
-#define R1_COM_CRC_ERROR	(1 << 23)	/* er, b */
-#define R1_ILLEGAL_COMMAND	(1 << 22)	/* er, b */
-#define R1_CARD_ECC_FAILED	(1 << 21)	/* ex, c */
-#define R1_CC_ERROR		(1 << 20)	/* erx, c */
-#define R1_ERROR		(1 << 19)	/* erx, c */
-#define R1_UNDERRUN		(1 << 18)	/* ex, c */
-#define R1_OVERRUN		(1 << 17)	/* ex, c */
-#define R1_CID_CSD_OVERWRITE	(1 << 16)	/* erx, c, CID/CSD overwrite */
-#define R1_WP_ERASE_SKIP	(1 << 15)	/* sx, c */
-#define R1_CARD_ECC_DISABLED	(1 << 14)	/* sx, a */
-#define R1_ERASE_RESET		(1 << 13)	/* sr, c */
+#define R1_OUT_OF_RANGE		BIT(31)	/* er, c */
+#define R1_ADDRESS_ERROR	BIT(30)	/* erx, c */
+#define R1_BLOCK_LEN_ERROR	BIT(29)	/* er, c */
+#define R1_ERASE_SEQ_ERROR      BIT(28)	/* er, c */
+#define R1_ERASE_PARAM		BIT(27)	/* ex, c */
+#define R1_WP_VIOLATION		BIT(26)	/* erx, c */
+#define R1_CARD_IS_LOCKED	BIT(25)	/* sx, a */
+#define R1_LOCK_UNLOCK_FAILED	BIT(24)	/* erx, c */
+#define R1_COM_CRC_ERROR	BIT(23)	/* er, b */
+#define R1_ILLEGAL_COMMAND	BIT(22)	/* er, b */
+#define R1_CARD_ECC_FAILED	BIT(21)	/* ex, c */
+#define R1_CC_ERROR		BIT(20)	/* erx, c */
+#define R1_ERROR		BIT(19)	/* erx, c */
+#define R1_UNDERRUN		BIT(18)	/* ex, c */
+#define R1_OVERRUN		BIT(17)	/* ex, c */
+#define R1_CID_CSD_OVERWRITE	BIT(16)	/* erx, c, CID/CSD overwrite */
+#define R1_WP_ERASE_SKIP	BIT(15)	/* sx, c */
+#define R1_CARD_ECC_DISABLED	BIT(14)	/* sx, a */
+#define R1_ERASE_RESET		BIT(13)	/* sr, c */
 #define R1_STATUS(x)            (x & 0xFFF9A000)
 #define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
-#define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
-#define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
-#define R1_EXCEPTION_EVENT	(1 << 6)	/* sr, a */
-#define R1_APP_CMD		(1 << 5)	/* sr, c */
+#define R1_READY_FOR_DATA	BIT(8)	/* sx, a */
+#define R1_SWITCH_ERROR		BIT(7)	/* sx, c */
+#define R1_EXCEPTION_EVENT	BIT(6)	/* sr, a */
+#define R1_APP_CMD		BIT(5)	/* sr, c */
 
 #define R1_STATE_IDLE	0
 #define R1_STATE_READY	1
@@ -181,23 +181,23 @@ static inline bool mmc_ready_for_data(u32 status)
  * MMC/SD in SPI mode reports R1 status always, and R2 for SEND_STATUS
  * R1 is the low order byte; R2 is the next highest byte, when present.
  */
-#define R1_SPI_IDLE		(1 << 0)
-#define R1_SPI_ERASE_RESET	(1 << 1)
-#define R1_SPI_ILLEGAL_COMMAND	(1 << 2)
-#define R1_SPI_COM_CRC		(1 << 3)
-#define R1_SPI_ERASE_SEQ	(1 << 4)
-#define R1_SPI_ADDRESS		(1 << 5)
-#define R1_SPI_PARAMETER	(1 << 6)
+#define R1_SPI_IDLE		BIT(0)
+#define R1_SPI_ERASE_RESET	BIT(1)
+#define R1_SPI_ILLEGAL_COMMAND	BIT(2)
+#define R1_SPI_COM_CRC		BIT(3)
+#define R1_SPI_ERASE_SEQ	BIT(4)
+#define R1_SPI_ADDRESS		BIT(5)
+#define R1_SPI_PARAMETER	BIT(6)
 /* R1 bit 7 is always zero */
-#define R2_SPI_CARD_LOCKED	(1 << 8)
-#define R2_SPI_WP_ERASE_SKIP	(1 << 9)	/* or lock/unlock fail */
+#define R2_SPI_CARD_LOCKED	BIT(8)
+#define R2_SPI_WP_ERASE_SKIP	BIT(9)	/* or lock/unlock fail */
 #define R2_SPI_LOCK_UNLOCK_FAIL	R2_SPI_WP_ERASE_SKIP
-#define R2_SPI_ERROR		(1 << 10)
-#define R2_SPI_CC_ERROR		(1 << 11)
-#define R2_SPI_CARD_ECC_ERROR	(1 << 12)
-#define R2_SPI_WP_VIOLATION	(1 << 13)
-#define R2_SPI_ERASE_PARAM	(1 << 14)
-#define R2_SPI_OUT_OF_RANGE	(1 << 15)	/* or CSD overwrite */
+#define R2_SPI_ERROR		BIT(10)
+#define R2_SPI_CC_ERROR		BIT(11)
+#define R2_SPI_CARD_ECC_ERROR	BIT(12)
+#define R2_SPI_WP_VIOLATION	BIT(13)
+#define R2_SPI_ERASE_PARAM	BIT(14)
+#define R2_SPI_OUT_OF_RANGE	BIT(15)	/* or CSD overwrite */
 #define R2_SPI_CSD_OVERWRITE	R2_SPI_OUT_OF_RANGE
 
 /*
@@ -208,28 +208,28 @@ static inline bool mmc_ready_for_data(u32 status)
 /*
  * Card Command Classes (CCC)
  */
-#define CCC_BASIC		(1<<0)	/* (0) Basic protocol functions */
+#define CCC_BASIC		BIT(0)	/* (0) Basic protocol functions */
 					/* (CMD0,1,2,3,4,7,9,10,12,13,15) */
 					/* (and for SPI, CMD58,59) */
-#define CCC_STREAM_READ		(1<<1)	/* (1) Stream read commands */
+#define CCC_STREAM_READ		BIT(1)	/* (1) Stream read commands */
 					/* (CMD11) */
-#define CCC_BLOCK_READ		(1<<2)	/* (2) Block read commands */
+#define CCC_BLOCK_READ		BIT(2)	/* (2) Block read commands */
 					/* (CMD16,17,18) */
-#define CCC_STREAM_WRITE	(1<<3)	/* (3) Stream write commands */
+#define CCC_STREAM_WRITE	BIT(3)	/* (3) Stream write commands */
 					/* (CMD20) */
-#define CCC_BLOCK_WRITE		(1<<4)	/* (4) Block write commands */
+#define CCC_BLOCK_WRITE		BIT(4)	/* (4) Block write commands */
 					/* (CMD16,24,25,26,27) */
-#define CCC_ERASE		(1<<5)	/* (5) Ability to erase blocks */
+#define CCC_ERASE		BIT(5)	/* (5) Ability to erase blocks */
 					/* (CMD32,33,34,35,36,37,38,39) */
-#define CCC_WRITE_PROT		(1<<6)	/* (6) Able to write protect blocks */
+#define CCC_WRITE_PROT		BIT(6)	/* (6) Able to write protect blocks */
 					/* (CMD28,29,30) */
-#define CCC_LOCK_CARD		(1<<7)	/* (7) Able to lock down card */
+#define CCC_LOCK_CARD		BIT(7)	/* (7) Able to lock down card */
 					/* (CMD16,CMD42) */
-#define CCC_APP_SPEC		(1<<8)	/* (8) Application specific */
+#define CCC_APP_SPEC		BIT(8)	/* (8) Application specific */
 					/* (CMD55,56,57,ACMD*) */
-#define CCC_IO_MODE		(1<<9)	/* (9) I/O mode */
+#define CCC_IO_MODE		BIT(9)	/* (9) I/O mode */
 					/* (CMD5,39,40,52,53) */
-#define CCC_SWITCH		(1<<10)	/* (10) High speed switch */
+#define CCC_SWITCH		BIT(10)	/* (10) High speed switch */
 					/* (CMD6,34,35,36,37,50) */
 					/* (11) Reserved */
 					/* (CMD?) */
@@ -330,8 +330,8 @@ static inline bool mmc_ready_for_data(u32 status)
  * EXT_CSD field definitions
  */
 
-#define EXT_CSD_WR_REL_PARAM_EN		(1<<2)
-#define EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR	(1<<4)
+#define EXT_CSD_WR_REL_PARAM_EN		BIT(2)
+#define EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR	BIT(4)
 
 #define EXT_CSD_BOOT_WP_B_PWR_WP_DIS	(0x40)
 #define EXT_CSD_BOOT_WP_B_PERM_WP_DIS	(0x10)
@@ -346,30 +346,30 @@ static inline bool mmc_ready_for_data(u32 status)
 #define EXT_CSD_PART_SETTING_COMPLETED	(0x1)
 #define EXT_CSD_PART_SUPPORT_PART_EN	(0x1)
 
-#define EXT_CSD_CMD_SET_NORMAL		(1<<0)
-#define EXT_CSD_CMD_SET_SECURE		(1<<1)
-#define EXT_CSD_CMD_SET_CPSECURE	(1<<2)
+#define EXT_CSD_CMD_SET_NORMAL		BIT(0)
+#define EXT_CSD_CMD_SET_SECURE		BIT(1)
+#define EXT_CSD_CMD_SET_CPSECURE	BIT(2)
 
-#define EXT_CSD_CARD_TYPE_HS_26	(1<<0)	/* Card can run at 26MHz */
-#define EXT_CSD_CARD_TYPE_HS_52	(1<<1)	/* Card can run at 52MHz */
+#define EXT_CSD_CARD_TYPE_HS_26	BIT(0)	/* Card can run at 26MHz */
+#define EXT_CSD_CARD_TYPE_HS_52	BIT(1)	/* Card can run at 52MHz */
 #define EXT_CSD_CARD_TYPE_HS	(EXT_CSD_CARD_TYPE_HS_26 | \
 				 EXT_CSD_CARD_TYPE_HS_52)
-#define EXT_CSD_CARD_TYPE_DDR_1_8V  (1<<2)   /* Card can run at 52MHz */
+#define EXT_CSD_CARD_TYPE_DDR_1_8V  BIT(2)   /* Card can run at 52MHz */
 					     /* DDR mode @1.8V or 3V I/O */
-#define EXT_CSD_CARD_TYPE_DDR_1_2V  (1<<3)   /* Card can run at 52MHz */
+#define EXT_CSD_CARD_TYPE_DDR_1_2V  BIT(3)   /* Card can run at 52MHz */
 					     /* DDR mode @1.2V I/O */
 #define EXT_CSD_CARD_TYPE_DDR_52       (EXT_CSD_CARD_TYPE_DDR_1_8V  \
 					| EXT_CSD_CARD_TYPE_DDR_1_2V)
-#define EXT_CSD_CARD_TYPE_HS200_1_8V	(1<<4)	/* Card can run at 200MHz */
-#define EXT_CSD_CARD_TYPE_HS200_1_2V	(1<<5)	/* Card can run at 200MHz */
+#define EXT_CSD_CARD_TYPE_HS200_1_8V	BIT(4)	/* Card can run at 200MHz */
+#define EXT_CSD_CARD_TYPE_HS200_1_2V	BIT(5)	/* Card can run at 200MHz */
 						/* SDR mode @1.2V I/O */
 #define EXT_CSD_CARD_TYPE_HS200		(EXT_CSD_CARD_TYPE_HS200_1_8V | \
 					 EXT_CSD_CARD_TYPE_HS200_1_2V)
-#define EXT_CSD_CARD_TYPE_HS400_1_8V	(1<<6)	/* Card can run at 200MHz DDR, 1.8V */
-#define EXT_CSD_CARD_TYPE_HS400_1_2V	(1<<7)	/* Card can run at 200MHz DDR, 1.2V */
+#define EXT_CSD_CARD_TYPE_HS400_1_8V	BIT(6)	/* Card can run at 200MHz DDR, 1.8V */
+#define EXT_CSD_CARD_TYPE_HS400_1_2V	BIT(7)	/* Card can run at 200MHz DDR, 1.2V */
 #define EXT_CSD_CARD_TYPE_HS400		(EXT_CSD_CARD_TYPE_HS400_1_8V | \
 					 EXT_CSD_CARD_TYPE_HS400_1_2V)
-#define EXT_CSD_CARD_TYPE_HS400ES	(1<<8)	/* Card can run at HS400ES */
+#define EXT_CSD_CARD_TYPE_HS400ES	BIT(8)	/* Card can run at HS400ES */
 
 #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
@@ -453,6 +453,6 @@ static inline bool mmc_ready_for_data(u32 status)
 #define MMC_SECURE_ARGS			0x80000000
 #define MMC_TRIM_OR_DISCARD_ARGS	0x00008003
 
-#define mmc_driver_type_mask(n)		(1 << (n))
+#define mmc_driver_type_mask(n)		BIT(n)
 
 #endif /* LINUX_MMC_MMC_H */
-- 
2.39.2

