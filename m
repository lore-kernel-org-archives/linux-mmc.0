Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D5C2BA83
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA30A2082F
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 04:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVG/j0Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBLEOW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:14:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37443 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLEOV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 23:14:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so506740pgl.4;
        Tue, 11 Feb 2020 20:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=z2rCwKhMPk5QQnDbc8O1zs9yu0JRS1NKgiYNty4j9ao=;
        b=RVG/j0CfXEixN8CZ8SAYi908LXoH2BF8kl/2M/cr26tvVqTr/Kt2/b1wGtv7xy9o6s
         CxJvczDWc+QdCVKB7RynwjiqUUNqYHzRtnxnmNUZ+j3Cv5dDTruoM65own1507cpu58t
         L4JEG5eex/hZxthjXmFEN4w5v6o8TkMLiL4/ODwvZjnSVkU3uJXCHjO4f/h4/P+XQntC
         jIfmFpc3uNpiLKyM3nwBhteCW7ISNoxsB04TvK1Q21ShcWMFAtInfPpfV1ggMVWdIqBE
         DXmrnk6y0jXhJTx2fwU6Bm3LAKnrCjzNOUu+GjrS/NSo9r0mIXrrX2/ddS7mJ21lMMyD
         VP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=z2rCwKhMPk5QQnDbc8O1zs9yu0JRS1NKgiYNty4j9ao=;
        b=GaTvxpRUmJdK5LK91CGF+AcPT8rt3qYuztSKCChGDx2ivvg4Vs8y+v8jr1PjBtDFtV
         wJ7a7gSrOi7v4V/Ur5F61Xv49SHejYgsqsvdVjWzo5yTrMu1yYoEPsWamkgSbGSsauOI
         dg/utwacN4QxlsUoNznujB2A0rBmA84sCPpnMbbJuDiJav7UoAQnzHmTL+E+vF+T+JNX
         GZ7v3K/DZFuALk2bD7oWH4SDStejLmViDR3xbpm4WlHNop3dWoFcQfchDm+o5wXG0mnf
         jEi6L02XThRwJ2fvriTbRScZ2ZPEq08gpu9Ubt0xJyuB+XiT/rLrn++3qfLKfzUbMHQM
         W9Mw==
X-Gm-Message-State: APjAAAVyx9WeZjkeCNYXugw9Dt13StL+R8uyoeoIx1Jowp5Jd5yGf4MY
        Vyn7yWAWzLCAYtp9uKw0WUM=
X-Google-Smtp-Source: APXvYqwBjdUCMQgPuJDDN3KIHiIyA2NWs27qtfj+B0Gt1zrb5E0hQOc+jlLjC1f577l+T5IMfnDchQ==
X-Received: by 2002:a63:691:: with SMTP id 139mr10851354pgg.325.1581480859201;
        Tue, 11 Feb 2020 20:14:19 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm6424762pfq.27.2020.02.11.20.14.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Feb 2020 20:14:18 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/5] mmc: host: sdhci-sprd: Add software queue support
Date:   Wed, 12 Feb 2020 12:13:00 +0800
Message-Id: <f629b32943aae9e30ffa17acf4af06c270417001.1581478569.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
References: <cover.1581478568.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1581478568.git.baolin.wang7@gmail.com>
References: <cover.1581478568.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Add software queue support to improve the performance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 65d3966..3ea45be 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -645,6 +645,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_HSQ
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d07b979..d346223 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "mmc_hsq.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -379,6 +380,16 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_sprd_request_done(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	/* Validate if the request was from software queue firstly. */
+	if (mmc_hsq_finalize_request(host->mmc, mrq))
+		return;
+
+	 mmc_request_done(host->mmc, mrq);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -392,6 +403,7 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 	.get_ro = sdhci_sprd_get_ro,
+	.request_done = sdhci_sprd_request_done,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -521,6 +533,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_sprd_host *sprd_host;
+	struct mmc_hsq *hsq;
 	struct clk *clk;
 	int ret = 0;
 
@@ -631,6 +644,18 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
+	if (!hsq) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = mmc_hsq_init(hsq, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
+	host->always_defer_done = true;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -689,6 +714,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	mmc_hsq_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -717,6 +743,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	mmc_hsq_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5

