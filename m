Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54531C8300F
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 18:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0002022240
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 18:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbgLBSwj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgLBSwj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 13:52:39 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A8C0617A7
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 10:51:58 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f24so4968716ljk.13
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 10:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3xpXE/TuWKwCPEX3+RhalyC0nSYPCE9cK2LWGjqF2g=;
        b=cBV3lrSqHEhVTmOGmrlqL74YWk850oy735IjRpqT1NU37bWz/pJRqBmLbyj27tO9kd
         1ICwPRyEijphFXkHOSeHrBCxa0J6S43XWDmn0aRvMfA73s0uR1cFyez+gnkpNFBqNk9S
         PbtFBAW6k+5Iw8K/myRNMoJyHM7bEY4E5gMRcO9mniKJDfr3Kip7pB/r/mrBCKi7jsYu
         +OoS2uYmvXxSg4+OuKAoQI+PIlTBo7o+4BUtPhFMiEOU4NwUxvBWLOiRYGO65XC69zDR
         k+shQAiSrLZl4oEyN5XrBO5VIUtzPmQvnNR4H5wKDMoiCWSn2EzoFhvLjAvF5Rn9W8cB
         PrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3xpXE/TuWKwCPEX3+RhalyC0nSYPCE9cK2LWGjqF2g=;
        b=RCzTLGSZzuLSpcTvGGJUC1+CESrJdJVkHyxe9E2DzSTXEa232nSCQEIIW65lU30v5t
         eezaltBoAdDIi5jBU4VeuPAs7xPbsSS6OuphnPA/ZvjC/3ewiotjsTWX3j8H0x37Lpxg
         ziO8Dh2/sDJGloLqqWxJe4Z8asgT6XqNrXjb1ccK22WBOfH9DreCuErqTf2FwXhQULXT
         0T8ZPhOjBuFv3Vrm/j9oyiyl2EN/cq1yEJapxpTB9o6AZt0L8EBlep7KBZ6pZJUShlsw
         vY6qb/1Maj1K9+MP953DUAzjovWIVgXrRTpz0KyCAUH3EDZOTVc2Gjg6ooKW04GH3Obg
         Gk0g==
X-Gm-Message-State: AOAM533zweVWGP0MdqQsQUNQnkd+rnzi14WTEMmavjJFw8sl/8ZAVvMq
        6wMNlOcHeA3LWYaqbmwKfiL0MoUYAu/002mb
X-Google-Smtp-Source: ABdhPJxXHJbBix9Ht7T9XduoA4gE/Nv2ipqExZmdTQD3nsNX98FAKtb1y61hePLw2yUephUORUn58g==
X-Received: by 2002:a2e:9550:: with SMTP id t16mr1763793ljh.117.1606935117035;
        Wed, 02 Dec 2020 10:51:57 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id y134sm666365lff.162.2020.12.02.10.51.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:51:56 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v3 3/4] mmc: sdhci-xenon: use clk only with DT
Date:   Wed,  2 Dec 2020 19:51:17 +0100
Message-Id: <20201202185118.29076-4-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201202185118.29076-1-mw@semihalf.com>
References: <20201202185118.29076-1-mw@semihalf.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-xenon.c | 61 ++++++++++++--------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index bfc76b0e3eaa..cc0fcc646b0e 100644
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
@@ -637,10 +650,12 @@ static int xenon_runtime_resume(struct device *dev)
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
-- 
2.29.0

