From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH] mmc: sdhci: msm: Boost controller core clock
Date: Fri, 26 Jun 2015 14:16:57 +0300
Message-ID: <1435317417-369-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37461 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbFZLRE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 07:17:04 -0400
Received: by wicgi11 with SMTP id gi11so14814604wic.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2015 04:17:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

Ensure SDCC is working with maximum clock otherwise card
detection could be extremely slow, up to 7 seconds.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4a09f76..b2556bc 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -489,6 +489,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto pclk_disable;
 	}

+	/* Vote for maximum clock rate for maximum performance */
+	ret = clk_set_rate(msm_host->clk, INT_MAX);
+	if (ret)
+		dev_warn(&pdev->dev, "core clock boost falied\n");
+
 	ret = clk_prepare_enable(msm_host->clk);
 	if (ret)
 		goto pclk_disable;
--
1.9.1

