Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99246EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjFTKrr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjFTKrp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:45 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0571A8F
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:43 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 395178474B;
        Tue, 20 Jun 2023 12:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258061;
        bh=p9+WamblI8WBdLqm4ibnnaJzlMEhpVgdQhNNQwSTpLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CoN4bEDkYUfvI15yrhTLTwwsKlUr87DDYde+CD3MnkNSmPt2e9wMa1yLneCCCU5Jw
         zcambEXF1dXUU7CZd8PVPuDJn6Nq9HDhKwtSZ/k1SCCzWXadsjlFXHfTW7eCa5sbBP
         YgGcqj2In4rklKVOt/epyROwGMXjTZIZmJ7o8d7MJZmkIKewOKgZLEWCaQL2+bQcIs
         xeGUD/CEEBGMJkr9Kb98nkZZZkX7Tr0IhmBCS+rbar7fJ1Kd8HaOLW+c9HTmG37tNH
         RIii9xVjp9CYJHldaGpK8pET/Fai18r3Ryy+Q3SvV6SMG/kr89w/jDHUntNa8q3Ixi
         q9d/e98lFUSTA==
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
Subject: [PATCH 03/11] mmc: host: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:14 +0200
Message-Id: <20230620104722.16465-3-marex@denx.de>
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
 include/linux/mmc/host.h | 108 +++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 461d1543893bf..71084a5ed6a04 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -349,78 +349,78 @@ struct mmc_host {
 
 	u32			caps;		/* Host capabilities */
 
-#define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
-#define MMC_CAP_MMC_HIGHSPEED	(1 << 1)	/* Can do MMC high-speed timing */
-#define MMC_CAP_SD_HIGHSPEED	(1 << 2)	/* Can do SD high-speed timing */
-#define MMC_CAP_SDIO_IRQ	(1 << 3)	/* Can signal pending SDIO IRQs */
-#define MMC_CAP_SPI		(1 << 4)	/* Talks only SPI protocols */
-#define MMC_CAP_NEEDS_POLL	(1 << 5)	/* Needs polling for card-detection */
-#define MMC_CAP_8_BIT_DATA	(1 << 6)	/* Can the host do 8 bit transfers */
-#define MMC_CAP_AGGRESSIVE_PM	(1 << 7)	/* Suspend (e)MMC/SD at idle  */
-#define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
-#define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
-#define MMC_CAP_3_3V_DDR	(1 << 11)	/* Host supports eMMC DDR 3.3V */
-#define MMC_CAP_1_8V_DDR	(1 << 12)	/* Host supports eMMC DDR 1.8V */
-#define MMC_CAP_1_2V_DDR	(1 << 13)	/* Host supports eMMC DDR 1.2V */
+#define MMC_CAP_4_BIT_DATA	BIT(0)	/* Can the host do 4 bit transfers */
+#define MMC_CAP_MMC_HIGHSPEED	BIT(1)	/* Can do MMC high-speed timing */
+#define MMC_CAP_SD_HIGHSPEED	BIT(2)	/* Can do SD high-speed timing */
+#define MMC_CAP_SDIO_IRQ	BIT(3)	/* Can signal pending SDIO IRQs */
+#define MMC_CAP_SPI		BIT(4)	/* Talks only SPI protocols */
+#define MMC_CAP_NEEDS_POLL	BIT(5)	/* Needs polling for card-detection */
+#define MMC_CAP_8_BIT_DATA	BIT(6)	/* Can the host do 8 bit transfers */
+#define MMC_CAP_AGGRESSIVE_PM	BIT(7)	/* Suspend (e)MMC/SD at idle  */
+#define MMC_CAP_NONREMOVABLE	BIT(8)	/* Nonremovable e.g. eMMC */
+#define MMC_CAP_WAIT_WHILE_BUSY	BIT(9)	/* Waits while card is busy */
+#define MMC_CAP_3_3V_DDR	BIT(11)	/* Host supports eMMC DDR 3.3V */
+#define MMC_CAP_1_8V_DDR	BIT(12)	/* Host supports eMMC DDR 1.8V */
+#define MMC_CAP_1_2V_DDR	BIT(13)	/* Host supports eMMC DDR 1.2V */
 #define MMC_CAP_DDR		(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR | \
 				 MMC_CAP_1_2V_DDR)
-#define MMC_CAP_POWER_OFF_CARD	(1 << 14)	/* Can power off after boot */
-#define MMC_CAP_BUS_WIDTH_TEST	(1 << 15)	/* CMD14/CMD19 bus width ok */
-#define MMC_CAP_UHS_SDR12	(1 << 16)	/* Host supports UHS SDR12 mode */
-#define MMC_CAP_UHS_SDR25	(1 << 17)	/* Host supports UHS SDR25 mode */
-#define MMC_CAP_UHS_SDR50	(1 << 18)	/* Host supports UHS SDR50 mode */
-#define MMC_CAP_UHS_SDR104	(1 << 19)	/* Host supports UHS SDR104 mode */
-#define MMC_CAP_UHS_DDR50	(1 << 20)	/* Host supports UHS DDR50 mode */
+#define MMC_CAP_POWER_OFF_CARD	BIT(14)	/* Can power off after boot */
+#define MMC_CAP_BUS_WIDTH_TEST	BIT(15)	/* CMD14/CMD19 bus width ok */
+#define MMC_CAP_UHS_SDR12	BIT(16)	/* Host supports UHS SDR12 mode */
+#define MMC_CAP_UHS_SDR25	BIT(17)	/* Host supports UHS SDR25 mode */
+#define MMC_CAP_UHS_SDR50	BIT(18)	/* Host supports UHS SDR50 mode */
+#define MMC_CAP_UHS_SDR104	BIT(19)	/* Host supports UHS SDR104 mode */
+#define MMC_CAP_UHS_DDR50	BIT(20)	/* Host supports UHS DDR50 mode */
 #define MMC_CAP_UHS		(MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | \
 				 MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | \
 				 MMC_CAP_UHS_DDR50)
-#define MMC_CAP_SYNC_RUNTIME_PM	(1 << 21)	/* Synced runtime PM suspends. */
-#define MMC_CAP_NEED_RSP_BUSY	(1 << 22)	/* Commands with R1B can't use R1. */
-#define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
-#define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
-#define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-#define MMC_CAP_DONE_COMPLETE	(1 << 27)	/* RW reqs can be completed within mmc_request_done() */
-#define MMC_CAP_CD_WAKE		(1 << 28)	/* Enable card detect wake */
-#define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
-#define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
-#define MMC_CAP_HW_RESET	(1 << 31)	/* Reset the eMMC card via RST_n */
+#define MMC_CAP_SYNC_RUNTIME_PM	BIT(21)	/* Synced runtime PM suspends. */
+#define MMC_CAP_NEED_RSP_BUSY	BIT(22)	/* Commands with R1B can't use R1. */
+#define MMC_CAP_DRIVER_TYPE_A	BIT(23)	/* Host supports Driver Type A */
+#define MMC_CAP_DRIVER_TYPE_C	BIT(24)	/* Host supports Driver Type C */
+#define MMC_CAP_DRIVER_TYPE_D	BIT(25)	/* Host supports Driver Type D */
+#define MMC_CAP_DONE_COMPLETE	BIT(27)	/* RW reqs can be completed within mmc_request_done() */
+#define MMC_CAP_CD_WAKE		BIT(28)	/* Enable card detect wake */
+#define MMC_CAP_CMD_DURING_TFR	BIT(29)	/* Commands during data transfer */
+#define MMC_CAP_CMD23		BIT(30)	/* CMD23 supported. */
+#define MMC_CAP_HW_RESET	BIT(31)	/* Reset the eMMC card via RST_n */
 
 	u32			caps2;		/* More host capabilities */
 
-#define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
-#define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
-#define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND (1 << 3) /* Can do full power cycle in suspend */
-#define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
-#define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
+#define MMC_CAP2_BOOTPART_NOACC	BIT(0)	/* Boot partition no access */
+#define MMC_CAP2_FULL_PWR_CYCLE	BIT(2)	/* Can do full power cycle */
+#define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND BIT(3) /* Can do full power cycle in suspend */
+#define MMC_CAP2_HS200_1_8V_SDR	BIT(5)        /* can support */
+#define MMC_CAP2_HS200_1_2V_SDR	BIT(6)        /* can support */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
-#define MMC_CAP2_SD_EXP		(1 << 7)	/* SD express via PCIe */
-#define MMC_CAP2_SD_EXP_1_2V	(1 << 8)	/* SD express 1.2V */
-#define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
-#define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
-#define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
-#define MMC_CAP2_HS400_1_8V	(1 << 15)	/* Can support HS400 1.8V */
-#define MMC_CAP2_HS400_1_2V	(1 << 16)	/* Can support HS400 1.2V */
+#define MMC_CAP2_SD_EXP		BIT(7)	/* SD express via PCIe */
+#define MMC_CAP2_SD_EXP_1_2V	BIT(8)	/* SD express 1.2V */
+#define MMC_CAP2_CD_ACTIVE_HIGH	BIT(10)	/* Card-detect signal active high */
+#define MMC_CAP2_RO_ACTIVE_HIGH	BIT(11)	/* Write-protect signal active high */
+#define MMC_CAP2_NO_PRESCAN_POWERUP BIT(14)	/* Don't power up before scan */
+#define MMC_CAP2_HS400_1_8V	BIT(15)	/* Can support HS400 1.8V */
+#define MMC_CAP2_HS400_1_2V	BIT(16)	/* Can support HS400 1.2V */
 #define MMC_CAP2_HS400		(MMC_CAP2_HS400_1_8V | \
 				 MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_HSX00_1_8V	(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)
 #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
-#define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
-#define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
-#define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
-#define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
-#define MMC_CAP2_NO_SD		(1 << 21)	/* Do not send SD commands during initialization */
-#define MMC_CAP2_NO_MMC		(1 << 22)	/* Do not send (e)MMC commands during initialization */
-#define MMC_CAP2_CQE		(1 << 23)	/* Has eMMC command queue engine */
-#define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
-#define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
-#define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
+#define MMC_CAP2_SDIO_IRQ_NOTHREAD BIT(17)
+#define MMC_CAP2_NO_WRITE_PROTECT BIT(18)	/* No physical write protect pin, assume that card is always read-write */
+#define MMC_CAP2_NO_SDIO	BIT(19)	/* Do not send SDIO commands during initialization */
+#define MMC_CAP2_HS400_ES	BIT(20)	/* Host supports enhanced strobe */
+#define MMC_CAP2_NO_SD		BIT(21)	/* Do not send SD commands during initialization */
+#define MMC_CAP2_NO_MMC		BIT(22)	/* Do not send (e)MMC commands during initialization */
+#define MMC_CAP2_CQE		BIT(23)	/* Has eMMC command queue engine */
+#define MMC_CAP2_CQE_DCMD	BIT(24)	/* CQE can issue a direct command */
+#define MMC_CAP2_AVOID_3_3V	BIT(25)	/* Host must negotiate down from 3.3V */
+#define MMC_CAP2_MERGE_CAPABLE	BIT(26)	/* Host can merge a segment over the segment size */
 #ifdef CONFIG_MMC_CRYPTO
-#define MMC_CAP2_CRYPTO		(1 << 27)	/* Host supports inline encryption */
+#define MMC_CAP2_CRYPTO		BIT(27)	/* Host supports inline encryption */
 #else
 #define MMC_CAP2_CRYPTO		0
 #endif
-#define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_ALT_GPT_TEGRA	BIT(28)	/* Host with eMMC that has GPT entry at a non-standard location */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
-- 
2.39.2

