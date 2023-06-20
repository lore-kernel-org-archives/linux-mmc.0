Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BD4C0015E
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 10:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFTKr4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjFTKrs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 06:47:48 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C808F
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 03:47:46 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 13ACB86351;
        Tue, 20 Jun 2023 12:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687258065;
        bh=I28rLw3TRO4a0p5HTA64AoGki+TRUpTaASYkwxYYktM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdN65J1PiQj/ZxMg6DaG2S62fX963lujan34Nk0cQdXdrCwm7isJrsDm8iZwYW2ir
         HvpGNI5NRyg/vpvUzrZ271sUZKjk5XqCrggNLCN/PCVYL330QbAWdt6ZCMtM6w1mCp
         OGUREUOMLVJ6PTS1P5rF2yc05F0cZrmnCcA4U5GLdN88YprRcogL06xpvINn9K9o6Q
         DX6LKq+b2H4IafRsfrIxG+BH7xUtvVUDfNDjfVojckdnYoNYQ4Sbue5LhX25pvZ413
         SSudb3BVhEP3SCEez800INsF48IRRAnr13R5ZHJTyDrdzeWpsuJYRWN+bGm3L00RSe
         ksT1t8+P1+zfQ==
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
Subject: [PATCH 09/11] mmc: sdhci: Use BIT() macro
Date:   Tue, 20 Jun 2023 12:47:20 +0200
Message-Id: <20230620104722.16465-9-marex@denx.de>
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
 drivers/mmc/host/sdhci.h | 126 +++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f219bdea8f280..05bdd5ef958a1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -379,112 +379,112 @@ struct sdhci_host {
 	unsigned int quirks;	/* Deviations from spec. */
 
 /* Controller doesn't honor resets unless we touch the clock register */
-#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
+#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			BIT(0)
 /* Controller has bad caps bits, but really supports DMA */
-#define SDHCI_QUIRK_FORCE_DMA				(1<<1)
+#define SDHCI_QUIRK_FORCE_DMA				BIT(1)
 /* Controller doesn't like to be reset when there is no card inserted. */
-#define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
+#define SDHCI_QUIRK_NO_CARD_NO_RESET			BIT(2)
 /* Controller doesn't like clearing the power reg before a change */
-#define SDHCI_QUIRK_SINGLE_POWER_WRITE			(1<<3)
+#define SDHCI_QUIRK_SINGLE_POWER_WRITE			BIT(3)
 /* Controller has an unusable DMA engine */
-#define SDHCI_QUIRK_BROKEN_DMA				(1<<5)
+#define SDHCI_QUIRK_BROKEN_DMA				BIT(5)
 /* Controller has an unusable ADMA engine */
-#define SDHCI_QUIRK_BROKEN_ADMA				(1<<6)
+#define SDHCI_QUIRK_BROKEN_ADMA				BIT(6)
 /* Controller can only DMA from 32-bit aligned addresses */
-#define SDHCI_QUIRK_32BIT_DMA_ADDR			(1<<7)
+#define SDHCI_QUIRK_32BIT_DMA_ADDR			BIT(7)
 /* Controller can only DMA chunk sizes that are a multiple of 32 bits */
-#define SDHCI_QUIRK_32BIT_DMA_SIZE			(1<<8)
+#define SDHCI_QUIRK_32BIT_DMA_SIZE			BIT(8)
 /* Controller can only ADMA chunks that are a multiple of 32 bits */
-#define SDHCI_QUIRK_32BIT_ADMA_SIZE			(1<<9)
+#define SDHCI_QUIRK_32BIT_ADMA_SIZE			BIT(9)
 /* Controller needs to be reset after each request to stay stable */
-#define SDHCI_QUIRK_RESET_AFTER_REQUEST			(1<<10)
+#define SDHCI_QUIRK_RESET_AFTER_REQUEST			BIT(10)
 /* Controller needs voltage and power writes to happen separately */
-#define SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER		(1<<11)
+#define SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER		BIT(11)
 /* Controller provides an incorrect timeout value for transfers */
-#define SDHCI_QUIRK_BROKEN_TIMEOUT_VAL			(1<<12)
+#define SDHCI_QUIRK_BROKEN_TIMEOUT_VAL			BIT(12)
 /* Controller has an issue with buffer bits for small transfers */
-#define SDHCI_QUIRK_BROKEN_SMALL_PIO			(1<<13)
+#define SDHCI_QUIRK_BROKEN_SMALL_PIO			BIT(13)
 /* Controller does not provide transfer-complete interrupt when not busy */
-#define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<14)
+#define SDHCI_QUIRK_NO_BUSY_IRQ				BIT(14)
 /* Controller has unreliable card detection */
-#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
+#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		BIT(15)
 /* Controller reports inverted write-protect state */
-#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
+#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		BIT(16)
 /* Controller has unusable command queue engine */
-#define SDHCI_QUIRK_BROKEN_CQE				(1<<17)
+#define SDHCI_QUIRK_BROKEN_CQE				BIT(17)
 /* Controller does not like fast PIO transfers */
-#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
+#define SDHCI_QUIRK_PIO_NEEDS_DELAY			BIT(18)
 /* Controller does not have a LED */
-#define SDHCI_QUIRK_NO_LED				(1<<19)
+#define SDHCI_QUIRK_NO_LED				BIT(19)
 /* Controller has to be forced to use block size of 2048 bytes */
-#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
+#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			BIT(20)
 /* Controller cannot do multi-block transfers */
-#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
+#define SDHCI_QUIRK_NO_MULTIBLOCK			BIT(21)
 /* Controller can only handle 1-bit data transfers */
-#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
+#define SDHCI_QUIRK_FORCE_1_BIT_DATA			BIT(22)
 /* Controller needs 10ms delay between applying power and clock */
-#define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
+#define SDHCI_QUIRK_DELAY_AFTER_POWER			BIT(23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
-#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		BIT(24)
 /* Controller reports wrong base clock capability */
-#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
+#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		BIT(25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
-#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		BIT(26)
 /* Controller uses Auto CMD12 command to stop the transfer */
-#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
+#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		BIT(28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
-#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+#define SDHCI_QUIRK_NO_HISPD_BIT			BIT(29)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
-#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
+#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		BIT(30)
 /* The read-only detection via SDHCI_PRESENT_STATE register is unstable */
-#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<31)
+#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			BIT(31)
 
 	unsigned int quirks2;	/* More deviations from spec. */
 
-#define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
-#define SDHCI_QUIRK2_HOST_NO_CMD23			(1<<1)
+#define SDHCI_QUIRK2_HOST_OFF_CARD_ON			BIT(0)
+#define SDHCI_QUIRK2_HOST_NO_CMD23			BIT(1)
 /* The system physically doesn't support 1.8v, even if the host does */
-#define SDHCI_QUIRK2_NO_1_8_V				(1<<2)
-#define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		(1<<3)
-#define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		(1<<4)
+#define SDHCI_QUIRK2_NO_1_8_V				BIT(2)
+#define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		BIT(3)
+#define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		BIT(4)
 /* Controller has a non-standard host control register */
-#define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
+#define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		BIT(5)
 /* Controller does not support HS200 */
-#define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
+#define SDHCI_QUIRK2_BROKEN_HS200			BIT(6)
 /* Controller does not support DDR50 */
-#define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
+#define SDHCI_QUIRK2_BROKEN_DDR50			BIT(7)
 /* Stop command (CMD12) can set Transfer Complete when not using MMC_RSP_BUSY */
-#define SDHCI_QUIRK2_STOP_WITH_TC			(1<<8)
+#define SDHCI_QUIRK2_STOP_WITH_TC			BIT(8)
 /* Controller does not support 64-bit DMA */
-#define SDHCI_QUIRK2_BROKEN_64_BIT_DMA			(1<<9)
+#define SDHCI_QUIRK2_BROKEN_64_BIT_DMA			BIT(9)
 /* need clear transfer mode register before send cmd */
-#define SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD	(1<<10)
+#define SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD	BIT(10)
 /* Capability register bit-63 indicates HS400 support */
-#define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		(1<<11)
+#define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		BIT(11)
 /* forced tuned clock */
-#define SDHCI_QUIRK2_TUNING_WORK_AROUND			(1<<12)
+#define SDHCI_QUIRK2_TUNING_WORK_AROUND			BIT(12)
 /* disable the block count for single block transactions */
-#define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<13)
+#define SDHCI_QUIRK2_SUPPORT_SINGLE			BIT(13)
 /* Controller broken with using ACMD23 */
-#define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
+#define SDHCI_QUIRK2_ACMD23_BROKEN			BIT(14)
 /* Broken Clock divider zero in controller */
-#define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+#define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		BIT(15)
 /* Controller has CRC in 136 bit Command Response */
-#define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
+#define SDHCI_QUIRK2_RSP_136_HAS_CRC			BIT(16)
 /*
  * Disable HW timeout if the requested timeout is more than the maximum
  * obtainable timeout.
  */
-#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			BIT(17)
 /*
  * 32-bit block count may not support eMMC where upper bits of CMD23 are used
  * for other purposes.  Consequently we support 16-bit block count by default.
  * Otherwise, SDHCI_QUIRK2_USE_32BIT_BLK_CNT can be selected to use 32-bit
  * block count.
  */
-#define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+#define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			BIT(18)
 /* Issue CMD and DATA reset together */
-#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
+#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	BIT(19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
@@ -508,19 +508,19 @@ struct sdhci_host {
 	spinlock_t lock;	/* Mutex */
 
 	int flags;		/* Host attributes */
-#define SDHCI_USE_SDMA		(1<<0)	/* Host is SDMA capable */
-#define SDHCI_USE_ADMA		(1<<1)	/* Host is ADMA capable */
-#define SDHCI_REQ_USE_DMA	(1<<2)	/* Use DMA for this req. */
-#define SDHCI_DEVICE_DEAD	(1<<3)	/* Device unresponsive */
-#define SDHCI_SDR50_NEEDS_TUNING (1<<4)	/* SDR50 needs tuning */
-#define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
-#define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
-#define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
-#define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
-#define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
-#define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
-#define SDHCI_SIGNALING_180	(1<<15)	/* Host is capable of 1.8V signaling */
-#define SDHCI_SIGNALING_120	(1<<16)	/* Host is capable of 1.2V signaling */
+#define SDHCI_USE_SDMA		BIT(0)	/* Host is SDMA capable */
+#define SDHCI_USE_ADMA		BIT(1)	/* Host is ADMA capable */
+#define SDHCI_REQ_USE_DMA	BIT(2)	/* Use DMA for this req. */
+#define SDHCI_DEVICE_DEAD	BIT(3)	/* Device unresponsive */
+#define SDHCI_SDR50_NEEDS_TUNING BIT(4)	/* SDR50 needs tuning */
+#define SDHCI_AUTO_CMD12	BIT(6)	/* Auto CMD12 support */
+#define SDHCI_AUTO_CMD23	BIT(7)	/* Auto CMD23 support */
+#define SDHCI_PV_ENABLED	BIT(8)	/* Preset value enabled */
+#define SDHCI_USE_64_BIT_DMA	BIT(12)	/* Use 64-bit DMA */
+#define SDHCI_HS400_TUNING	BIT(13)	/* Tuning for HS400 */
+#define SDHCI_SIGNALING_330	BIT(14)	/* Host is capable of 3.3V signaling */
+#define SDHCI_SIGNALING_180	BIT(15)	/* Host is capable of 1.8V signaling */
+#define SDHCI_SIGNALING_120	BIT(16)	/* Host is capable of 1.2V signaling */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
2.39.2

