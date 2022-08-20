Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039BBC25B08
	for <linux-mmc@archiver.kernel.org>; Sat, 20 Aug 2022 20:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiHTUAS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 Aug 2022 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiHTT7Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2022 15:59:24 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E193ECEA
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y15so3068545pfr.9
        for <linux-mmc@vger.kernel.org>; Sat, 20 Aug 2022 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=zGt+Ub65YLy++/qay/Cb+UE4unvtuBimX5eqL/7TMUM=;
        b=TmZRC3EWF8Og//JPAlULd5v0S1TGkp4WGJW7K9pjl50UoTBngL5UrEe1G4Qk8Ho9Ie
         4ILENBdR5L33KacZptlf0UImCaI4c4QPCi+sodAbI6JLUzLFG+IF49fqhn248QwZJgeh
         MFpEm6Pgp8aDAhvBxoxxZvPa+9LxkxoV2H7J+xkjZc/2RUUkOUx+fUApQti+pUgjZ7rR
         loJAWzpHyZ8Vc8kPX73CcTpQnV/KvJELOEx8e19MI93uSVOkZzh0b6R3bXZEGtNACEwH
         +1+G4MnoLiSIzsXNMWGGp0rKptHTlxwwSEQanHyD3s1iXZsMWcVkOkHOvDhoyljr+zC8
         8R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=zGt+Ub65YLy++/qay/Cb+UE4unvtuBimX5eqL/7TMUM=;
        b=fm1sUIJdOyWz/DW5vf3wosIbBZ8YkKMFLVR5fhwErMSyh9BaxFoJ7Vj/cTkGdB6qmD
         0d0Eyb4RmBFOzxIXIEZjFYhRhDK8TMFZcIlHh8hTXoRlGMQr+YWH7l7xvIXskxQLXmuR
         9IrmhmJjeKpkv1OBm0ONcSulBYO0mA5e4e9GBf6pIArrI9Cnm0AN01atW3RI1mKJNsfr
         ND0PxEViIh0gVZ3Qg96QFya1QBkLDFZ5H500PhDKTdrls8pu5DV3yLXNl0advqKDLlIn
         Tx0FAuXHScxfGEFD/fI/JuxSkSu49nmT8uhwxHbBtuWugqwVp6jl6vhTw+XXfhe2RvTL
         PDZg==
X-Gm-Message-State: ACgBeo3xEZm78hEkF9wEVHgiAcQRRMh6LufSrXFmXBZ45py0IOR+yi8S
        kH/PzvErds3F83P1GlaZmi0QsQ==
X-Google-Smtp-Source: AA6agR6/XLzCOh2MShdUU+7otmn1iBALg3qnsbHFqUvVZd3MLhpWCg89wZ6o9bLcqYMqTj3hP+mhgw==
X-Received: by 2002:a05:6a02:185:b0:41c:30f7:1fea with SMTP id bj5-20020a056a02018500b0041c30f71feamr10846700pgb.487.1661025537556;
        Sat, 20 Aug 2022 12:58:57 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:56 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Sat, 20 Aug 2022 12:57:50 -0700
Message-Id: <20220820195750.70861-18-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add support for mmc hardware reset with a reset-controller
which would need to be enabled in the device tree with
a supporting driver.  The default is disabled for all
existing designs.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/mmc/host/sdhci-cadence.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index c662c63d49fa..35d37b9aba63 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -12,6 +12,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 
 #include "sdhci-pltfm.h"
 
@@ -70,6 +71,7 @@ struct sdhci_cdns_priv {
 	spinlock_t wrlock;	/* write lock */
 	bool enhanced_strobe;
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
+	struct reset_control *rst_hw;
 	unsigned int nr_phy_params;
 	struct sdhci_cdns_phy_param phy_params[];
 };
@@ -458,6 +460,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
 }
 
+static void sdhci_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+
+	dev_info(mmc_dev(host->mmc), "emmc hardware reset\n");
+
+	reset_control_assert(priv->rst_hw);
+	/* For eMMC, minimum is 1us but give it 9us for good measure */
+	udelay(9);
+
+	reset_control_deassert(priv->rst_hw);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 1000);
+}
+
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -520,6 +538,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
+	if (host->mmc->caps & MMC_CAP_HW_RESET) {
+		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
+		if (IS_ERR(priv->rst_hw)) {
+			ret = PTR_ERR(priv->rst_hw);
+			if (ret == -ENOENT)
+				priv->rst_hw = NULL;
+		} else {
+			host->mmc_host_ops.card_hw_reset = sdhci_mmc_hw_reset;
+		}
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto free;
-- 
2.17.1

