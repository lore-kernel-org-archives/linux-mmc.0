Return-Path: <SRS0=GgYk=DA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A31C4727D
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081CA21D41
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600875487;
	bh=l07TPT43InyARN6scqTSWGPtscU6HSFhdJX+X1kj2fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rm12KDUAzwuhFXk5k+308tbr5JtVJ0Za0Oo4oedG67BdMGtSD6tnw7NnWGfMElET1
	 INk+mT5VwIHxvAQ7hDV4GW3Y7gUPwPxWEJqspjulg4vs6O13AZBBIxkUwBZMHj80In
	 WFnqNwH7zspWnlJyZNbFWsPoHmaWEDeWsAUAB2tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIWPiG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIWPiE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Sep 2020 11:38:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E4AA21D7D;
        Wed, 23 Sep 2020 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600875484;
        bh=l07TPT43InyARN6scqTSWGPtscU6HSFhdJX+X1kj2fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQeM+s1HExyF+P5owYL+tElH+HGTWXQomdp6r8SbZv4J0c10DjlBBRtWlmYOar/vE
         m1clvo+xIgczTmirMXWTjW8OaNr9+s6m4LqZAQH4H4pxfCMGgMsSHm/Er1fEafg0S8
         9Mj7aQ5Y7a0w1oGXZXLiDjBcfJgvBZPaKzICLwrg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] mmc: sdhci: fix indentation mistakes
Date:   Wed, 23 Sep 2020 17:37:39 +0200
Message-Id: <20200923153739.30327-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923153739.30327-1-krzk@kernel.org>
References: <20200923153739.30327-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix inconsistent indenting, reported by Smatch:

  drivers/mmc/host/sdhci-esdhc-imx.c:1380 sdhci_esdhc_imx_hwinit() warn: inconsistent indenting
  drivers/mmc/host/sdhci-sprd.c:390 sdhci_sprd_request_done() warn: inconsistent indenting

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-sprd.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 62b3d4767916..fce8fa7e6b30 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1377,7 +1377,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 			 * response, block the tuning procedure or the first command
 			 * after the whole tuning procedure always can't get any response.
 			 */
-			 tmp |= ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
+			tmp |= ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
 			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
 			/*
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 1efaf602c206..58109c5b53e2 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -387,7 +387,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	if (mmc_hsq_finalize_request(host->mmc, mrq))
 		return;
 
-	 mmc_request_done(host->mmc, mrq);
+	mmc_request_done(host->mmc, mrq);
 }
 
 static struct sdhci_ops sdhci_sprd_ops = {
@@ -433,7 +433,7 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 }
 
 static int sdhci_sprd_request_atomic(struct mmc_host *mmc,
-				      struct mmc_request *mrq)
+				     struct mmc_request *mrq)
 {
 	sdhci_sprd_check_auto_cmd23(mmc, mrq);
 
-- 
2.17.1

