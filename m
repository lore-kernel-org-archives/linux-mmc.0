Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC55FC38145
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Sep 2022 20:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIGU6M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIGU6L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Sep 2022 16:58:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A9AEDB7
        for <linux-mmc@vger.kernel.org>; Wed,  7 Sep 2022 13:58:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l12so9002010ljg.9
        for <linux-mmc@vger.kernel.org>; Wed, 07 Sep 2022 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+zwPrAPaA9LSNOwn49+2xVo1Odc1SksXzrLSfOsGk5Q=;
        b=kBjdNaph0ybHnqxFKnqGwHW7S9/gd2bYW1dzOiSalIi6sBRjpT1u9O7DCmuXPeUueW
         5EF59fLEtNpk9SHsTi9ULPG5URTezNAm/pLk/KxWqCzn+WisXwDG+L/XM8dPM/UCLtXU
         7C2cvhujp+IiD3uxz28kTWYbrcg4PaVxhlZ0RELFY2uu53WQPHbuMuaWJ66Wgg3fB7sw
         zWB/crgkkXBa7+MpnKzs8v476t+z1q5pItuak3o0AdMEiekycPMUK0ZV4JacPjUwO6Oh
         P0D93WNqeOwnXGNHHlrgwOQrSwpSLYyKMXJUulIw+1EzQPiI0umWOaHUQveynwmuwZNO
         u4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+zwPrAPaA9LSNOwn49+2xVo1Odc1SksXzrLSfOsGk5Q=;
        b=cfYkEbuQz41rFSspSRNLreQGnUTRxnJithZ+5th/f9027qYrp6rTCx/CtJhyQeyI17
         hQVx15jcWLZgXrCW8T/Ccv3R2vrfiUVkvM7b/14Ezye6IMpjTmMDbErQDuGthH5Fd9o7
         4FNIkD+bLh/F4fl5R7g0v2MsPIBlJbaNsR6J+XCiPJ2PCvo0+1AAj4N09zWLugrO9Nr/
         9wuYtn7oSkk5REPEeRWSbleaNBj01Oi4aRppx7E6dm1Y0P2MHBsH+1VWNpOxg6F7RjRF
         D9dDqrCtNKJkkfTDuYdrsGM4zv9soDAYFOV4N7lXnxmR9h86bzohhXtfAtZPAz2r9idx
         3tlQ==
X-Gm-Message-State: ACgBeo2J4NXX0KdELazzIvaKDSm2PzEtO0QdByKlx9+LnpTmrT6bKdC5
        RJGTQQE61yOT6tAicgHHTaEb8m9yue+bIBp4
X-Google-Smtp-Source: AA6agR6gcALrQjgPypOBlDtUt3486ZIgAQiOEZHiaY+OgP/OnQQjo+lwpEJvGffiqcR57m4g1sX+Og==
X-Received: by 2002:a2e:9946:0:b0:265:9901:80cf with SMTP id r6-20020a2e9946000000b00265990180cfmr1462091ljj.306.1662584288148;
        Wed, 07 Sep 2022 13:58:08 -0700 (PDT)
Received: from saproj-Latitude-5501.yandex.net ([2a02:6b8:0:40c:b01c:9ff4:8f8e:3acd])
        by smtp.gmail.com with ESMTPSA id s26-20020a05651c201a00b0026a999966bbsm1460117ljo.24.2022.09.07.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:58:07 -0700 (PDT)
From:   Sergei Antonov <saproj@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, Sergei Antonov <saproj@gmail.com>,
        Jonas Jensen <jonas.jensen@gmail.com>
Subject: [PATCH] mmc: moxart: fix 4-bit bus width, remove 8-bit bus width
Date:   Wed,  7 Sep 2022 23:57:53 +0300
Message-Id: <20220907205753.1577434-1-saproj@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to the datasheet:
https://bitbucket.org/Kasreyn/mkrom-uc7112lx/src/master/documents/FIC8120_DS_v1.2.pdf
, page 377
4-bit bus width is turned on by bit 2 of the Bus Width Register, so
the current bitmask is wrong:
 define BUS_WIDTH_4            BIT(1)
BIT(1) does not work and BIT(2) works. It was verified on real MOXA
hardware with FTSDC010 controller revision 1_6_0.

The corrected value of BUS_WIDTH_4 mask collides with:
 define BUS_WIDTH_8            BIT(2)
No evidence of 8-bit bus width mode is found in the datasheet. Remove
code dealing with 8-bit bus width.

Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")
Signed-off-by: Sergei Antonov <saproj@gmail.com>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index b6eb75f4bbfc..dfc3ffd5b1f8 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -111,8 +111,8 @@
 #define CLK_DIV_MASK		0x7f
 
 /* REG_BUS_WIDTH */
-#define BUS_WIDTH_8		BIT(2)
-#define BUS_WIDTH_4		BIT(1)
+#define BUS_WIDTH_4_SUPPORT	BIT(3)
+#define BUS_WIDTH_4		BIT(2)
 #define BUS_WIDTH_1		BIT(0)
 
 #define MMC_VDD_360		23
@@ -524,9 +524,6 @@ static void moxart_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_BUS_WIDTH_4:
 		writel(BUS_WIDTH_4, host->base + REG_BUS_WIDTH);
 		break;
-	case MMC_BUS_WIDTH_8:
-		writel(BUS_WIDTH_8, host->base + REG_BUS_WIDTH);
-		break;
 	default:
 		writel(BUS_WIDTH_1, host->base + REG_BUS_WIDTH);
 		break;
@@ -651,16 +648,8 @@ static int moxart_probe(struct platform_device *pdev)
 		dmaengine_slave_config(host->dma_chan_rx, &cfg);
 	}
 
-	switch ((readl(host->base + REG_BUS_WIDTH) >> 3) & 3) {
-	case 1:
+	if (readl(host->base + REG_BUS_WIDTH) & BUS_WIDTH_4_SUPPORT)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
-		break;
-	case 2:
-		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
-		break;
-	default:
-		break;
-	}
 
 	writel(0, host->base + REG_INTERRUPT_MASK);
 
-- 
2.34.1

