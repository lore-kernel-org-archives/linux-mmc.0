Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D41C6379D
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 03:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B7722267
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 03:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="cMaBZWzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgKTD1J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 22:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgKTD1I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 22:27:08 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FCC061A04
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 19:27:07 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a9so11445611lfh.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 19:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4vOJtWxDLHcMBVI7OSOXD/tNJSQ9CFf8jq2Ki+JYg8=;
        b=cMaBZWzTgSd9deY0rYjEu0+tGMyBMQpcIpHdijAJGDBv3w21rHUXXa73WBY55NETyT
         N1rygUtUWo/eB9oTZ7iAJdaJGSAQRNFYgJIR8aDZC1bu0MRW1xSFNyzbyllHlpcvlvj+
         0A/B0sd7tRacbPEXqTKh2oxJUan93/ssRGLDS8gWV5ry5kf1l+Wg1VIRxARnhrRbNDk8
         wKIXExQGGxu/6FfqAajd/F98+SwtcAxf9l3CcY3rOqbgUs1O4Un5Cey/++yi/JZk6qS1
         9yqN8rgAMJU/Sx/2Lf1mm8HSi5CHDIDftpvWctDSumTyGfhzkmyZKbE5ov1OfSii5X01
         ztlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4vOJtWxDLHcMBVI7OSOXD/tNJSQ9CFf8jq2Ki+JYg8=;
        b=rLuiA4vqySpbKyugmIgH+D9kRenLG2bP6LvlIqwtjMg2acZQmuam5IJnN8seuWhgzl
         7YHVyrKox/CY6IcFK/GVJ0R+4+sDvG/Mz307QFd0p6Lqd4UB0sZxw11wQHn85etkagJH
         EeGqRufL0L6aF8gwDmZ/crXtdYl3C5z00MB4VYkaoUEnVJvHo5tRQe7UyGLT4zKtwG/V
         V3iIxj8v1wD7qySlXbI9y7QYMhuSsYfzfGxn0gbUZ+nIv9MwRm6+du/gj3sMNP4y43j+
         NjDUMWUn+tYIeFpJET4eErzfGGW+9TB0hSoT234MsQpG6+/osKs+Kx1M9CBMlbMkKc57
         tv1g==
X-Gm-Message-State: AOAM5332YFJoQ0Wo7k3YQBvG2MteytuizFz7Wy0XfeR9cgXVtkyJt3yD
        +PRJYZLiS69TkOyWIBHjkwXmRg==
X-Google-Smtp-Source: ABdhPJzZU2SW6xSSYAUuV1zconLH6GIxEvVIOZ20+ezIrpxGaHuX5RI8FCZ3MnKstZuex1xohhisHA==
X-Received: by 2002:a05:6512:1050:: with SMTP id c16mr6759719lfb.597.1605842825427;
        Thu, 19 Nov 2020 19:27:05 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id s26sm153647lji.31.2020.11.19.19.27.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 19:27:04 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 3/4] mmc: sdhci-xenon: use clk only with DT
Date:   Fri, 20 Nov 2020 04:26:38 +0100
Message-Id: <20201120032639.24386-4-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201120032639.24386-1-mw@semihalf.com>
References: <20201120032639.24386-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As a preparation for supporting ACPI, modify the driver
to use the clk framework only when booting with DT -
otherwise rely on the configuration done by firmware.
For that purpose introduce also a custom SDHCI get_max_clock
callback.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-xenon.c | 80 +++++++++++++-------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index bfc76b0e3eaa..dfc3b5f62a6d 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -247,6 +247,16 @@ static void xenon_voltage_switch(struct sdhci_host *host)
 	sdhci_readw(host, SDHCI_HOST_CONTROL2);
 }
 
+static unsigned int xenon_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	if (pltfm_host->clk)
+		return sdhci_pltfm_clk_get_max_clock(host);
+	else
+		return pltfm_host->clock;
+}
+
 static const struct sdhci_ops sdhci_xenon_ops = {
 	.voltage_switch		= xenon_voltage_switch,
 	.set_clock		= sdhci_set_clock,
@@ -254,7 +264,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
 	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= xenon_reset,
 	.set_uhs_signaling	= xenon_set_uhs_signaling,
-	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock		= xenon_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
@@ -483,6 +493,7 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
 static int xenon_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
+	struct device *dev = &pdev->dev;
 	struct sdhci_host *host;
 	struct xenon_priv *priv;
 	int err;
@@ -503,25 +514,27 @@ static int xenon_probe(struct platform_device *pdev)
 	 */
 	xenon_replace_mmc_host_ops(host);
 
-	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(pltfm_host->clk)) {
-		err = PTR_ERR(pltfm_host->clk);
-		dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
-		goto free_pltfm;
-	}
-	err = clk_prepare_enable(pltfm_host->clk);
-	if (err)
-		goto free_pltfm;
-
-	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
-	if (IS_ERR(priv->axi_clk)) {
-		err = PTR_ERR(priv->axi_clk);
-		if (err == -EPROBE_DEFER)
-			goto err_clk;
-	} else {
-		err = clk_prepare_enable(priv->axi_clk);
+	if (dev->of_node) {
+		pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
+		if (IS_ERR(pltfm_host->clk)) {
+			err = PTR_ERR(pltfm_host->clk);
+			dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
+			goto free_pltfm;
+		}
+		err = clk_prepare_enable(pltfm_host->clk);
 		if (err)
-			goto err_clk;
+			goto free_pltfm;
+
+		priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
+		if (IS_ERR(priv->axi_clk)) {
+			err = PTR_ERR(priv->axi_clk);
+			if (err == -EPROBE_DEFER)
+				goto err_clk;
+		} else {
+			err = clk_prepare_enable(priv->axi_clk);
+			if (err)
+				goto err_clk;
+		}
 	}
 
 	err = mmc_of_parse(host->mmc);
@@ -561,9 +574,11 @@ static int xenon_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	xenon_sdhc_unprepare(host);
 err_clk_axi:
-	clk_disable_unprepare(priv->axi_clk);
+	if (dev->of_node)
+		clk_disable_unprepare(priv->axi_clk);
 err_clk:
-	clk_disable_unprepare(pltfm_host->clk);
+	if (dev->of_node)
+		clk_disable_unprepare(pltfm_host->clk);
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -574,6 +589,7 @@ static int xenon_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = &pdev->dev;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -582,8 +598,10 @@ static int xenon_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, 0);
 
 	xenon_sdhc_unprepare(host);
-	clk_disable_unprepare(priv->axi_clk);
-	clk_disable_unprepare(pltfm_host->clk);
+	if (dev->of_node) {
+		clk_disable_unprepare(priv->axi_clk);
+		clk_disable_unprepare(pltfm_host->clk);
+	}
 
 	sdhci_pltfm_free(pdev);
 
@@ -620,7 +638,8 @@ static int xenon_runtime_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	clk_disable_unprepare(pltfm_host->clk);
+	if (dev->of_node)
+		clk_disable_unprepare(pltfm_host->clk);
 	/*
 	 * Need to update the priv->clock here, or when runtime resume
 	 * back, phy don't aware the clock change and won't adjust phy
@@ -637,10 +656,12 @@ static int xenon_runtime_resume(struct device *dev)
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
-	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret) {
-		dev_err(dev, "can't enable mainck\n");
-		return ret;
+	if (dev->of_node) {
+		ret = clk_prepare_enable(pltfm_host->clk);
+		if (ret) {
+			dev_err(dev, "can't enable mainck\n");
+			return ret;
+		}
 	}
 
 	if (priv->restore_needed) {
@@ -655,7 +676,8 @@ static int xenon_runtime_resume(struct device *dev)
 		goto out;
 	return 0;
 out:
-	clk_disable_unprepare(pltfm_host->clk);
+	if (dev->of_node)
+		clk_disable_unprepare(pltfm_host->clk);
 	return ret;
 }
 #endif /* CONFIG_PM */
-- 
2.29.0

