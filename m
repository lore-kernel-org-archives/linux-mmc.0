Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF56EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjFTKrq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjFTKrp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:45 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82901A8
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:42 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B136D846D9;
        Tue, 20 Jun 2023 12:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258061;
        bh=up06Owk+NDTUAaAvH70nAKZwmnz3/pTSTRxylfq3s98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7BxCKYy18gPBZbNoEzmm0R9WELVbtjRFVmvnAI7fw3BTiml8ap+0L9KYTp8VXIbj
         xwwNpl/tm/aUkilPM2YKLLHnOcJsBzyQyOcuyt/brlfmDh3UuwnYQhRCEJFqFFQxUH
         DsFzL/nfONSk6mNiKPwJWzJ4nI5GMXXPixNGzCYWURY1UP/3TgL6nS/yyg0IMeIR00
         BYhRl+OgnRDBDsV8qzAbgxn6he/f8ZxvDm1Yxu2HQGRaUgsJifp3aMnMZNJa/iAvWM
         Sz4ZYQTAqhdFO0AudbEDFL95fpWPdSFYfk2Piqr+5U5iFN77YbE1KV2JMNSi3SSJuI
         cF2dERxC9bp4g==
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
Subject: [PATCH 02/11] mmc: card: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:13 +0200
Message-Id: <20230620104722.16465-2-marex@denx.de>
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
Tab align the BIT() macro in headers.
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
 drivers/mmc/core/card.h  | 12 +++---
 include/linux/mmc/card.h | 86 ++++++++++++++++++++--------------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 4edf9057fa79d..1040335f64241 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -17,12 +17,12 @@
 #define mmc_dev_to_card(d)	container_of(d, struct mmc_card, dev)
 
 /* Card states */
-#define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
-#define MMC_STATE_READONLY	(1<<1)		/* card is read-only */
-#define MMC_STATE_BLOCKADDR	(1<<2)		/* card uses block-addressing */
-#define MMC_CARD_SDXC		(1<<3)		/* card is SDXC */
-#define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
-#define MMC_STATE_SUSPENDED	(1<<5)		/* card is suspended */
+#define MMC_STATE_PRESENT	BIT(0)		/* present in sysfs */
+#define MMC_STATE_READONLY	BIT(1)		/* card is read-only */
+#define MMC_STATE_BLOCKADDR	BIT(2)		/* card uses block-addressing */
+#define MMC_CARD_SDXC		BIT(3)		/* card is SDXC */
+#define MMC_CARD_REMOVED	BIT(4)		/* card has been removed */
+#define MMC_STATE_SUSPENDED	BIT(5)		/* card is suspended */
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index daa2f40d9ce65..5e8f7ed595098 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -135,13 +135,13 @@ struct sd_scr {
 	unsigned char		sda_spec4;
 	unsigned char		sda_specx;
 	unsigned char		bus_widths;
-#define SD_SCR_BUS_WIDTH_1	(1<<0)
-#define SD_SCR_BUS_WIDTH_4	(1<<2)
+#define SD_SCR_BUS_WIDTH_1	BIT(0)
+#define SD_SCR_BUS_WIDTH_4	BIT(2)
 	unsigned char		cmds;
-#define SD_SCR_CMD20_SUPPORT   (1<<0)
-#define SD_SCR_CMD23_SUPPORT   (1<<1)
-#define SD_SCR_CMD48_SUPPORT   (1<<2)
-#define SD_SCR_CMD58_SUPPORT   (1<<3)
+#define SD_SCR_CMD20_SUPPORT   BIT(0)
+#define SD_SCR_CMD23_SUPPORT   BIT(1)
+#define SD_SCR_CMD48_SUPPORT   BIT(2)
+#define SD_SCR_CMD58_SUPPORT   BIT(3)
 };
 
 struct sd_ssr {
@@ -168,12 +168,12 @@ struct sd_switch_caps {
 #define UHS_SDR104_BUS_SPEED	3
 #define UHS_DDR50_BUS_SPEED	4
 
-#define SD_MODE_HIGH_SPEED	(1 << HIGH_SPEED_BUS_SPEED)
-#define SD_MODE_UHS_SDR12	(1 << UHS_SDR12_BUS_SPEED)
-#define SD_MODE_UHS_SDR25	(1 << UHS_SDR25_BUS_SPEED)
-#define SD_MODE_UHS_SDR50	(1 << UHS_SDR50_BUS_SPEED)
-#define SD_MODE_UHS_SDR104	(1 << UHS_SDR104_BUS_SPEED)
-#define SD_MODE_UHS_DDR50	(1 << UHS_DDR50_BUS_SPEED)
+#define SD_MODE_HIGH_SPEED	BIT(HIGH_SPEED_BUS_SPEED)
+#define SD_MODE_UHS_SDR12	BIT(UHS_SDR12_BUS_SPEED)
+#define SD_MODE_UHS_SDR25	BIT(UHS_SDR25_BUS_SPEED)
+#define SD_MODE_UHS_SDR50	BIT(UHS_SDR50_BUS_SPEED)
+#define SD_MODE_UHS_SDR104	BIT(UHS_SDR104_BUS_SPEED)
+#define SD_MODE_UHS_DDR50	BIT(UHS_DDR50_BUS_SPEED)
 	unsigned int		sd3_drv_type;
 #define SD_DRIVER_TYPE_B	0x01
 #define SD_DRIVER_TYPE_A	0x02
@@ -186,10 +186,10 @@ struct sd_switch_caps {
 #define SD_SET_CURRENT_LIMIT_800	3
 #define SD_SET_CURRENT_NO_CHANGE	(-1)
 
-#define SD_MAX_CURRENT_200	(1 << SD_SET_CURRENT_LIMIT_200)
-#define SD_MAX_CURRENT_400	(1 << SD_SET_CURRENT_LIMIT_400)
-#define SD_MAX_CURRENT_600	(1 << SD_SET_CURRENT_LIMIT_600)
-#define SD_MAX_CURRENT_800	(1 << SD_SET_CURRENT_LIMIT_800)
+#define SD_MAX_CURRENT_200	BIT(SD_SET_CURRENT_LIMIT_200)
+#define SD_MAX_CURRENT_400	BIT(SD_SET_CURRENT_LIMIT_400)
+#define SD_MAX_CURRENT_600	BIT(SD_SET_CURRENT_LIMIT_600)
+#define SD_MAX_CURRENT_800	BIT(SD_SET_CURRENT_LIMIT_800)
 };
 
 struct sd_ext_reg {
@@ -200,15 +200,15 @@ struct sd_ext_reg {
 	u8			feature_enabled;
 	u8			feature_support;
 /* Power Management Function. */
-#define SD_EXT_POWER_OFF_NOTIFY	(1<<0)
-#define SD_EXT_POWER_SUSTENANCE	(1<<1)
-#define SD_EXT_POWER_DOWN_MODE	(1<<2)
+#define SD_EXT_POWER_OFF_NOTIFY	BIT(0)
+#define SD_EXT_POWER_SUSTENANCE	BIT(1)
+#define SD_EXT_POWER_DOWN_MODE	BIT(2)
 /* Performance Enhancement Function. */
-#define SD_EXT_PERF_FX_EVENT	(1<<0)
-#define SD_EXT_PERF_CARD_MAINT	(1<<1)
-#define SD_EXT_PERF_HOST_MAINT	(1<<2)
-#define SD_EXT_PERF_CACHE	(1<<3)
-#define SD_EXT_PERF_CMD_QUEUE	(1<<4)
+#define SD_EXT_PERF_FX_EVENT	BIT(0)
+#define SD_EXT_PERF_CARD_MAINT	BIT(1)
+#define SD_EXT_PERF_HOST_MAINT	BIT(2)
+#define SD_EXT_PERF_CACHE	BIT(3)
+#define SD_EXT_PERF_CMD_QUEUE	BIT(4)
 };
 
 struct sdio_cccr {
@@ -255,10 +255,10 @@ struct mmc_part {
 	char	name[MAX_MMC_PART_NAME_LEN];
 	bool	force_ro;	/* to make boot parts RO by default */
 	unsigned int	area_type;
-#define MMC_BLK_DATA_AREA_MAIN	(1<<0)
-#define MMC_BLK_DATA_AREA_BOOT	(1<<1)
-#define MMC_BLK_DATA_AREA_GP	(1<<2)
-#define MMC_BLK_DATA_AREA_RPMB	(1<<3)
+#define MMC_BLK_DATA_AREA_MAIN	BIT(0)
+#define MMC_BLK_DATA_AREA_BOOT	BIT(1)
+#define MMC_BLK_DATA_AREA_GP	BIT(2)
+#define MMC_BLK_DATA_AREA_RPMB	BIT(3)
 };
 
 /*
@@ -277,24 +277,24 @@ struct mmc_card {
 	unsigned int		state;		/* (our) card state */
 	unsigned int		quirks; 	/* card quirks */
 	unsigned int		quirk_max_rate;	/* max rate set by quirks */
-#define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
-#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
+#define MMC_QUIRK_LENIENT_FN0		BIT(0)	/* allow SDIO FN0 writes outside of the VS CCCR range */
+#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE	BIT(1)	/* use func->cur_blksize */
 						/* for byte mode */
-#define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
+#define MMC_QUIRK_NONSTD_SDIO		BIT(2)	/* non-standard SDIO card attached */
 						/* (missing CIA registers) */
-#define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
-#define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
-#define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
-#define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
-#define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
+#define MMC_QUIRK_NONSTD_FUNC_IF	BIT(4)	/* SDIO card has nonstd function interfaces */
+#define MMC_QUIRK_DISABLE_CD		BIT(5)	/* disconnect CD/DAT[3] resistor */
+#define MMC_QUIRK_INAND_CMD38		BIT(6)	/* iNAND devices have broken CMD38 */
+#define MMC_QUIRK_BLK_NO_CMD23		BIT(7)	/* Avoid CMD23 for regular multiblock */
+#define MMC_QUIRK_BROKEN_BYTE_MODE_512	BIT(8)	/* Avoid sending 512 bytes in */
 						/* byte mode */
-#define MMC_QUIRK_LONG_READ_TIME (1<<9)		/* Data read time > CSD says */
-#define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)	/* Skip secure for erase/trim */
-#define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
-#define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
-#define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
-#define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
-#define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
+#define MMC_QUIRK_LONG_READ_TIME	BIT(9)	/* Data read time > CSD says */
+#define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN	BIT(10)	/* Skip secure for erase/trim */
+#define MMC_QUIRK_BROKEN_IRQ_POLLING	BIT(11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
+#define MMC_QUIRK_TRIM_BROKEN		BIT(12)	/* Skip trim */
+#define MMC_QUIRK_BROKEN_HPI		BIT(13)	/* Disable broken HPI support */
+#define MMC_QUIRK_BROKEN_SD_DISCARD	BIT(14)	/* Disable broken SD discard support */
+#define MMC_QUIRK_BROKEN_SD_CACHE	BIT(15)	/* Disable broken SD cache support */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
-- 
2.39.2

