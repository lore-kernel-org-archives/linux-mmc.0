Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80823C64E7A
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 03:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3378B223FD
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 03:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="odlhDTNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgKTD1I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 22:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKTD1H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 22:27:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAA7C0613CF
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 19:27:05 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 74so11432281lfo.5
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 19:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtVhfYD/69XwLnY3chV1Pn/LsBq7+sufek6izqaTxb0=;
        b=odlhDTNku9GOSmqPl1PVZ9SNfNX1Z4NRTHhzEcEJTCM/DWw48xU9d2FVOn3Vf+Lhpy
         aDfwWrT4OXwmyi8H3HqLDHuWg5LgHQ18EnM6VnlH75QiwkKGLRDBTCfCKW3QI2YiJ4xm
         /nzteJtM8a+NNEyd4rZSzOgk0+eKIJxZ3QcpGRKNAgRyKuj0D7yCeWopTAPYDWQkfK+C
         rKYUSN4g8//AGAuBmapL9PHouH0IdIkmSokcmL9xELXo0R7Pktyb3phE+YgEgrNeFA9D
         1MP9sQzTnmsbVL6VqzpaK3w34wU+Z99V91b8z4LpOu/dBqHD6q943ZZp+GgdOBgtNknk
         fH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtVhfYD/69XwLnY3chV1Pn/LsBq7+sufek6izqaTxb0=;
        b=aCZOjQYYaZE1a3MHmbiSU4gUI4Ls5LytIyslNXQp2EmU11+GSWpCkUoSe7z4pBdn/y
         kJE/+ZVHLy0eXS5d1YQpZpWFMQuRVDnuQljkD1qdHs7Aljjvj9lOY9GHDyGGBhPv+zxb
         22fkFK/gPPCa3o/pODQ0d1V9IFRB1I4u8QwXKYNus0OpP0XoKoK9B5we+y0uLpymGPBH
         VJDw5ZciH+LOiMD4EL0/aBoU8FHs/sjKxXDpVKIJf3k26CwHYn8sKbN/yoTScwpw6Ey5
         IR8rbJ43P1gojTJSBtMU7eiMHTXLwUqmgurFY8QYoOtZq/GX8cDuKpTScQjxhABr6qex
         YQFw==
X-Gm-Message-State: AOAM531f8srl42kPJl6JZCerB8T1g4mwcELnbG6/cg+yHnbQGcp9NpLh
        f5ZAUBCxCgcS/8ZhWpDJBxLhQw==
X-Google-Smtp-Source: ABdhPJyKrAhREoYW3DfnIVVwC2htmmAJRkwB1cZZeLeNnIneLPPB8ObU+UPIw9YWPKx0dVxRwUebCQ==
X-Received: by 2002:a19:2d5c:: with SMTP id t28mr6938372lft.267.1605842824095;
        Thu, 19 Nov 2020 19:27:04 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id s26sm153647lji.31.2020.11.19.19.27.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 19:27:03 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 2/4] mmc: sdhci-xenon: switch to device_* API
Date:   Fri, 20 Nov 2020 04:26:37 +0100
Message-Id: <20201120032639.24386-3-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201120032639.24386-1-mw@semihalf.com>
References: <20201120032639.24386-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In order to support both ACPI and DT, modify the driver
to use device_* routines for obtaining the properties
values.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-xenon.h     |  4 +--
 drivers/mmc/host/sdhci-xenon-phy.c | 36 +++++++++++---------
 drivers/mmc/host/sdhci-xenon.c     | 18 +++++-----
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 39e898605937..3e9c6c908a79 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -101,8 +101,8 @@ struct xenon_priv {
 };
 
 int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
-int xenon_phy_parse_dt(struct device_node *np,
-		       struct sdhci_host *host);
+int xenon_phy_parse_params(struct device *dev,
+			   struct sdhci_host *host);
 void xenon_soc_pad_ctrl(struct sdhci_host *host,
 			unsigned char signal_voltage);
 #endif
diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index c33e0cddc81a..8cf3a375de65 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -691,35 +691,37 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
 	return ret;
 }
 
-static int xenon_emmc_phy_parse_param_dt(struct sdhci_host *host,
-					 struct device_node *np,
-					 struct xenon_emmc_phy_params *params)
+static int xenon_emmc_phy_parse_params(struct sdhci_host *host,
+				       struct device *dev,
+				       struct xenon_emmc_phy_params *params)
 {
 	u32 value;
 
 	params->slow_mode = false;
-	if (of_property_read_bool(np, "marvell,xenon-phy-slow-mode"))
+	if (device_property_read_bool(dev, "marvell,xenon-phy-slow-mode"))
 		params->slow_mode = true;
 
 	params->znr = XENON_ZNR_DEF_VALUE;
-	if (!of_property_read_u32(np, "marvell,xenon-phy-znr", &value))
+	if (!device_property_read_u32(dev, "marvell,xenon-phy-znr", &value))
 		params->znr = value & XENON_ZNR_MASK;
 
 	params->zpr = XENON_ZPR_DEF_VALUE;
-	if (!of_property_read_u32(np, "marvell,xenon-phy-zpr", &value))
+	if (!device_property_read_u32(dev, "marvell,xenon-phy-zpr", &value))
 		params->zpr = value & XENON_ZPR_MASK;
 
 	params->nr_tun_times = XENON_TUN_CONSECUTIVE_TIMES;
-	if (!of_property_read_u32(np, "marvell,xenon-phy-nr-success-tun",
-				  &value))
+	if (!device_property_read_u32(dev, "marvell,xenon-phy-nr-success-tun",
+				      &value))
 		params->nr_tun_times = value & XENON_TUN_CONSECUTIVE_TIMES_MASK;
 
 	params->tun_step_divider = XENON_TUNING_STEP_DIVIDER;
-	if (!of_property_read_u32(np, "marvell,xenon-phy-tun-step-divider",
-				  &value))
+	if (!device_property_read_u32(dev, "marvell,xenon-phy-tun-step-divider",
+				      &value))
 		params->tun_step_divider = value & 0xFF;
 
-	return get_dt_pad_ctrl_data(host, np, params);
+	if (dev->of_node)
+		return get_dt_pad_ctrl_data(host, dev->of_node, params);
+	return 0;
 }
 
 /* Set SoC PHY Voltage PAD */
@@ -813,7 +815,7 @@ int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
 	return ret;
 }
 
-static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
+static int xenon_add_phy(struct device *dev, struct sdhci_host *host,
 			 const char *phy_name)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -832,15 +834,15 @@ static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
 	if (ret)
 		return ret;
 
-	return xenon_emmc_phy_parse_param_dt(host, np, priv->phy_params);
+	return xenon_emmc_phy_parse_params(host, dev, priv->phy_params);
 }
 
-int xenon_phy_parse_dt(struct device_node *np, struct sdhci_host *host)
+int xenon_phy_parse_params(struct device *dev, struct sdhci_host *host)
 {
 	const char *phy_type = NULL;
 
-	if (!of_property_read_string(np, "marvell,xenon-phy-type", &phy_type))
-		return xenon_add_phy(np, host, phy_type);
+	if (!device_property_read_string(dev, "marvell,xenon-phy-type", &phy_type))
+		return xenon_add_phy(dev, host, phy_type);
 
-	return xenon_add_phy(np, host, "emmc 5.1 phy");
+	return xenon_add_phy(dev, host, "emmc 5.1 phy");
 }
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 1e7ce9b1a143..bfc76b0e3eaa 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -407,9 +407,9 @@ static void xenon_replace_mmc_host_ops(struct sdhci_host *host)
  *	    Refer to XENON_SYS_CFG_INFO register
  * tun-count: the interval between re-tuning
  */
-static int xenon_probe_dt(struct platform_device *pdev)
+static int xenon_probe_params(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct mmc_host *mmc = host->mmc;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -422,7 +422,7 @@ static int xenon_probe_dt(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
 	sdhc_id = 0x0;
-	if (!of_property_read_u32(np, "marvell,xenon-sdhc-id", &sdhc_id)) {
+	if (!device_property_read_u32(dev, "marvell,xenon-sdhc-id", &sdhc_id)) {
 		nr_sdhc = sdhci_readl(host, XENON_SYS_CFG_INFO);
 		nr_sdhc &= XENON_NR_SUPPORTED_SLOT_MASK;
 		if (unlikely(sdhc_id > nr_sdhc)) {
@@ -434,8 +434,8 @@ static int xenon_probe_dt(struct platform_device *pdev)
 	priv->sdhc_id = sdhc_id;
 
 	tuning_count = XENON_DEF_TUNING_COUNT;
-	if (!of_property_read_u32(np, "marvell,xenon-tun-count",
-				  &tuning_count)) {
+	if (!device_property_read_u32(dev, "marvell,xenon-tun-count",
+				      &tuning_count)) {
 		if (unlikely(tuning_count >= XENON_TMR_RETUN_NO_PRESENT)) {
 			dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
 				XENON_DEF_TUNING_COUNT);
@@ -444,7 +444,7 @@ static int xenon_probe_dt(struct platform_device *pdev)
 	}
 	priv->tuning_count = tuning_count;
 
-	return xenon_phy_parse_dt(np, host);
+	return xenon_phy_parse_params(dev, host);
 }
 
 static int xenon_sdhc_prepare(struct sdhci_host *host)
@@ -528,12 +528,12 @@ static int xenon_probe(struct platform_device *pdev)
 	if (err)
 		goto err_clk_axi;
 
-	sdhci_get_of_property(pdev);
+	sdhci_get_property(pdev);
 
 	xenon_set_acg(host, false);
 
-	/* Xenon specific dt parse */
-	err = xenon_probe_dt(pdev);
+	/* Xenon specific parameters parse */
+	err = xenon_probe_params(pdev);
 	if (err)
 		goto err_clk_axi;
 
-- 
2.29.0

