Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D96C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 11:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAD0208CA
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 11:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XN4wdL+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHL3J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 07:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHL3I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 07:29:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C6C05BD43
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 04:29:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g10so1115879lfj.13
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNWxM+ZGU2Lr9e3OTeOUMhu1GGWdAfLeDhUHmw8WK3o=;
        b=XN4wdL+G7rBml4JJdxM7jhrO8aAoF5HF8ebNrF1I90kREb4lnNwnFK3OEnLWfOCTQn
         6+CrNSBF+kZVp6WNJLWFujvf9WoJbqIyFz8Q7rXVGBL9WdD7/1A4lS1Yw7JU4FsfSUWE
         /TXb0zli/MknXvhgllXzUGdpYw8taCwVCMPv37iAp9cwNbbSf2r/h/Hodk7lCWWuw8D2
         LnseaC7GyxkoC/MFa33ODniv1aZuLZTSK9W6k4Sa5dvaHVUievZPXNKg8wbYxSJ/dxKN
         Gr//F0jWi4HdL+QDFaW/fCdruzg1wbxxic5YbGqkVvcJVyPHbBr8fytU1TJWCOAhM4Dh
         tC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNWxM+ZGU2Lr9e3OTeOUMhu1GGWdAfLeDhUHmw8WK3o=;
        b=C28zUNyDiQ5w8iWjU+hlB7OIWc5wU27QNxfT934pfySitI22h9o6mIddBaXng20QP0
         mxiQekNu/wVblbiyNuaRiLus9EnjJHOsh6S5Fr4S+8pOW2R+JNSDQTvAo8UnidSKMN25
         RXfu1cHu+b4nJ6Opf6noYrnf9XBvTnbZznOWIu4sGXveFJtSpGpU5AJ07Gh4v5x9mYnv
         t+z1KtVV3sYql+tbN+4+y7HOclS8cIl9lSk6D8Jbo2DJMGbB28m/MReBZOlhJGeCnnJU
         1XXiO26wFxzBer6T66wOyaH85+MCIDRK4GDqwVcTYNlZc0gqKAZ1CkiwNoncHlh1RISJ
         QzzA==
X-Gm-Message-State: AOAM532Igy2q7/UjR4uIfr+DaCbrzV0NBPIAlDIxWzx+GsKPRMehNl6n
        LAnpHiBgdy2XBFalfWnI8w4IDQAy1Qc=
X-Google-Smtp-Source: ABdhPJwZHF20cznnIkkKcV3EwUAAXBl2sXsIDoy+2KlyjZ3InS4dPFIP/q3lq6rNSNzcalAWCoM6dQ==
X-Received: by 2002:ac2:48a8:: with SMTP id u8mr1572847lfg.41.1588937346087;
        Fri, 08 May 2020 04:29:06 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id r7sm1004803lfc.79.2020.05.08.04.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 04:29:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] mmc: host: Drop redundant MMC_CAP_ERASE
Date:   Fri,  8 May 2020 13:29:02 +0200
Message-Id: <20200508112902.23575-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MMC_CAP_ERASE bit is no longer used by the mmc core as erase, discard
and trim operations are now always supported. Therefore, drop the bit and
move all mmc hosts away from using it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/bcm2835.c        | 3 +--
 drivers/mmc/host/cavium.c         | 3 +--
 drivers/mmc/host/dw_mmc.c         | 6 ------
 drivers/mmc/host/meson-mx-sdio.c  | 2 +-
 drivers/mmc/host/mtk-sd.c         | 2 +-
 drivers/mmc/host/mvsdio.c         | 2 --
 drivers/mmc/host/mxs-mmc.c        | 3 +--
 drivers/mmc/host/omap.c           | 2 +-
 drivers/mmc/host/omap_hsmmc.c     | 2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 +-
 drivers/mmc/host/sdhci.c          | 2 +-
 drivers/mmc/host/sunxi-mmc.c      | 2 +-
 drivers/mmc/host/tmio_mmc_core.c  | 2 +-
 drivers/staging/greybus/sdio.c    | 1 -
 include/linux/mmc/host.h          | 1 -
 16 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index c3d949847cbd..a0767790a826 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1280,8 +1280,7 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 
 	/* host controller capabilities */
 	mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-		     MMC_CAP_NEEDS_POLL | MMC_CAP_HW_RESET | MMC_CAP_ERASE |
-		     MMC_CAP_CMD23;
+		     MMC_CAP_NEEDS_POLL | MMC_CAP_HW_RESET | MMC_CAP_CMD23;
 
 	spin_lock_init(&host->lock);
 	mutex_init(&host->mutex);
diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 89deb451e0ac..c5da3aaee334 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -1038,8 +1038,7 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	 * Disable bounce buffers for max_segs = 1
 	 */
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_POWER_OFF_CARD |
-		     MMC_CAP_3_3V_DDR;
+		     MMC_CAP_CMD23 | MMC_CAP_POWER_OFF_CARD | MMC_CAP_3_3V_DDR;
 
 	if (host->use_sg)
 		mmc->max_segs = 16;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5d1f8a3ec3a5..35ae5737c622 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2751,12 +2751,6 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
 
-	/*
-	 * Support MMC_CAP_ERASE by default.
-	 * It needs to use trim/discard/erase commands.
-	 */
-	mmc->caps |= MMC_CAP_ERASE;
-
 	if (host->pdata->pm_caps)
 		mmc->pm_caps = host->pdata->pm_caps;
 
diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 3813b544f571..9b2cf7afc246 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -564,7 +564,7 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
 	mmc->f_max = clk_round_rate(host->cfg_div_clk,
 				    clk_get_rate(host->parent_clk));
 
-	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
+	mmc->caps |= MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
 	mmc->ops = &meson_mx_mmc_ops;
 
 	ret = mmc_of_parse(mmc);
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 53819ae9f271..39e7fc54c438 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2326,7 +2326,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
-	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |= MMC_CAP_CMD23;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = MAX_BD_NUM;
 	if (host->dev_comp->support_64g)
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 203b61712601..cc0752a9df6d 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -752,8 +752,6 @@ static int mvsd_probe(struct platform_device *pdev)
 	if (maxfreq)
 		mmc->f_max = maxfreq;
 
-	mmc->caps |= MMC_CAP_ERASE;
-
 	spin_lock_init(&host->lock);
 
 	host->base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index d82674aed447..b1820def36c0 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -634,8 +634,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	/* set mmc core parameters */
 	mmc->ops = &mxs_mmc_ops;
 	mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL | MMC_CAP_CMD23 |
-		    MMC_CAP_ERASE;
+		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL | MMC_CAP_CMD23;
 
 	host->broken_cd = of_property_read_bool(np, "broken-cd");
 
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index d74e73c95fdf..33d7af7c7762 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1244,7 +1244,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 
 	mmc->caps = 0;
 	if (host->pdata->slots[id].wires >= 4)
-		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_ERASE;
+		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
 	mmc->ops = &mmc_omap_ops;
 	mmc->f_min = 400000;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a379c45b985c..37b8740513f5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1922,7 +1922,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE | MMC_CAP_CMD23;
+		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_CMD23;
 
 	mmc->caps |= mmc_pdata(host)->caps;
 	if (mmc->caps & MMC_CAP_8_BIT_DATA)
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 11087976ab19..5a71f6678fd3 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1347,7 +1347,7 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195;
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
-		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_ERASE;
+		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
 	mmc->max_current_330 = 400;
 	mmc->max_current_180 = 800;
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 81d0dfe553a8..a7084c50ad65 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1314,7 +1314,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50 |
-		MMC_CAP_ERASE | MMC_CAP_SYNC_RUNTIME_PM;
+		MMC_CAP_SYNC_RUNTIME_PM;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
 		MMC_CAP2_NO_SDIO;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1bb6b6796318..95cc08c1fed9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4331,7 +4331,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	    !host->ops->get_max_timeout_count)
 		mmc->max_busy_timeout = 0;
 
-	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 3bfbd89bd4ab..5e95bbc51644 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1394,7 +1394,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->f_min		=   400000;
 	mmc->f_max		= 52000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
+				  MMC_CAP_SDIO_IRQ;
 
 	/*
 	 * Some H5 devices do not have signal traces precise enough to
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 9520bd94cf43..f31afd1c2671 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1128,7 +1128,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
-	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_4_BIT_DATA | pdata->capabilities;
+	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = pdata->max_segs ? : 32;
 	mmc->max_blk_size = TMIO_MAX_BLK_SIZE;
diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index c4b16bb5c1a4..0939f4a4c963 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -67,7 +67,6 @@ static void _gb_sdio_set_host_caps(struct gb_sdio_host *host, u32 r)
 		((r & GB_SDIO_CAP_8_BIT_DATA) ? MMC_CAP_8_BIT_DATA : 0) |
 		((r & GB_SDIO_CAP_MMC_HS) ? MMC_CAP_MMC_HIGHSPEED : 0) |
 		((r & GB_SDIO_CAP_SD_HS) ? MMC_CAP_SD_HIGHSPEED : 0) |
-		((r & GB_SDIO_CAP_ERASE) ? MMC_CAP_ERASE : 0) |
 		((r & GB_SDIO_CAP_1_2V_DDR) ? MMC_CAP_1_2V_DDR : 0) |
 		((r & GB_SDIO_CAP_1_8V_DDR) ? MMC_CAP_1_8V_DDR : 0) |
 		((r & GB_SDIO_CAP_POWER_OFF_CARD) ? MMC_CAP_POWER_OFF_CARD : 0) |
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d4a50e5dc111..7149bab555d7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -321,7 +321,6 @@ struct mmc_host {
 #define MMC_CAP_AGGRESSIVE_PM	(1 << 7)	/* Suspend (e)MMC/SD at idle  */
 #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
-#define MMC_CAP_ERASE		(1 << 10)	/* Allow erase/trim commands */
 #define MMC_CAP_3_3V_DDR	(1 << 11)	/* Host supports eMMC DDR 3.3V */
 #define MMC_CAP_1_8V_DDR	(1 << 12)	/* Host supports eMMC DDR 1.8V */
 #define MMC_CAP_1_2V_DDR	(1 << 13)	/* Host supports eMMC DDR 1.2V */
-- 
2.20.1

