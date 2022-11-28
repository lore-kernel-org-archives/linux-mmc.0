Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D83EC43217
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 02:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiK1Cot (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Nov 2022 21:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1Cos (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2022 21:44:48 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F263A18D
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so3598149pga.5
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv1e03FO2qF987UL3rYSZkGVDWpL3dr4bIgnamkaz8k=;
        b=OGNey52SwCPracCX9H9kykEMys7l+KWvUGpL45jpXgrjzIMiOCLtOs2NlKRZFxwS0C
         EwEOSeJRFOuZo0aIvt+Q8iefpRR3NrjVq4g6xLvbizsPI2NFs8WOoPBJPo+K5lPLHJLi
         NxhK+QJMgGijfkqWN3iHxc1CEQNMLAFYXzrtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv1e03FO2qF987UL3rYSZkGVDWpL3dr4bIgnamkaz8k=;
        b=I3hEbGSVYm4gwyzgzLxpKj9U+GLng5wJ+9iwnXSSKr4GUQLYXTCHAxcVe7CQIOHqo0
         Um0np7ykbx4nnFKyRR4k0My/LmEqqvUNpd+91QBcmzftQhQyDaZYYTDoZmCRvtr6MolE
         gr50CDsQJmYUMWi+eCDKpq+nNPTtqyRfSFn2dDp/89J/CdNoK3a3ZFDHIHs3Yehp9yiY
         x/CsxRSZzLSU3Em8AgVqLuNoIwYUoDjfXKCar1S988pv2pMW7isYXJIRBH6/er9eVdnU
         WYNrlM4evDdlieAiQ2/xNEqVTDQO0rRG0L9IAH5TjPucB3lSEGPaXXaBfO2Km8+oe8zp
         e/uQ==
X-Gm-Message-State: ANoB5pmShfYGlYitvi06ycWsFx2swuA/LwqhnDqGSWoHAzmAt0/qv34P
        byq2pKs9KEQEpT5fsgUM+JQBSA==
X-Google-Smtp-Source: AA0mqf5/n6iwg6NmZl3VghZbs771G+jDVX2jWINfcJkDxvuGlcchDWA4SndnsAopjkv5zHMHMBFdkA==
X-Received: by 2002:aa7:8d8f:0:b0:56b:b112:4a16 with SMTP id i15-20020aa78d8f000000b0056bb1124a16mr52473821pfr.66.1669603484351;
        Sun, 27 Nov 2022 18:44:44 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79910000000b005752201d4ffsm1431568pff.213.2022.11.27.18.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 18:44:43 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH 1/8] mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
Date:   Sun, 27 Nov 2022 18:44:00 -0800
Message-Id: <20221128024407.224393-2-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128024407.224393-1-doug@schmorgal.com>
References: <20221128024407.224393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a new compatible string for the version 1 controller used in the
PXA168, along with necessary quirks. Use a separate ops struct in
preparation for a silicon bug workaround only necessary on V1.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index f18906b5575f..2f9fa0ecbddd 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -101,6 +101,14 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
 }
 
+static const struct sdhci_ops pxav1_sdhci_ops = {
+	.set_clock     = sdhci_set_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_bus_width = pxav2_mmc_set_bus_width,
+	.reset         = pxav2_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
 static const struct sdhci_ops pxav2_sdhci_ops = {
 	.set_clock     = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -114,6 +122,9 @@ static const struct of_device_id sdhci_pxav2_of_match[] = {
 	{
 		.compatible = "mrvl,pxav2-mmc",
 	},
+	{
+		.compatible = "mrvl,pxav1-mmc",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_pxav2_of_match);
@@ -208,7 +219,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 			host->mmc->pm_caps |= pdata->pm_caps;
 	}
 
-	host->ops = &pxav2_sdhci_ops;
+	if (match && of_device_is_compatible(dev->of_node, "mrvl,pxav1-mmc")) {
+		host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_32BIT_DMA_SIZE;
+		host->ops = &pxav1_sdhci_ops;
+	} else {
+		host->ops = &pxav2_sdhci_ops;
+	}
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
2.34.1

