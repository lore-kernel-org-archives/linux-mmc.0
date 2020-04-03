Return-Path: <SRS0=RiNA=5T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71EEC2BA15
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 07:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC162080C
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 07:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdqsOxJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389654AbgDCHFw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:05:52 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53357 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbgDCHFv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Apr 2020 03:05:51 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so2609823pjb.3;
        Fri, 03 Apr 2020 00:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=X5441Jy2VbGV6dbzgZxForefu3q50NuP2ovt+obRsE4=;
        b=KdqsOxJj3jIJF8lvmWFsOWJuT3iH0IM4CfLsCNIkcwxFSzinWd8uE3DN7BpJq3d3dN
         IAq7WUozAuBW9Peboj/muqESeRUcFALD9rl6eT7/iR5M2VMbEQRHIIvvcBrw8tDXSTQI
         RcPpfTiS8YmXuFR9oYnxvINs1yiuGWa6z7YKilGNEWbYKqDf8rLcSQUK6O5d6z4fTrTn
         Bdjxo49wflcMvAfa2J2qGe24WHEWHLz8UL1+Wi4+ZdN5F16kS9rtIwoK+me/pjwOP6JH
         +w9jjhQ5NYAEvOXG573xY3NL/TP55I/mJ6CSnaT+PcrG6JmBbw+Y9ECCVTjxJ4ywjqNf
         pZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=X5441Jy2VbGV6dbzgZxForefu3q50NuP2ovt+obRsE4=;
        b=O1fdNSxCMjJIHtvZkpVaeBFdODKj0xi5TdzOy7HNY02OnyskeGOrWnOh/0JvuM+NlO
         NN+xuueSBI//fEOmAYhvLvWcLNaSwPiE6nc4dqjnxRYDbCrZN6GyfKAhyEefIwGNkQ0g
         Azm8tjZm12B4NJ3PJaFAQhv4YGxTHh2mqkM0/nMV+DEUlLUut+32gDotdlBuOsZgxpWR
         AdDZ3CZFs8UpN7IlidlYLNZpGfVKC89RcS7UPpC4yuCs8zczhEtLB9slsOIN0CjUzhRf
         lAzLzAaEh6EoVjONony1g1JpTqxbeLpdsWbHSs4EhyPsXmYFtNfaJilfO93P3Kd2MBNn
         VkPw==
X-Gm-Message-State: AGi0PuawP4WotobUgrfecBAHR9yIfLZe+d6iHv93mJSruzepwdUjB4LG
        XcJst8ZrDetgDA4bow8d9rI=
X-Google-Smtp-Source: APiQypJ5yGpiCWr3p8E88R3xUTg325QYKYDKW2LW0yQyyp0Mt2M+kRtW90UDBzb8GtYaMUPDsShSTQ==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr6390446plb.11.1585897551311;
        Fri, 03 Apr 2020 00:05:51 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u18sm5138701pfl.40.2020.04.03.00.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 00:05:50 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] mmc: host: sdhci-sprd: Implement the request_atomic() API
Date:   Fri,  3 Apr 2020 15:05:28 +0800
Message-Id: <a2cd8923c071881ddd121d24f89639e3ea8e671d.1585896945.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1585896945.git.baolin.wang7@gmail.com>
References: <cover.1585896945.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1585896945.git.baolin.wang7@gmail.com>
References: <cover.1585896945.git.baolin.wang7@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Implement the request_atomic() API for nonremovable cards, that means
we can submit next request in the irq hard handler context to reduce
latency.

Moreover factor out the AUTO CMD23 checking into a separate function
to reduce duplicate code.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 2ab42c5..bc7a8cb 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -406,7 +406,8 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	.request_done = sdhci_sprd_request_done,
 };
 
-static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
+static void sdhci_sprd_check_auto_cmd23(struct mmc_host *mmc,
+					struct mmc_request *mrq)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
@@ -422,10 +423,23 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	    mrq->sbc && (mrq->sbc->arg & SDHCI_SPRD_ARG2_STUFF) &&
 	    (host->flags & SDHCI_AUTO_CMD23))
 		host->flags &= ~SDHCI_AUTO_CMD23;
+}
+
+static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	sdhci_sprd_check_auto_cmd23(mmc, mrq);
 
 	sdhci_request(mmc, mrq);
 }
 
+static int sdhci_sprd_request_atomic(struct mmc_host *mmc,
+				      struct mmc_request *mrq)
+{
+	sdhci_sprd_check_auto_cmd23(mmc, mrq);
+
+	return sdhci_request_atomic(mmc, mrq);
+}
+
 static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -561,6 +575,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto pltfm_free;
 
+	if (!mmc_card_is_removable(host->mmc))
+		host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
+	else
+		host->always_defer_done = true;
+
 	sprd_host = TO_SPRD_HOST(host);
 	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
 
@@ -654,8 +673,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_host;
 
-	host->always_defer_done = true;
-
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
-- 
1.9.1

