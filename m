From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] mmc: sdhci-of-at91: remove a line of dead code
Date: Wed, 16 Sep 2015 09:19:49 +0300
Message-ID: <20150916061949.GA21542@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38160 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbbIPGT7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2015 02:19:59 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org

The goto is correct and the unreachable "return -EINVAL" should be
removed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index d155664..d3df786 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -110,7 +110,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to set gck");
 		goto hclock_disable_unprepare;
-		return -EINVAL;
 	}
 	/*
 	 * We need to check if we have the requested rate for gck because in
