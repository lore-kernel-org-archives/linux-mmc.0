Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE13C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5BA61139
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 19:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhEJTMu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 May 2021 15:12:50 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:56428 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231463AbhEJTMt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 May 2021 15:12:49 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 15:12:49 EDT
Received: by lynxeye.de (Postfix, from userid 501)
        id ECD09E74270; Mon, 10 May 2021 21:04:05 +0200 (CEST)
Received: from astat.fritz.box (a89-183-115-43.net-htp.de [89.183.115.43])
        by lynxeye.de (Postfix) with ESMTPA id 1F2F1E74269;
        Mon, 10 May 2021 21:04:04 +0200 (CEST)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode through MMC caps
Date:   Mon, 10 May 2021 21:03:59 +0200
Message-Id: <20210510190400.105162-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510190400.105162-1-l.stach@pengutronix.de>
References: <20210510190400.105162-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Instead of having an indirection through the SDHCI layer and emulating
a capability bit, that isn't there in hardware, do the same same thing
as with HS400_ES and advertise the support for HS400 directly through
the MMC caps.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a20459744d21..65a52586db36 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -427,9 +427,6 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 					| FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
 						     SDHCI_TUNING_MODE_3);
 
-			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
-				val |= SDHCI_SUPPORT_HS400;
-
 			/*
 			 * Do not advertise faster UHS modes if there are no
 			 * pinctrl states for 100MHz/200MHz.
@@ -1603,7 +1600,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
-		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
+		host->mmc->caps2 |= MMC_CAP2_HS400;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
 		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
-- 
2.31.1

