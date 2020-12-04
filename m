Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE889C4167B
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA0722B43
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgLDRTb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbgLDRTb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 12:19:31 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1352C061A55
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 09:18:02 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so7465732ljk.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8YfEG9oKKaMqVPYw/jtrgZil+AeegBiwDuRLZB+MuA=;
        b=MK7cjZibFFFs9z74Z6tNIwRPvfrs2yZy4unB5YGFbojgD5aAaJfZUHRGpKcJpanbPA
         Y4/PWHhaP+EZZijbpas281WwGDlfh13Tv8jaO+7f/k0Ym+legwAgSYz89Kk1+R7O02Tm
         o1OUtrnSuCa808WBeaM8cMQjXQcPn/tcA+O46fV2mnDrrb8azFmZPkESaXDwxT7NZbYk
         cywgv0Nc8H36TLsDFQoRADXRiJ+huanpr5xMwlEIfRJFAXjoEuc7V9YRXZH1JcQN2N4H
         A0i9ynxHdNmWx1vYAZ10u8uaXroqUybJdbhP3rD6uay336yTHN+FNzPLQ4t14aMfzd1a
         RVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8YfEG9oKKaMqVPYw/jtrgZil+AeegBiwDuRLZB+MuA=;
        b=H6tf093yGJ3M1TrR9qFb0Qgs73XAwaIMo+bt8XTb4tyyA37/ZXSuZyKXKHoBsV2SoI
         N4UflQ1mCmAWgXIEJ8/VbnEBluJtwxtBT0cmyDErQqRJ+p1chB+St7BZzUcRMBFxHiv0
         7xh/IeapcXeeXd82buCIoH6orpSu8PBlB0CVqkqldYVsrQLHoIcQ9Yj/34b5pdkAakXO
         OtyuXeiQFS7O7+Oj6U8dOXIdyzlzIB0+g7VTkD1bp/oiweF73pxWmYIJL0NlFbd/R3H0
         4N59oe0rak+Bqss3YMmbIzzqB+1EurMVBAcfqZNuLxO3944ylL4Nl93NmQPv2Hu15nX0
         e7qg==
X-Gm-Message-State: AOAM5315tI6pV3kVjEIFjy/G0dyC/23VR1v/7RNWycbujJj5q4LbO8Ws
        viCaLAZAEqXVmHkZ072Enex04EvP7avM0QX2
X-Google-Smtp-Source: ABdhPJx3kvdC1ut6g2A4yPQvu7ecf+GCMpo/W97CIyeqcJ7QLEGrVXy878wJLs3NliFOF+hhqXTwWw==
X-Received: by 2002:a2e:8504:: with SMTP id j4mr3805749lji.169.1607102281438;
        Fri, 04 Dec 2020 09:18:01 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id w12sm1919802ljo.67.2020.12.04.09.18.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:18:00 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v4 3/4] mmc: sdhci-xenon: use clk only with DT
Date:   Fri,  4 Dec 2020 18:16:25 +0100
Message-Id: <20201204171626.10935-4-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201204171626.10935-1-mw@semihalf.com>
References: <20201204171626.10935-1-mw@semihalf.com>
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
 drivers/mmc/host/sdhci-xenon.c | 51 ++++++++++++--------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index bfc76b0e3eaa..7d9335857715 100644
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
-- 
2.29.0

